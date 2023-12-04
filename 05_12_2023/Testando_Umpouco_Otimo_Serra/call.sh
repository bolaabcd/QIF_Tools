sh testone.sh 0.5 14 "1 1 1 1 1 1 1 1 1 1 1 1 1 1" 16383 prefile.kf channel.kf strat.kf
sh testone.sh 0.5 13 "1 1 1 1 1 1 1 1 1 1 1 1 1" 8191 prefile.kf channel.kf strat.kf
sh testone.sh 0.5 13 "0 0 0 1 0 0 0 1 0 0 1 0 0" 1160 prefile.kf channel.kf strat.kf
sh testone.sh 0.5 13 "0 0 1 0 0 0 1 0 0 1 0 0 0" 580 prefile.kf channel.kf strat.kf
sh testone.sh 0.5 13 "0 1 0 0 0 1 0 0 1 0 0 0 0" 290 prefile.kf channel.kf strat.kf
sh testone.sh 0.5 13 "1 0 0 0 1 0 0 1 0 0 0 0 0" 145 prefile.kf channel.kf strat.kf

# On my computer:
# real	1m9,370s
# user	1m4,159s
# sys	0m5,543s

# Results --> vulnfinal (manually put here), val, vuln1, number, nsteps, choice:
# 0.436283 0.532264626586914 0.255208 16383 14 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# 0.430895 0.5322113693847655 0.255208 8191 13 1 1 1 1 1 1 1 1 1 1 1 1 1
# 0.398702 0.6383764228515626 0.296875 1160 13 0 0 0 1 0 0 0 1 0 0 1 0 0 # This is what we want to show is the "optimal"
# 0.430895 0.6164811213378907 0.296875 580 13 0 0 1 0 0 0 1 0 0 1 0 0 0
# 0.461076 0.5909338505859375 0.296875 290 13 0 1 0 0 0 1 0 0 1 0 0 0 0
# 0.489371 0.5787504055175782 0.255208 145 13 1 0 0 0 1 0 0 1 0 0 0 0 0
