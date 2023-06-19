clear all
close all force;

load data_grp;
%load data_time_ind;

load 'simulations/simul_stats';

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

start_round=0; % remove trial period at the beginning of each round
end_round=0; % remove period at the end of each round to avoid end game effects

data_grp=data_grp(data_grp(:,5)>start_round,:); % remove trial period
data_grp=data_grp(data_grp(:,5)<=360-end_round,:); % remove end period

round=2; % starting round

block=5;
tmp10c=data_grp(data_grp(:,3)==10&data_grp(:,4)==0,5);
tmp50c=data_grp(data_grp(:,3)==50&data_grp(:,4)==0,5);
tmp100c=data_grp(data_grp(:,3)==100&data_grp(:,4)==0,5);
tmp10b=data_grp(data_grp(:,3)==10&data_grp(:,4)==2,5);
tmp50b=data_grp(data_grp(:,3)==50&data_grp(:,4)==2,5);
tmp100b=data_grp(data_grp(:,3)==100&data_grp(:,4)==2,5);
for i=1:360/block
    tmp10c(tmp10c>(i-1)*block&tmp10c<=i*block)=i;
    tmp50c(tmp50c>(i-1)*block&tmp50c<=i*block)=i;
    tmp100c(tmp100c>(i-1)*block&tmp100c<=i*block)=i;
    tmp10b(tmp10b>(i-1)*block&tmp10b<=i*block)=i;
    tmp50b(tmp50b>(i-1)*block&tmp50b<=i*block)=i;
    tmp100b(tmp100b>(i-1)*block&tmp100b<=i*block)=i;
end;

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,29),tmp10c, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=round,29),tmp50c, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,29),tmp100c, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 160],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Efficiency');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/efficiency_critical.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,29),tmp10b, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=round,29),tmp50b, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,29),tmp100b, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 160],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Efficiency');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/efficiency_between.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,7)*2/10,tmp10c, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=round,7)*2/50,tmp50c, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,7)*2/100,tmp100c, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 6]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/degree_critical.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,7)*2/10,tmp10b, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=round,7)*2/50,tmp50b, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,7)*2/100,tmp100b, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 6]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/degree_between.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,52),tmp10c, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=round,52),tmp50c, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,52),tmp100c, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 33]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max deg / median deg');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','North')
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_degree_critical.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,52),tmp10b, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=round,52),tmp50b, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,52),tmp100b, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 33]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max deg / median deg');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','North')
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_degree_between.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,51),tmp10c, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=round,51),tmp50c, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,51),tmp100c, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 40]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max payoff / median payoff');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','North')
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_payoff_critical.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,51),tmp10b, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=round,51),tmp50b, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,51),tmp100b, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 40]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max payoff / median payoff');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','North')
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_payoff_between.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=round,60),tmp10c, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=round,60),tmp50c, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=round,60),tmp100c, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 5]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Distance (largest comp.)');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/distance_critical.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=round,60),tmp10b, {'mean'}),'g:','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=round,60),tmp50b, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=round,60),tmp100b, {'mean'}),'r','LineWidth',2);
plot([60, 60], [0, 150],'k:');
xlim([1 360]);
ylim([0 5]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Distance (largest comp.)');
box off;
legend({'N=10','N=50','N=100'},'NumColumns',3,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/distance_between.png']);
end;
