echo -ne '' > /tmp/plota.py
echo -ne '' > /tmp/recargas.txt

colors=('gray' 'blue' 'red' 'green' 'orange' 'black' 'pink' 'purple')
steps=(50  50   50    25    25     25     25     50)
vals1=(1   1    1     1     1      1      1      0 )
vals2=(1   2    4     8     16     32     64     1 )
j=0   
for i in $(seq 0 7); do
    bash roda_p.sh "${vals1[$i]}" "${vals2[$i]}" ${steps[$j]}
    cat plota_p.py | sed "s/PREFIX/${vals1[$i]}_${vals2[$i]}/g" | sed "s/COLOR/${colors[$j]}/g" | sed "s/AMTSTEPS/${steps[$j]}/g" >> /tmp/plota.py
    echo "${vals1[$i]}_${vals2[$i]}" >> /tmp/recargas.txt
    cat /tmp/aplics${vals1[$i]}_${vals2[$i]}.txt >> /tmp/recargas.txt
    j=$(expr $j + 1)
done

echo 'plt.legend(loc="upper left")' >> /tmp/plota.py
echo 'plt.savefig("plot.svg")' >> /tmp/plota.py
#echo 'plt.show()' >> /tmp/plota.py

python3 /tmp/plota.py
