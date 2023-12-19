n = input()
arq = open(n + ".txt",'r')
arr = list(map(lambda x : int(x), arq.readlines()))
arq.close()


ar3 = set()
ar2 = 0
k = 1
for i in range(len(arr)):
    ar2 += k*arr[i]
    k *= 2
    if k == 2**13:
        ar3.add(ar2)
        ar2 = 0
        k = 1

print(ar3)

# Results:
# echo 2 | python3 a.py
# echo 3 | python3 a.py
# echo 4 | python3 a.py
# echo 5 | python3 a.py
# echo 6 | python3 a.py

# All of these resulted in 6007, which is the greedy adversary behaviour!
