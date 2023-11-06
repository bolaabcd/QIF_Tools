#!/bin/sh -x

# Garanta que o primeiro argumento eh p (a chance que vai substituir VAL), e que os arquivos ini.kf, mid.kf, fincom.kf e finsem.kf tem os codigos adequados! mid.kf eh onde deve estar o VAL, e vamos tentar agir pra minimizar (gulosamente) a vulnerabilidade da variavel y. Usamos 7 casas decimais de precisao. O segundo argumento deve ser o sufixo dado pros nomes dos arquivos, e o terceiro deve ser a quantidade de passos.

arqini='ini.kf'
arqmid='mid.kf'
arqfincom='fincom.kf'
arqfinsem='finsem.kf'
pvalnum=$1 #numerador
pvaldenom=$2
suf="$pvalnum""_$pvaldenom"

cp $arqmid /tmp/$arqmid
cp $arqini /tmp/$arqini

echo -ne '' > /tmp/sem.txt
echo -ne '' > /tmp/com.txt
echo -ne '' > /tmp/ans$suf.txt
echo -ne '' > /tmp/aplics$suf.txt

i=1
i2=0
amt=$3 # 50 por exemplo
for j in $(seq 1 $amt); do
    echo -ne "\r$j/$amt"
    x=$(python3 -c "print('{:.2f}'.format((0.3)**$i))")
    x2=$(python3 -c "print('{:.2f}'.format((0.3)**$i2))")

    cp /tmp/$arqini /tmp/com$j.kf
    cat /tmp/$arqmid | sed "s/VAL/$x2/g" >> /tmp/com$j.kf
    cat $arqfincom | sed "s/NUMCHANCEUNI/$pvalnum/g" | sed "s/DENOMCHANCEUNI/$pvaldenom/g" >> /tmp/com$j.kf
    echo "" >> /tmp/com$j.kf
    echo "UVA = 1;" >> /tmp/com$j.kf
    cabal new-run Kuifje-compiler /tmp/com$j.kf > /tmp/com$j.txt
    cat /tmp/com$j.txt | grep -A1 'Vuln y hyper' | grep -o '[0-9.]*' >> /tmp/com.txt

    cp /tmp/$arqini /tmp/sem$j.kf
    cat /tmp/$arqmid | sed "s/VAL/$x/g" >> /tmp/sem$j.kf
    cat $arqfinsem >> /tmp/sem$j.kf
    echo "" >> /tmp/sem$j.kf
    echo "UVA = 1;" >> /tmp/sem$j.kf
    cabal new-run Kuifje-compiler /tmp/sem$j.kf > /tmp/sem$j.txt
    cat /tmp/sem$j.txt | grep -A1 'Vuln y hyper' | grep -o '[0-9.]*' >> /tmp/sem.txt
    
    vcom=$(tail -1 /tmp/com.txt)
    vsem=$(tail -1 /tmp/sem.txt)

    if test $(python3 -c "print(1 if ($vcom < $vsem) else 0)") -eq 1; then
        # Aplica strat
        cat $arqmid | sed "s/VAL/$x2/g" >> /tmp/$arqini
        cat $arqfincom | sed "s/NUMCHANCEUNI/$pvalnum/g" | sed "s/DENOMCHANCEUNI/$pvaldenom/g" >> /tmp/$arqini
        tail -1 /tmp/com.txt >> /tmp/ans$suf.txt
        echo $j >> /tmp/aplics$suf.txt
        i=0;
        i2=-1;
    else 
        # Prossegue
        tail -1 /tmp/sem.txt >> /tmp/ans$suf.txt
    fi
    i=$(expr 1 + $i)
    i2=$(expr 1 + $i2)
done

echo ''
echo "$amt"' passos rodados, olhe em "'"/tmp/ans$suf.txt"'" as vulnerabilidades e em "'"/tmp/aplics$suf.txt"'" pra saber em que passos foi aplicada a strat.'
