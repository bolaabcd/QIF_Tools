#!/bin/sh -x

# Computes exponential decay with alpha^i from i=1 to i=n, using the n choices provided.

if test \( "$#" -ne 7 \) -o \( ! -f "$5" \) -o \( ! -f "$6" \) -o \( ! -f "$7" \) -o \( -z "$1" \) -o \( -z "$2" \) -o \( -z "$3" \) -o \( -z "4" \); then
  echo "Usage: $0 <alpha> <number of elements in exponential decay> <choices to make: 0 for not-strategy, 1 for strategy> <number of simulation, for naming purposes, should reflect the choices: choices 0000 implies number 0, choices 1000 implies number 1, choices 0100 implies number 2, and so on> <prefile.kf> <channel.kf> <strategy.kf>" >&2
  exit 1
fi

alpha=$1;
n=$2;
choices=$3; # As one string, space separated!
number=$4; # For naming purposes. 0000 should be 0, 1000 should be 1, 0100 should be 2!
prefile=$5;
chanfile=$6
stratfile=$7

cp $prefile /tmp/sim$number.kf
echo "" >> /tmp/sim$number.kf
chans=0;

concat_code() {
    if test $1 -eq 1; then
        cat $stratfile | sed "s/NUMCHANCEUNI/$pvalnum/g" | sed "s/DENOMCHANCEUNI/$pvaldenom/g" >> /tmp/sim$number.kf
        echo "" >> /tmp/sim$number.kf
    else
        x=$(python3 -c "print('{:.7f}'.format((1-1/16)**$2))")
        cat $chanfile | sed "s/VAL/$x/g" >> /tmp/sim$number.kf
        echo "" >> /tmp/sim$number.kf
    fi
}

echo -n '' > /tmp/vulns$number.txt

npre=$(cat /tmp/pre.txt | wc -l);
i=0;
chans=0;
for choice in $(cat /tmp/pre.txt) $choices; do # 0 == not strat, 1 == strat
    x=$(python3 -c "print('{:.7f}'.format((1-1/16)**$chans))")
    chans=$(expr $chans + 1);
    if test $choice -eq 1; then
        concat_code 0 $chans;
        chans=0;
        concat_code 1 ;
    fi;
    if test $i -ge $npre; then  # ignore the first $npre additions
        cp /tmp/sim$number.kf /tmp/simtmp$number.kf
        if test $chans -ne 0; then
            concat_code 0 $chans;
        fi;
        if test $i -eq $npre; then
            cp /tmp/sim$number.kf /tmp/simini$number.kf
        fi
        cabal new-run Kuifje-compiler /tmp/sim$number.kf > /tmp/sim$number.txt
        cp /tmp/simtmp$number.kf /tmp/sim$number.kf
        rm /tmp/simtmp$number.kf
        cat /tmp/sim$number.txt | grep -A1 'Vuln y hyper' | grep -o '[0-9.]*' >> /tmp/vulns$number.txt
    fi;
    i=$(expr 1 + $i);
done
if test $chans -ne 0; then
    concat_code 0 $chans;
    chans=0;
fi

if test $i -eq $(expr $n + $npre); then
    echo 'Success!'
    :
else
    echo "Something went wrong... Should have $n choices but only $(expr $i - $npre) were given"
fi

val=$(echo "$alpha"\\n"$n"\\n"/tmp/vulns$number.txt" | python3 getval.py)
vul1=$(cat /tmp/vulns$number.txt | head -1)
vullast=$(cat /tmp/vulns$number.txt | tail -1)
echo "$vullast $val $vul1 $number $n $choices" >> /tmp/vulnsall.txt

rm /tmp/vulns$number.txt
# rm /tmp/sim$number.kf
# rm /tmp/simini$number.kf
# rm /tmp/sim$number.txt
# rm /tmp/vulnsall.txt
# Remove these after running all.

# /tmp/pre.txt should exists and either be empty or have one number (0 or 1) per line.
# /tmp/pre.txt should NOT have and extra endline at the end of the file!!!!
