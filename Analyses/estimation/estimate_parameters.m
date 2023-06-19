clear all
close all force;

n=10 % group size
model=1 % model: 0=criticality, 1=betweenness
simuls=1; % number of simulation runs per moment
iterations=10;

if (model==0 && n==10)
    val=5;
elseif (model==0 && n==50)
    val=1;
elseif (model==0 && n==100)
    val=2;
elseif (model==1 && n==10)
    val=7;
elseif (model==1 && n==50)
    val=4;
elseif (model==1 && n==100)
    val=8;
end;

pay=[];
choice=[];
for j=1:4
    for k=2:6
        load (['../preprocessed/payoffs_' num2str(val) '_' num2str(j) '_' num2str(k) '.mat']);
        if (n==10)
            pay=[pay,pay_link'/20];
        elseif (n==50)
            pay=[pay,pay_link'/110];
        else
            pay=[pay,pay_link'/220];
        end;
        choice=[choice,choice_link'];
    end;
end;

if ~exist('delta', 'dir')
    mkdir('delta');
end

%%% Trial period
for i=1:iterations
    i
    %%% step 1 of two way estimation method
    pm011 = [10];
    [pm11, ssr11] = fminsearch(@cmp,pm011,optimset('MaxFunEvals',100,'MaxIter', 100,'Display','iter'),pay(2:60,:),choice(2:60,:),n,1,simuls,[],['delta/trial_' num2str(model) '_'],i);
    ssr11
    pm11

    %%% Compute weighted matrix as input to step 2
    W=cmp(pm11, pay(2:60,:),choice(2:60,:),n,2,simuls,[],['trial_' num2str(model) '_'],i)

    %%% step 2 of two way estimation method
    pm021 = [10];
    [pm21, ssr21] = fminsearch(@cmp,pm021,optimset('MaxFunEvals',100,'MaxIter', 100,'Display','iter'),pay(2:60,:),choice(2:60,:),n,3,simuls,W,['delta/trial_' num2str(model) '_'],i);
    ssr21
    pm21
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Payoff effective period
for i=1:iterations
    i
    %%% step 1 of two way estimation method
    pm012 = [10];
    [pm12, ssr12] = fminsearch(@cmp,pm012,optimset('MaxFunEvals',100,'MaxIter', 100,'Display','iter'),pay(61:360,:),choice(61:360,:),n,1,simuls,[],['delta/real_' num2str(model) '_'],i);
    ssr12
    pm12

    %%% Compute weighted matrix as input to step 2
    W=cmp(pm12, pay(61:360,:),choice(61:360,:),n,2,simuls,[],['real_' num2str(model) '_'],i)

    %%% step 2 of two way estimation method
    pm022 = [10];
    [pm22, ssr22] = fminsearch(@cmp,pm022,optimset('MaxFunEvals',100,'MaxIter', 100,'Display','iter'),pay(61:360,:),choice(61:360,:),n,3,simuls,W,['delta/real_' num2str(model) '_'],i);
    ssr22
    pm22
end;
