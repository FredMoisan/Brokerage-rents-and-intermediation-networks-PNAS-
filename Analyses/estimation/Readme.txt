Matlab scripts (Matlab2022b) for maximum likelihood estimation of noise parameter in experimental data:

1- estimate_parameters.m: estimate parameters in trial and payoff effective periods. Some parameters need to be updated in the file. Input files are the preprocessed payoff data files previously generated in the '../preprocessed' folder. Output files are saved in a newly created 'delta' folder. 

2 - results_estimations.m: generate statistics and figures of the estimation exercise (requires running parameter estimations for all treatments). Input files correspond to the output files generated in the previous step (in the 'delta' folder). Output files are 'estimation_results.mat' and figures in a png format if the 'record' variable is set to 1 in the file. 