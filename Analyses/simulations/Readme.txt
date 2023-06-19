Matlab scripts (Matlab2022b) to simulate best response dynamics (no noise):

1 - run_simul.m: generate simulation data for each treatment (parameters to be set in the file). Output files are saved in a newly created folder corresponding to the 'init_net' variable set in the file. 

2 - simul_results.m: generate statistics and figures based on simulations above. Input files are the simulation outputs generated in the previous step. 

3 - limit_networks.m: generates figures of limit networks from simulations above. Input files are the simulation outputs generated in the step 1. Output files are created in a newly created 'Limit)Networks' folder. 