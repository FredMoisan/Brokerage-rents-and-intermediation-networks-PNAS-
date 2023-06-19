clear all
close all force;

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

%%%%%%%%%%%%%%%%% simulation data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
clear payoffs payoffs_inter degree indegree outdegree;
load('simulations2/simul_between_10');
pay_between_10=payoffs;
pay_inter_between_10=payoffs_inter;
deg_between_10=degree;
indeg_between_10=indegree;
outdeg_between_10=outdegree;
connected_pairs_between_10=connected_pairs;
distance_between_10=distance;

clear payoffs payoffs_inter degree indegree outdegree;
load('simulations2/simul_critical_10');
pay_critical_10=payoffs;
pay_inter_critical_10=payoffs_inter;
deg_critical_10=degree;
indeg_critical_10=indegree;
outdeg_critical_10=outdegree;
connected_pairs_critical_10=connected_pairs;
distance_critical_10=distance;

v=10;

iterations=size(pay_between_10,2);

for i=1:iterations
    for j=1:size(pay_between_10,1)/10

        k=8;
        efficiency_between_10(j,i)=sum(pay_between_10((j-1)*10+1:j*10,i))/((10-1)*(v-2*k+(10-2)*v/2));
        ineq_between_10(j,i)=max(pay_between_10((j-1)*10+1:j*10,i))/median(pay_between_10((j-1)*10+1:j*10,i));
        links_between_10(j,i)=sum(deg_between_10((j-1)*10+1:j*10,i));
        ineq_deg_between_10(j,i)=max(deg_between_10((j-1)*10+1:j*10,i))/median(deg_between_10((j-1)*10+1:j*10,i));
        tmp=sort(deg_between_10((j-1)*10+1:j*10,i),'descend');
        max_deg_between_10(j,i)=tmp(1);
        diff_deg_between_10(j,i)=tmp(1)-tmp(2);
        outdegree_between_10(j,i)=mean(outdeg_between_10((j-1)*10+1:j*10,i));

        efficiency_critical_10(j,i)=sum(pay_critical_10((j-1)*10+1:j*10,i))/((10-1)*(v-2*k+(10-2)*v/2));
        ineq_critical_10(j,i)=max(pay_critical_10((j-1)*10+1:j*10,i))/median(pay_critical_10((j-1)*10+1:j*10,i));
        links_critical_10(j,i)=sum(deg_critical_10((j-1)*10+1:j*10,i));
        ineq_deg_critical_10(j,i)=max(deg_critical_10((j-1)*10+1:j*10,i))/median(deg_critical_10((j-1)*10+1:j*10,i));
        tmp=sort(deg_critical_10((j-1)*10+1:j*10,i),'descend');
        max_deg_critical_10(j,i)=tmp(1);
        diff_deg_critical_10(j,i)=tmp(1)-tmp(2);
        outdegree_critical_10(j,i)=mean(outdeg_critical_10((j-1)*10+1:j*10,i));
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

tmp=data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,5);
tmp2=[1:300];
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
    tmp2(tmp2>(i-1)*block&tmp2<=i*block)=i;
end;
f=figure
plot([block:block:300],grpstats(nanmean(ineq_deg_critical_10(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(ineq_deg_between_10(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,52),tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,52),tmp, {'mean'}),'b--','LineWidth',2);
%plot([block:block:300],nanmean(ineq_deg_critical_10(:,1:300),1),'r--','LineWidth',2);
%plot([block:block:300],nanmean(ineq_deg_between_10(:,1:300),1),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 4]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max deg / median deg');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/ineq_deg_est10.png']);
end;

f=figure
plot([block:block:300],grpstats(nanmean(efficiency_critical_10(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(efficiency_between_10(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,29),tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,29),tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Efficiency');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/efficiency_est10.png']);
end;

%%%%%%%%%%%%%%% Total links


f=figure
plot([block:block:300],grpstats(nanmean(links_critical_10(:,1:300)/10,1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(links_between_10(:,1:300)/10,1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,7)*2/10,tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,7)*2/10,tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 4]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/degree_est10.png']);
end;

f=figure
plot([block:block:300],grpstats(nanmean(ineq_critical_10(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(ineq_between_10(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,51),tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,51),tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 4]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max pay/median pay');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_pay_est10.png']);
end;%

f=figure
plot([block:block:300],grpstats(nanmean(connected_pairs_critical_10(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(connected_pairs_between_10(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],1-grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,41)/45,tmp, {'mean'}),'r--','LineWidth',2);
plot([block:block:300],1-grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,41)/45,tmp, {'mean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Connectedness');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/connectedness_est10.png']);
end;

f=figure
plot([block:block:300],grpstats(nanmean(distance_critical_10(:,1:300),1),tmp2, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:300],grpstats(nanmean(distance_between_10(:,1:300),1),tmp2, {'mean'}),'b','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,60),tmp, {'nanmean'}),'r--','LineWidth',2);
plot([block:block:300],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,60),tmp, {'nanmean'}),'b--','LineWidth',2);
xlim([1 300]);
ylim([0 3]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Distance (largest comp.)');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','south')
legend boxoff;

if (record)
    saveas(f,[dir '/distance_est10.png']);
end;