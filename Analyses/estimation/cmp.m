function output = cmp(pm,pay,choice,n,step,simuls,P,file,iter)

ncol = size(pay,2);
nrow = size(pay,1);

ng = ncol/(n+1);

delta = 1;%abs(pm(1));
lambda=abs(pm(1));
output=0;

if isfile([file num2str(n) '.mat'])
    load([file num2str(n) '.mat']);
else
    mean_deg=zeros(iter,nrow);
    ineq_deg=zeros(iter,nrow);
    connect=zeros(iter,nrow);
end;
x(iter)=pm;

for l=1:nrow % for each moment
    mean_deg_real=zeros(1,ng/n);
    ineq_deg_real=zeros(1,ng/n);
    connect_real=zeros(1,ng/n);
    mean_deg_sim=zeros(simuls,ng/n);
    ineq_deg_sim=zeros(simuls,ng/n);
    connect_sim=zeros(simuls,ng/n);
    actual_net=zeros(n,n);
    simul_net=zeros(n,n);
    for j=1:simuls % for each simulation run
        round=1;
        cpt=0;
        for i=1:ng % for each subject

            id=mod(i,n); % id of subject
            if (id==0) % if last subject of a round
                id=n;
            end;
            if (id==1) % initialize variables if starting a new round
                actual_net=zeros(n,n);
                simul_net=zeros(n,n);
            end;

            if (choice(l,i*(n+1))~=0)
                cpt=cpt+1;
            pay_tmp = pay(l,(i-1)*(n+1)+1:i*(n+1)); % potential payoffs for individual (+ actual payoff)
            choice_tmp = choice(l,(i-1)*(n+1)+1:i*(n+1)); % potential choices for individual (+ actual choice)
            [out_simul prob]=nbr(pay_tmp,choice_tmp,id,n,lambda,delta);
            simul_net(id,out_simul)=abs(simul_net(id,out_simul)-1); % update simulated directed network with simulated choice
            simul_net(id,id)=0; % in case of doing nothing
%            if (choice(l,i*(n+1))~=0)
                actual_net(id,choice(l,i*(n+1)))=abs(actual_net(id,choice(l,i*(n+1)))-1); % update real directed network with actual choice
%            end;
            end;
    
            if (id==n) % if all subjects of current round have been covered
                actual_net=actual_net.*actual_net'; % realized network for actual choices
                simul_net=simul_net.*simul_net'; % realized network for simulated choices
                cpt=0;
                if (j==1) % no need to recompute properties of actual network more than once
                    deg=sum(actual_net,1);
                    mean_deg_real(round)=mean(deg);
                    median_deg=median(deg);
                    if (median_deg>0)
                        ineq_deg_real(round)=max(deg)/median_deg;
                    else
                        ineq_deg_real(round)=1; % case with no/few links
                    end;
                    shortest_path=distances(graph(actual_net)); 
                    connect_real(round)=(sum(sum(shortest_path~=inf))-n)/(n*(n-1)/2);
                end;
                deg=sum(simul_net,1); 
                mean_deg_sim(j,round)=mean(deg); % mean degree
                median_deg=median(deg);
                if (median_deg>0)
                    ineq_deg_sim(j,round)=max(deg)/median_deg; % degree inequality
                else
                    ineq_deg_sim(j,round)=1; % case with no/few links
                end;
                shortest_path=distances(graph(simul_net)); 
                connect_sim(j,round)=(sum(sum(shortest_path~=inf))-n)/(n*(n-1)/2); % connectivity
                round=round+1;
            end;
        end;
    end;
    mean_deg_diff=mean_deg_real-mean(mean_deg_sim,1);
%    mean_deg_diff=mean_deg_diff/(n-1);
    mean_deg(iter,l)=mean(mean_deg_diff,'omitnan'); % mean errors of expected mean degree from simulation
    ineq_deg_diff=ineq_deg_real-mean(ineq_deg_sim,1);
%    ineq_deg_diff=ineq_deg_diff/(n-2);
    ineq_deg(iter,l)=mean(ineq_deg_diff,'omitnan'); % mean errors of expected degree inequality from simulation
    connect_diff=connect_real-mean(connect_sim,1);
%    connect_diff=connect_diff/std(connect_diff);
    connect(iter,l)=mean(connect_diff,'omitnan'); % mean errors of expected connectivity from simulation
%    vec=[mean_deg(iter,l);ineq_deg(iter,l);connect(iter,l)];
    vec=[mean_deg(iter,l);connect(iter,l)];
    if (step==1) % step 1 of two way estimation method
%        W=[1 0 0;0 1 0;0 0 1];
        W=[1 0;0 1];
        output=output+vec'*W*vec;
    elseif (step==2) % Compute weighted matrix as input to step 2
        output=output+vec*vec';
    else % step 2 of two way estimation method
        output=output+vec'*P*vec;
    end;
end;
if (step==3)
    y(iter)=output;
    save([file num2str(n) '.mat'],'x','y','mean_deg','ineq_deg','connect');
end;
end