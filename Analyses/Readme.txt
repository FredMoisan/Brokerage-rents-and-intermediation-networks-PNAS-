Matlab scripts (Matlab2022b) for replicating analyses:

Data preprocessing (needed for subsequent analyses):

1 - time_series_build.m: compile the behavioral data from the experiment and generate individual level measures at each second of every round. The input files are located in the 'Matlab_data' folder (one file per experimental session). The output file is 'time_series.mat'.

2 - gen_data_grp.m: generate group level measures. The input file is 'time_series.mat'. The output files are 'data_grp.mat' and 'data_grp.csv'.

3 - time_series_activity.m: generate data describing the moments of activity for each subject in the experiment. The input files are located in the 'Matlab_data' folder. The output file is 'activity.mat'.

4 - Preprocess_payoffs.m: compute conditional payoffs at every decision point by any subject of the experiment (used to simplify the maximum likelihood estimation of noise parameter). The input file is 'time_series.mat'. The output files will be generated in a new 'preprocessed' folder.

5 - gen_ind_incentives_all.m: generate data specific to describe incentives (min/max payoff for adding/deleting). The input files are located in the 'preprocessed' folder previously generated. The output file is 'ind_incentives_data_deg'.

Data analyses:

1 - time_series_proposals.m: generates time series figures (related to link proposals) comparing different types of individuals. The input file is 'data_grp.mat'. Output files are the corresponding figures in a png format (if the 'record' variable is set to 1 in the file).

2 - time_series_pricing.m: generates time series figures (across various measures) comparing pricing protocols. The input files are 'data_grp.mat' and 'simul_stats.mat' to be generated in the 'simulations' folder (see corresponding Readme file). Output files are the corresponding figures in a png format (if the 'record' variable is set to 1 in the file).

3 - time_series_scale.m: generates time series figures (across various measures) comparing group sizes. The input files are 'data_grp.mat' and 'simul_stats.mat' to be generated in the 'simulations' folder (see corresponding Readme file). Output files are the corresponding figures in a png format (if the 'record' variable is set to 1 in the file).

4 - time_series_degree.m: generates time series figures (related to degree) comparing different types of individuals. The input file is 'data_grp.mat'. Output files are the corresponding figures in a png format (if the 'record' variable is set to 1 in the file).

5 - Decision_rule_table.m: generate statistics table based on best response simulations. The input files is 'simul_stats.mat' to be generated in the 'simulations' folder (see corresponding Readme file). The output file is 'table_incentives.tex'. 

6 - time_series_simul_real_x.m (for x=10, 50 or 100): generate figures to compare behavior in experiment with noisy best response simulations. This requires running scripts from 'simulations2' folder. Input files are 'data_grp.mat', and 'simul_between_x.mat' and 'simul_critical_x.mat' to be generated in the 'simulations2' folder (see corresponding Readme file). Output files are the corresponding figures in a png format (if the 'record' variable is set to 1 in the file).

7 - ind_incentives_deg.m: generate figures related to incentives from experiment and noisy best response simulations. This requires running scripts from 'simulations2'folder. The input files are 'ind_incentives_data_deg.mat' and 'ind_incentives_data_simul.mat' to be generated in the 'simulations2' folder (see corresponding Readme file). 