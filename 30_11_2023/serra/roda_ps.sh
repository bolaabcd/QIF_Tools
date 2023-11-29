echo -ne '' > /tmp/plota.py
echo -ne '' > /tmp/recargas.txt

colors=('gray' 'blue' 'red' 'green' 'orange' 'black' 'purple' 'magenta' 'pink')
steps=(76   57   42   31   23   10   109)
vals1=(8    7    6    5    4    3    9  )
vals2=(10   10   10   10   10   10   10 )
j=0   
for i in $(seq 0 6); do
    bash roda_p.sh "${vals1[$i]}" "${vals2[$i]}" ${steps[$j]}
    cat plota_p.py | sed "s/PREFIX/${vals1[$i]}_${vals2[$i]}/g" | sed "s/COLOR/${colors[$j]}/g" | sed "s/AMTSTEPS/${steps[$j]}/g" >> /tmp/plota.py
    echo "${vals1[$i]}_${vals2[$i]}" >> /tmp/recargas.txt
    cat /tmp/aplics${vals1[$i]}_${vals2[$i]}.txt >> /tmp/recargas.txt
    j=$(expr $j + 1)
done


# UNTIL WHERE PLOT GOES (MANUAL):
echo 'plt.xlim(0,111)' >> /tmp/plota.py



echo 'plt.legend(loc="upper left")' >> /tmp/plota.py
echo 'plt.savefig("plot.svg")' >> /tmp/plota.py

python3 /tmp/plota.py
