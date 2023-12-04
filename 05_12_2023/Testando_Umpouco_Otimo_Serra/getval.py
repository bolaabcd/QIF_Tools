# Gets value from file, given alpha and n (exponential decay)


alpha = float(input())
n = int(input())
filename = input()

fil = open(filename,'r')
lins = fil.readlines()
fil.close()

tot = 0
i = 0
for lin in lins:
    if lin == '\n':
        continue
    tot += float(lin[:-1])*alpha**i
    i = i+1
print(tot)
