from matplotlib import pyplot as plt

muds = open('/tmp/aplicsPREFIX.txt','r')
vulns = open('/tmp/ansPREFIX.txt','r')

poss = list(map(lambda x: int(x),filter(lambda s : s != '', muds.read().split('\n'))))
muds.close()
vals = [VALUE] + list(map(lambda x: float(x),filter(lambda s : s != '', vulns.read().split('\n'))))
vulns.close()

plt.ylim(-0.03,1.03)
plt.xlim(-0.3,AMTSTEPS+0.3)
minor_x = list(range(0,AMTSTEPS+1))
minor_y = [i/50 for i in range(0,51)]
plt.xticks(minor_x,minor=True)
plt.yticks(minor_y,minor=True)
major_x = [5*i for i in range(AMTSTEPS//5+1)]
major_y = [i/10 for i in range(0,11)]
plt.xticks(major_x,minor=False)
plt.yticks(major_y,minor=False)
plt.grid(which='minor', alpha=0.5, linestyle=':')
plt.grid(which='major', alpha=0.7, linestyle='--')
plt.plot(range(0,len(vals)),vals,color='COLOR',label='PREFIX')
#plt.xlim(-0.3,AMTSTEPS+0.3)
#for x in poss:
#    plt.vlines(x,vals[x]-0.01,vals[x]+0.01,color='COLOR')
#plt.legend(loc="upper left")
#plt.savefig("plot.png")
#plt.show()
