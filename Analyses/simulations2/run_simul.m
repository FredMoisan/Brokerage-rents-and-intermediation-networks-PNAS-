clear all
close all force;

nb_runs= 1; % nb of simulation runs
n=10; % group size (10, 50, 100)
model=0; % 0=critical, 1=betweenness

%%%%% noisy best response model %%%%%%%%%%%%%%%%
load('../estimation/estimation_results.mat');
load('../activity.mat');

delta=[1 1];

if (model==0)
    filename=['simul_critical_' num2str(n) '.mat'];
    file_start='start_crit_';
    if (n==10)
        lambda=[mean(lambda_critical_10_trial) mean(lambda_critical_10_real)]/20; % conversion rate to normalize payoffs across group sizes
        activity=activity_crit_10;
    elseif (n==50)
        lambda=[mean(lambda_critical_50_trial) mean(lambda_critical_50_real)]/110; % conversion rate to normalize payoffs across group sizes
        activity=activity_crit_50;
    elseif (n==100)
        lambda=[mean(lambda_critical_100_trial) mean(lambda_critical_100_real)]/220; % conversion rate to normalize payoffs across group sizes
        activity=activity_crit_100;
    end;
else
    filename=['simul_between_' num2str(n) '.mat'];
    file_start='start_bet_';
    if (n==10)
        lambda=[mean(lambda_between_10_trial) mean(lambda_between_10_real)]/20; % conversion rate to normalize payoffs across group sizes
        activity=activity_bet_10;
    elseif (n==50)
        lambda=[mean(lambda_between_50_trial) mean(lambda_between_50_real)]/110; % conversion rate to normalize payoffs across group sizes
        activity=activity_bet_50;
    elseif (n==100)
        lambda=[mean(lambda_between_100_trial) mean(lambda_between_100_real)]/220; % conversion rate to normalize payoffs across group sizes
        activity=activity_bet_100;
    end;
end;

iter_trial=0;

file_start=[file_start num2str(n) '.mat'];
load(file_start);

payoffs=[];
payoffs_inter=[];
connected_pairs=[];
degree=[];
indegree=[];
outdegree=[];
adding_prop=[];
adding_link=[];
delete_link=[];
no_act=[];
distance=[];
network=[];

nb_rounds=size(activity,1)/360;
for i=1:nb_runs
    for j=1:nb_rounds

        rng((i-1)*nb_rounds+j);

        (i-1)*nb_rounds+j

        G_start=reshape(net(j,:),[n,n])';

        act_round=activity((j-1)*360+61-iter_trial:j*360,:); 

        if (model==0)
            [pay inter conn dist deg indeg outdeg add_prop add_link del_link no_move G] = simul_critical(G_start,act_round,n, 0.8*n,iter_trial,lambda,delta);
        else
            [pay inter conn dist deg indeg outdeg add_prop add_link del_link no_move G] = simul_between(G_start,act_round,n, 0.8*n,iter_trial,lambda,delta);
        end;
        payoffs=[payoffs;pay];
        payoffs_inter=[payoffs_inter;inter];
        connected_pairs=[connected_pairs;conn];
        degree=[degree;deg];
        indegree=[indegree;indeg];
        outdegree=[outdegree;outdeg];
        adding_prop=[adding_prop;add_prop];
        adding_link=[adding_link;add_link];
        delete_link=[delete_link;del_link];
        no_act=[no_act;no_move];
        distance=[distance;dist];
        network=[network;reshape(G',1,[])];
    end;
end;

save([filename],'payoffs','payoffs_inter', 'connected_pairs', 'degree', 'indegree', 'outdegree','adding_prop','adding_link','delete_link','no_act', 'distance');
