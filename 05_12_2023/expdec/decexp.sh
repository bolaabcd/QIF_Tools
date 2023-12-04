#!/bin/sh +x

# Computes best choices of exponential decay with alpha^i from i=1 to i=n, simulating "nsteps" steps
if test \( "$#" -ne 6 \) -o \( ! -f "$4" \) -o \( ! -f "$5" \) -o \( ! -f "$6" \) -o \( -z "$1" \) -o \( -z "$2" \) -o \( -z "$3" \); then
  echo "Usage: $0 <alpha> <number of elements in exponential decay> <number of steps to simulate> <prefile.kf> <channel.kf> <strategy.kf>" >&2
  exit 1
fi

alpha="$1";
n="$2";
nsteps="$3";
prefile="$4";
chanfile="$5";
stratfile="$6";
x=$(python3 -c "print(2**($n)-1)")

logfolder="log_${nsteps}_${n}_${alpha}"
if test -d $logfolder; then
    rm -r $logfolder
fi
mkdir $logfolder

echo -n '' > /tmp/pre.txt
echo -n '' > /tmp/vulnsall.txt

for j in $(seq 1 $nsteps); do
    for number in $(seq 0 $x); do
        choices="$(echo $n $number | ./trues.out)"
        sh testone.sh "$alpha" "$n" "$choices" "$number" "$prefile" "$chanfile" "$stratfile" &
    done
    # Wait all jobs to finish
    wait
    # Choose best
    sort -g /tmp/vulnsall.txt > /tmp/vulnsall2.txt
    rm /tmp/vulnsall.txt
    
    best="$(head -1 /tmp/vulnsall2.txt)"
    echo "$best" >> $logfolder/decisions.txt
    pos=0;
    for val in $best; do
        eval "var_${pos}=$val"
        pos=$(expr 1 + $pos)
    done
    val=$var_0
    vuln1=$var_1
    nbest=$var_2
    nbits=$var_3
    next_step=$var_4
    echo '' >> /tmp/pre.txt
    echo -n $next_step >> /tmp/pre.txt
    cp /tmp/sim$nbest.kf $logfolder/step_$j\_decision_$nbest.kf
    cp /tmp/simini$nbest.kf $logfolder/stepini_$j\_decision_$nbest.kf
    cp /tmp/sim$nbest.txt $logfolder/step_$j\_decision_$nbest.txt
    echo $val >> $logfolder/vals.txt
    echo $vuln1 >> $logfolder/vulns.txt
    echo $next_step >> $logfolder/steps.txt

    for number in $(seq 0 $x); do
        rm /tmp/sim$number.kf
        rm /tmp/simini$number.kf
        rm /tmp/sim$number.txt
    done
    rm /tmp/vulnsall2.txt
done

echo $alpha $n $nsteps $logfolder/vals.txt  $logfolder/steps.txt | python3 plota_vals.py
echo $alpha $n $nsteps $logfolder/vulns.txt $logfolder/steps.txt| python3 plota_vulns.py

rm /tmp/pre.txt
rm -d /tmp/cabal*
