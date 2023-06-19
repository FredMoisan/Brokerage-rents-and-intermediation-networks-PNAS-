clear all
close all force;

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

%%%%%%%%%%%%%%%%% simulation data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
clear payoffs payoffs_inter degree indegree outdegree;
load('simulations2/simul_between_100');
pay_between_100=payoffs;
pay_inter_between_100=payoffs_inter;
deg_between_100=degree;
indeg_between_100=indegree;
outdeg_between_100=outdegree;
connected_pairs_between_100=connected_pairs;
distance_between_100=distance;

clear payoffs payoffs_inter degree indegree outdegree;
load('simulations2/simul_critical_100');
pay_critical_100=payoffs;
pay_inter_critical_100=payoffs_inter;
deg_critical_100=degree;
indeg_critical_100=indegree;
outdeg_critical_100=outdegree;
connected_pairs_critical_100=connected_pairs;
distance_critical_100=distance;

v=10;

iterations=size(pay_between_100,2);

for i=1:iterations
    for j=1:size(pay_between_100,1)/100

        k=8;
        efficiency_between_100(j,i)=sum(pay_between_100((j-1)*100+1:j*100,i))/((100-1)*(v-2*k+(100-2)*v/2));
        ineq_between_100(j,i)=max(pay_between_100((j-1)*100+1:j*100,i))/median(pay_between_100((j-1)*100+1:j*100,i));
        links_between_100(j,i)=sum(deg_between_100((j-1)*100+1:j*100,i));
        ineq_deg_between_100(j,i)=max(deg_between_100((j-1)*100+1:j*100,i))/median(deg_between_100((j-1)*100+1:j*100,i));
        tmp=sort(deg_between_100((j-1)*100+1:j*100,i),'descend');
        max_deg_between_100(j,i)=tmp(1);
        diff_deg_between_100(j,i)=tmp(1)-tmp(2);
        outdegree_between_100(j,i)=mean(outdeg_between_100((j-1)*100+1:j*100,i));

        efficiency_critical_100(j,i)=sum(pay_critical_100((j-1)*100+1:j*100,i))/((100-1)*(v-2*k+(100-2)*v/2));
        ineq_critical_100(j,i)=max(pay_critical_100((j-1)*100+1:j*100,i))/median(pay_critical_100((j-1)*100+1:j*100,i));
        links_critical_100(j,i)=sum(deg_critical_100((j-1)*100+1:j*100,i));
        ineq_deg_critical_100(j,i)=max(deg_critical_100((j-1)*100+1:j*100,i))/median(deg_critical_100((j-1)*100+1:j*100,i));
        tmp=sort(deg_critical_100((j-1)*100+1:j*100,i),'descend');
        max_deg_critical_100(j,i)=tmp(1);
        diff_deg_critical_100(j,i)=tmp(1)-tmp(2);
        outdegree_critical_100(j,i)=mean(outdeg_critical_100((j-1)*100+1:j*100,i));
    end;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Experimental data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load data_grp;
%load data_time_ind;

start_round=60; % remove trial period at the beginning of each round
end_round=0; % remove period at the end of each round to avoid end game effects

data_grp=data_grp(data_grp(:,5)>start_round,:); % remove trial period
data_grp=data_grp(data_grp(:,5)<=360-end_round,:); % remove end period

round=2; % starting round

block=5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmp=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,5);
tmp2=[1:300];
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
    tmp2(tmp2>(i-1)*block&tmp2<=i*block)=i;
end;
f=figure
plot([block:block:300],grpstats(nanmean(ineq_deg_critical_100(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(ineq_deg_between_100(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,52),tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,52),tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 50]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max deg / median deg');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','north')
legend boxoff;

if (record)
    saveas(f,[dir '/ineq_deg_est100.png']);
end;

f=figure
plot([block:block:300],grpstats(nanmean(efficiency_critical_100(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(efficiency_between_100(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,29),tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,29),tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Efficiency');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/efficiency_est100.png']);
end;

%%%%%%%%%%%%%%% Total links


f=figure
plot([block:block:300],grpstats(nanmean(links_critical_100(:,1:300)/100,1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(links_between_100(:,1:300)/100,1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,7)*2/100,tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,7)*2/100,tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 5.5]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/degree_est100.png']);
end;

f=figure
plot([block:block:300],grpstats(nanmean(ineq_critical_100(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(ineq_between_100(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,51),tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,51),tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 40]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max pay/median pay');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','north')
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_pay_est100.png']);
end;%

f=figure
plot([block:block:300],grpstats(nanmean(connected_pairs_critical_100(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(connected_pairs_between_100(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],1-grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,41)/4950,tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],1-grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,41)/4950,tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Connectedness');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/connectedness_est100.png']);
end;

f=figure
plot([block:block:300],grpstats(nanmean(distance_critical_100(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(distance_between_100(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,60),tmp, {'nanmean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,60),tmp, {'nanmean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 9]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Distance (largest comp.)');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/distance_est100.png']);
end;