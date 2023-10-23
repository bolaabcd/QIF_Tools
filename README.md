# Simple QIF Tools

## convert.cpp
"convert.cpp" simply converts the hyper output format of Kuifje to the following format:

The first line has the number N of variables. For each variable we will have a hyper. Then we'll have N blocks of the following format:

- First line has the variable name
- Second line has a space-separated pair "n m", number of inners and number of elements per inner.
- Then we have m lines, with the names of the inner elements (the possible values for the secrets)
- Then we have n lines, each with m space-separated values representing the probabilities of each inner (each line is the vector of an inner).

Example:

```
> Variable pwd2 hyper
0.199410   0.731576   R 0.0
           0.053263   R 1.0
           0.015389   R 2.0
           0.102233   R 3.0
           0.097538   R 4.0
0.250485   0.776023   R 0.0
           0.044444   R 1.0
           0.012841   R 2.0
           0.085305   R 3.0
           0.081387   R 4.0
0.188519   0.844951   R 0.0
           0.030766   R 1.0
           0.008889   R 2.0
           0.059053   R 3.0
           0.056341   R 4.0
0.172141   0.858620   R 0.0
           0.028054   R 1.0
           0.008106   R 2.0
           0.053846   R 3.0
           0.051374   R 4.0
0.189444   0.955420   R 0.0
           0.008846   R 1.0
           0.002556   R 2.0
           0.016979   R 3.0
           0.016199   R 4.0
> condEntropy bayesVuln pwd2 hyper
0.828358

```

becomes
```
1
pwd2
5 5
R 0.0
R 1.0
R 2.0
R 3.0
R 4.0
0.199410 0.250485 0.188519 0.172141 0.189444 
0.731576 0.053263 0.015389 0.102233 0.097538 
0.776023 0.044444 0.012841 0.085305 0.081387 
0.844951 0.030766 0.008889 0.059053 0.056341 
0.858620 0.028054 0.008106 0.053846 0.051374 
0.955420 0.008846 0.002556 0.016979 0.016199 
```


## vulnerability.cpp
This simply computes the manhattan distance vulnerability (limited guesses version).

Here "distribution-strategy" means a strategy that is a distribution: set the value of the secret according to the distribution, regardless of anything else (in particular this ignores the last value of the password when computing the next one).

The input format for this program is the output of "convert.cpp" followed by the number of distribution-strategies, the number of secrets per distribution, and the distributions themselves. Example with 5 possible strategy-distributions on four passwords (the first one gives equal probability to all passwords, and the third always sets the password to 0):

```
5 4
0.25 0.25 0.25 0.25
0.35 0.35 0.05 0.25
1.00 0.00 0.00 0.00
0.50 0.15 0.10 0.25
0.33 0.33 0.33 0.01
```

This is assuming that the name of the strategy variable will be "strat", and that the adversary can only guess by using one of the possible distribution-strategies. The strategy gain will then be the manhattan distance between strategies, instead of the bayesian gain function (which is the default of Kuifje).


## greedy\_adversary\_simulator
These are scripts for emulating best choices choices we can make against a greedy adversary, and then plot the results. 

Keep in mind that Kuifje is at this moment not in its final version, so there might be some errors. Also, if you decide to change something make sure all the `.kf` code really execute, as the Kuifje Compiler at this point might not print any errors even if something went worng.

### greedy\_adversary\_simulator/roda\_ps.sh
This is the script that runs everything. It requires all other files in `greedy\_adversary\_simulator` that are listed here. We will explay what all these do at once here, some of them are copied and then modified by this script.

```sh
colors=('gray' 'blue' 'red' 'green' 'orange' 'black' 'pink' 'purple')
steps=(50  50   50    25    25     25     25     50)
vals1=(1   1    1     1     1      1      1      0 )
vals2=(1   2    4     8     16     32     64     1 )
```

These variables control the result. Every column will result in one graph in the final plot. 

`colors` should be self-explanatory.
`steps` specify how many steps of applying the strategy will be simulated.
`vals1` specify the first value we are going to use as a parameter.
`vals2` specify the second value we are going to use as a parameter.

For each pair `val1,val2`, this will make a Kuifje program that is composed of `ini.kf`, concatenated with `mid.kf` with VAL replaced by the probability that nothing will leak, and with `fincom.kf` at the end and also with `fimsem.kf` (the names are in portuguese, "fim" means end, "com" means "with" and "sem" means "without") at the end, which will see what happens with and without applying the strategy at the end. In the file `fimcom.kf`, `NUMCHANCEUNI` will be replaced by the value of `val1` and `DENOMCHANCEUNI` by the value `val2`, as these a re meant to be parameters for exploring the behaviour of different strategies.

If applying the strategy decreases the vulnerability, then we want to apply it, otherwise we don't.

If we want to apply it, then we edit the `ini.kf` file for the channel to leak once and then the strategy be applied, after whatever `ini.kf` was already doing, and repeat everything to simulate one more step of the simulation. 

If we don't want to apply the strategy, we just proceed to the next step, increasing the counter for the number of times to leak the channel from x=1 to x=2: VAL is computed as the probability that nothing will leak given that the channel has been applied x times (in parallel). Currently, the channel we are using has `15/16` probability of not leaking anything after one time step and `1/16` probability of revealing the secret, thus having `(15/16)^x` probability of not leaking anything after `x` parallel compositions.

This repeats untill the number of time steps specified are completed, and the script saves the final secret vulnerability at each step in a file.

Finally, the evolution of the vulnerabilities are ploted in one graph per pair `val1,val2` specified, with the colors specified.

### greedy\_adversary\_simulator/roda\_p.sh
This is the code that simulates the decisions of when to apply and when to not apply the strategy (refer to `roda_ps.kf` to see what this means).

### greedy\_adversary\_simulator/plota\_p.py
This is a python code that plots the results (refer to `roda_ps.kf` to see what this means). A copy of it is created and later modified by `roda_ps.kf`.

### greedy\_adversary\_simulator/ini.kf
This is the initial part of the code, I am using it to simply initialize the secret and any possible parameters the strategy will need (refer to `roda_ps.kf` to see what this means). This will be copied and modified by `roda_ps.kf`.

### greedy\_adversary\_simulator/mid.kf
This is the part of the code that represents the channel (refer to `roda_ps.kf` to see what this means). This will be copied and modified by `roda_ps.kf`.

### greedy\_adversary\_simulator/fimcom.kf
This is the part of the code that finishes by applying the strategy (refer to `roda_ps.kf` to see what this means). This will be copied and modified by `roda_ps.kf`.

### greedy\_adversary\_simulator/fimsem.kf
This is the part of the code that finishes by not applying the strategy (refer to `roda_ps.kf` to see what this means). This basically does nothing, I'm only instatiating the variable `UVA` to be sure that the code ran until the end (sometimes the current version I'm using of Kuifje doesn't throw any error or warning if something goes wrong and the code suddenly stops running).
