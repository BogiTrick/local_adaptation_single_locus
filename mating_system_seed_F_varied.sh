#!/bin/bash

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++++ Comments +++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Usage: selfing_sim [w1AA][w1Aa][w1aa][w2AA][w2Aa][w2aa][m12pollen][m21pollen][m12seed][m21seed][sigma][patch1_size][patch2_size][mut_init1][mut_init2][run_nb][rand_seed]
#
# When running on personal computer, add gsl to PATH:
LD_LIBRARY_PATH=/home/bogi/gsl/lib
export LD_LIBRARY_PATH

# If running on cluster, don't forget to load gsl module
#module load gsl/2.4 

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++ The overall philosophy +++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 1. Generate as many PRN as there are simulation runs; Use device files as PRNG
# 2. Execute simulations via 'parallel' and pipe all PRNs; This yields data for one set of parameters (e.g., migration rate)
# 3. Set new input parameters and goto step 1

generate_rnd() {
	>$rnd_src                                                         
    	for ((k = 1 ; k <= sim_runs ; k++))                                         
    	do                                                                          
        	cat /dev/urandom | od -vAn -N4 -tu4 >> $rnd_src               
    	done
}



# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++++ Parameters +++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


sim_runs=1000		# For each combination of parameters, run 1000 simulations
# Output is grouped by the patch where mutant was injected (good vs. bad), and selection mode (viability, female fecundity, and male fecundity, respectively)
# We will process the raw output using 'compare_simulations.R' and finally plot it from Mathematica notebook
good_start_via="./good_via_F.out"
bad_start_via="./bad_via_F.out"
rnd_src="rand_seed.out"
>$rnd_src
seed_pars=( 0.000 0.001 0.005 0.01 0.025 )		# Seed migration rates
selfing_pars=( 0.00 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.00 )
dom_pars=( 0.20 0.40 0.60 0.80 )


wAA1=1.01
wAA2=0.99
waa=1
s=0.01

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++++++++++++++++++++++++ Bulk run +++++++++++++++++++++++++
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Selection on viability
>$good_start_via
>$bad_start_via
for i in "${selfing_pars[@]}"
do
	for j in "${seed_pars[@]}"
	do
		for k in "${dom_pars[@]}"
		do
		wAa1=$(echo "1+$k*$s" | bc -l)
		wAa2=$(echo "1-$k*$s" | bc -l)
		generate_rnd
		cat $rnd_src | parallel "./selfing_sim $wAA1 $wAa1 $waa $wAA2 $wAa2 $waa 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 $j $j $i 10000 10000 1 0 10000 {}" >> $good_start_via
		generate_rnd
		cat $rnd_src | parallel "./selfing_sim $wAA1 $wAa1 $waa $wAA2 $wAa2 $waa 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 $j $j $i 10000 10000 0 1 10000 {}" >> $bad_start_via
		done
	done
done



