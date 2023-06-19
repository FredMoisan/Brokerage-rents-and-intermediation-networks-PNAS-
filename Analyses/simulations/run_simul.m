clear all
close all force;

nb_runs= 20; % nb of simulation runs
n=10; % group size
model=1; % 0=critical, 1=betweenness
max_iter=100; % maximum number of iterations per run
iter_trial=0; % number of trial iterations per run
init_net='ER_2'; % initial network: ER_2, ER_5, BA_1, BA_3

%%%%% noisy best response model %%%%%%%%%%%%%%%%
lambda=[0 inf];
delta=[1 1];

prob_activity=zeros(1,n)+1; % every player makes a choice at every period

if ~exist(init_net, 'dir')
    mkdir(init_net);
end

if (model==0)
    filename=[init_net '/simul_critical_' num2str(n) '.mat'];
else
    filename=[init_net '/simul_between_' num2str(n) '.mat'];
end;

if isfile(filename)
    load(filename);
    covered=size(payoffs,1)/n;
else
    covered=0;
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
    iterations=[];
    net=[];
end;

G_start=zeros(n,n);

for i=covered+1:covered+nb_runs

    rng(i);


%%%%%% comment/uncomment blocks for different networks %%%%%%

if (init_net=='ER_2' | init_net=='ER_5')
    % Erdos-Renyi network
    if (init_net=='ER_2')
        nb_links=n*1;
    else
        nb_links=n*2.5;
    end;
    p = sqrt(nb_links/(n*(n-1)/2));
    G_start = rand(n,n) < p;
    G_start=G_start-diag(diag(G_start));
else
    % Barabasi-Albert Scale free network
    seed =[0 1 1;1 0 0; 1 0 0];
    if (init_net=='BA_1')
        G_start = SFNG(n, 1, seed);
    else
        G_start = SFNG(n, 3, seed);
    end;
    G_start=double(G_start);
    G_start=G_start-diag(diag(G_start));
end;

    if (model==0)
        [pay inter conn dist deg indeg outdeg add_prop add_link del_link no_move iter G] = simul_critical(G_start,n, 0.8*n,max_iter,iter_trial,lambda,delta,prob_activity);
    else
        [pay inter conn dist deg indeg outdeg add_prop add_link del_link no_move iter G] = simul_between(G_start,n, 0.8*n,max_iter,iter_trial,lambda,delta,prob_activity);
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
    iterations=[iterations;iter];
    net=[net;reshape(G',1,[])];
end;

save([filename],'payoffs','payoffs_inter', 'connected_pairs', 'degree', 'indegree', 'outdegree','adding_prop','adding_link','delete_link','no_act', 'distance', 'iterations', 'net');
