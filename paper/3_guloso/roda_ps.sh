echo -ne '' > /tmp/plota.py
echo -ne '' > /tmp/recargas.txt

colors=('gray' 'blue' 'red' 'green' 'orange' 'black' 'pink' 'purple' 'magenta')
steps=(7 7)
vals1=(0 1 )
vals2=(1 0 )
j=0   
i=0
bash roda_p.sh "${vals1[$i]}" "${vals2[$i]}" ${steps[$j]}
cat plota_p.py | sed "s/PREFIX/conv0.1/g" | sed "s/PRREFIX/always_apply/g" | sed "s/COLOR/${colors[$j]}/g" | sed "s/AMTSTEPS/${steps[$j]}/g" | sed "s/VALUE/0.1/g" >> /tmp/plota.py
echo "${vals1[$i]}_${vals2[$i]}" >> /tmp/recargas.txt
cat /tmp/aplics${vals1[$i]}_${vals2[$i]}.txt >> /tmp/recargas.txt
j=$(expr $j + 1)

i=1
bash roda_p2.sh "${vals1[$i]}" "${vals2[$i]}" ${steps[$j]}
cat plota_p.py | sed "s/PREFIX/conv1.0/g" | sed "s/PRREFIX/never_apply/g" | sed "s/COLOR/${colors[$j]}/g" | sed "s/AMTSTEPS/${steps[$j]}/g" | sed "s/VALUE/0.1/g" >> /tmp/plota.py
echo "${vals1[$i]}_${vals2[$i]}" >> /tmp/recargas.txt
cat /tmp/aplicsconv${vals1[$i]}.${vals2[$i]}.txt >> /tmp/recargas.txt
j=$(expr $j + 1)



# UNTIL WHERE PLOT GOES (MANUAL):
echo 'plt.xlim(-0.2,7.2)' >> /tmp/plota.py
echo 'plt.ylim(-0.01,1.01)' >> /tmp/plota.py



echo 'plt.legend(loc="upper right")' >> /tmp/plota.py
echo 'plt.savefig("plot.svg")' >> /tmp/plota.py

python3 /tmp/plota.py
