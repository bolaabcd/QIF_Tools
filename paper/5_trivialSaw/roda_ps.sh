echo -ne '' > /tmp/plota.py
echo -ne '' > /tmp/recargas.txt

colors=('gray' 'blue' 'red' 'green' 'orange' 'black' 'pink' 'purple' 'magenta')
steps=(35) 
vals1=(9 ) 
vals2=(8 ) 
j=0   
i=0
bash roda_p.sh "${vals1[$i]}" "${vals2[$i]}" ${steps[$j]}
cat plota_p.py | sed "s/PREFIX/${vals1[$i]}_${vals2[$i]}/g" | sed "s/PRREFIX/alternate/g" | sed "s/VALUE/0.5/g" | sed "s/COLOR/${colors[$j]}/g" | sed "s/AMTSTEPS/${steps[$j]}/g" >> /tmp/plota.py
echo "${vals1[$i]}_${vals2[$i]}" >> /tmp/recargas.txt
cat /tmp/aplics${vals1[$i]}_${vals2[$i]}.txt >> /tmp/recargas.txt
j=$(expr $j + 1)


# UNTIL WHERE PLOT GOES (MANUAL):
echo 'plt.xlim(-0.35,35.35)' >> /tmp/plota.py
echo 'plt.ylim(-0.01,1.01)' >> /tmp/plota.py



echo 'plt.legend(loc="upper left")' >> /tmp/plota.py
echo 'plt.savefig("plot.svg")' >> /tmp/plota.py

python3 /tmp/plota.py
