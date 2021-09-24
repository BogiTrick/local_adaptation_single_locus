# local_adaptation_single_locus
1. "mating_system_single_locus_revision.nb"
* Mathematica notebook with all derivations and figures presented in the manuscript. Note that simulated data has to be separately prepared and imported.

2. "main.cpp" and "selfing_sim.pro"
* The source code for simulator used to generate all the data. The project file contains information necessary for qmake to build the binary.

3. "mating_system_offspring.sh" and "compare_simulations_offspring.R"
* Script used to run all the simulations in the paper for population genetic scenarios where seed migrates. 
* Executes selfing_sim binary, and returns .out files contain raw simulated data (i.e., for each replicate simulation).
* * compare_simulations_offspring.R takes .out files and computes averages and standard deviations of the establishment probabilities; This is used for plotting in mating_system_locus_revision.nb

4. "mating_system_gamete_dispersal.sh" and "compare_simulations_gamete.R"
* Script used to run all the simulations in the paper for population genetic scenarios where pollen migrates. 
* Executes selfing_sim binary, and returns .out files contain raw simulated data (i.e., for each replicate simulation).
* compare_simulations_gamete.R takes .out files and computes averages and standard deviations of the establishment probabilities; This is used for plotting in mating_system_locus_revision.nb

5. "mating_system_seed_F_varied.sh" and "compare_simulations_self_varied.R"
* Script used to run all the simulations in the paper for P~F plot (Figure 3) for different migration rates and dominances. 
* Executes selfing_sim binary, and returns .out files contain raw simulated data (i.e., for each replicate simulation).
* compare_simulations_self_varied.R takes .out files and computes averages and standard deviations of the establishment probabilities; This is used for plotting in mating_system_locus_revision.nb

6. .zip files contain all of the simulated data required for plotting figures in Mathematica notebook
* processed_data_offspring_dispersal.zip -- For cases when seed disperses
* processed_data_gamete_dispersal.zip -- For cases when pollen disperses
* processed_data_selfing_varied.zip -- For P~F plot across migrations and dominances
