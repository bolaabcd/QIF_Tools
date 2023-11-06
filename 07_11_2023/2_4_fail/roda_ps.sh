echo -ne '' > /tmp/plota.py
echo -ne '' > /tmp/recargas.txt

colors=('gray' 'blue' 'red' 'green' 'orange' 'black' 'pink' 'purple' 'magenta')
steps=(10  10   10    10    10     10     10     10  10)
vals1=(0   1    2     3     4      5      6      7   8 )
vals2=(8   8    8     8     8      8      8      8   8 )
j=0   
for i in $(seq 0 8); do
    bash roda_p.sh "${vals1[$i]}" "${vals2[$i]}" ${steps[$j]}
    cat plota_p.py | sed "s/PREFIX/${vals1[$i]}_${vals2[$i]}/g" | sed "s/COLOR/${colors[$j]}/g" | sed "s/AMTSTEPS/${steps[$j]}/g" >> /tmp/plota.py
    echo "${vals1[$i]}_${vals2[$i]}" >> /tmp/recargas.txt
    cat /tmp/aplics${vals1[$i]}_${vals2[$i]}.txt >> /tmp/recargas.txt
    j=$(expr $j + 1)
done


# UNTIL WHERE PLOT GOES (MANUAL):
echo 'plt.xlim(1,11)' >> /tmp/plota.py



echo 'plt.legend(loc="upper left")' >> /tmp/plota.py
echo 'plt.savefig("plot.svg")' >> /tmp/plota.py

python3 /tmp/plota.py
