Matlab scripts (Matlab2022b) for simulations of noisy best response dynamics:

1- gen_initial_networks.m: generate initial networks as created by subjects at the end of the trial period of each round of the experiment (for each group). The input file is '../time_series.mat' previously generated. Output files are 'start_bet_x.mat' and 'start_crit_x.mat' (for x=10, 50, or 100). 

2 - run_simul.m: generate simulation data based on initial networks from the experiment (see above) and estimated noise parameter (see 'estimation' folder). Parameters need to be updated manually in the files. Input files are '../estimation/estimation_results.mat' and '../activity.mat' previously generated. Output files are 'simul_bet_x.mat' and 'simul_crit_x.mat' (for x=10, 50, or 100). 

3 - gen_ind_incentives_simul.m: generate payoff data to identify players' incentives in the simulations. Input files are 'simul_bet_x.mat' and 'simul_crit_x.mat' (for x=10, 50, or 100) generated in the previous step. The output file is 'ind_incentives_data_simul.mat'. 