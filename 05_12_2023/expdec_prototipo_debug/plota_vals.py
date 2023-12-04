import matplotlib.pyplot as plt
alpha = float(input())
n = int(input())
nsteps = int(input())
valsfile = input()
valsfile = open(valsfile)
stepsfile = input()
stepsfile = open(stepsfile)
plotfolder = input()

vals = list(map(lambda x: float(x), filter(lambda x: x != '\n', valsfile.readlines())))
valsfile.close()
steps = list(map(lambda x: int(x), filter(lambda x: x != '\n', stepsfile.readlines())))
stepsfile.close()

AMTSTEPS = nsteps
color = 'blue'
label = 'exp_dec'

plt.ylim(0,1)
plt.xlim(1,AMTSTEPS+1)
minor_x = list(range(1,AMTSTEPS+1))
minor_y = [i/50 for i in range(0,51)]
plt.xticks(minor_x,minor=True)
plt.yticks(minor_y,minor=True)
major_x = [5*i for i in range(AMTSTEPS//5+1)]
major_y = [i/10 for i in range(0,11)]
plt.xticks(major_x,minor=False)
plt.yticks(major_y,minor=False)
plt.grid(which='minor', alpha=0.5, linestyle=':')
plt.grid(which='major', alpha=0.7, linestyle='--')
plt.plot(range(1,len(vals)+1), vals, color = f"{color}", label = f'alpha_{alpha}_n_{n}_name_{label}')
for x,v in enumerate(steps):
    if v == 1:
        x = x + 1
        plt.vlines(x,vals[x-1]-0.01,vals[x-1]+0.01,color=f"{color}")

plt.savefig(plotfolder+"/vals.svg")
