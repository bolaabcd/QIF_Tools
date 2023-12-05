import matplotlib.pyplot as plt

n = 5
nsteps = 10
AMTSTEPS = nsteps
def faz(alpha, alphat, color):
    valsfile = "log_10_5_"+alphat+"/vals.txt"
    valsfile = open(valsfile,'r')
    stepsfile = "log_10_5_"+alphat+"/steps.txt"
    stepsfile = open(stepsfile,'r')

    vals = list(map(lambda x: float(x), filter(lambda x: x != '\n', valsfile.readlines())))
    valsfile.close()
    steps = list(map(lambda x: int(x), filter(lambda x: x != '\n', stepsfile.readlines())))
    stepsfile.close()

    label = "a_"+str(alpha)+"_n_"+str(n)

    for x,v in enumerate(steps):
        if v == 1:
            x = x + 1
            plt.vlines(x,vals[x-1]-0.04,vals[x-1]+0.04,color=f"{color}")
    plt.plot(range(1,len(vals)+1), vals, color = f"{color}", label = f'{label}')

print("0/6")
faz(0.0, "0.0", 'blue')
print("1/6")
faz(0.1, "0.1", 'red')
print("2/6")
faz(0.5, "0.5", 'green')
print("3/6")
faz(0.8, "0.8", 'orange')
print("4/6")
faz(0.9, "0.9", 'purple')
print("5/6")
faz(1.0, "1.0", 'magenta')
print("6/6")


plt.ylim(0,2.1)
plt.xlim(1,AMTSTEPS+1)
minor_x = list(range(1,AMTSTEPS+1))
minor_y = [2.1*i/50 for i in range(0,51)]
plt.xticks(minor_x,minor=True)
plt.yticks(minor_y,minor=True)
major_x = [5*i for i in range(AMTSTEPS//5+1)]
major_y = [2.1*i/10 for i in range(0,11)]
plt.xticks(major_x,minor=False)
plt.yticks(major_y,minor=False)
plt.grid(which='minor', alpha=0.5, linestyle=':')
plt.grid(which='major', alpha=0.7, linestyle='--')

plt.legend(loc="upper left")

plt.savefig("expdec_vals.svg")

