# Gets value from file, given alpha and n (exponential decay)


alpha = float(input())
n = int(input())
filename = input()

fil = open(filename,'r')
lins = fil.readlines()
fil.close()

worst = -1
i = 0
for lin in lins:
    if lin == '\n':
        continue
    worst = max(worst,float(lin[:-1]))
    i = i+1
print(worst)
