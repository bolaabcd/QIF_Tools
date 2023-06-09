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
