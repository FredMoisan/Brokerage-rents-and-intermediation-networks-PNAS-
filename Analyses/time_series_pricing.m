clear all
close all force;

load data_grp;

load 'simulations/simul_stats';

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

start_round=0; % remove trial period at the beginning of each round
end_round=0; % remove period at the end of each round to avoid end game effects

data_grp=data_grp(data_grp(:,5)>start_round,:); % remove trial period
data_grp=data_grp(data_grp(:,5)<=360-end_round,:); % remove end period

start_round=2; % starting round

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

%%%%%%%%%%%%%% stats %%%%%%%%%%%%%%%%%%%%%%

features={'Connectedness'; 'Average degree';'Max degree / Median degree';'Distance (largest component)';'Max payoff / Median payoff';'Efficiency'};
Crit10=[nanmean(1-data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,41)/45);nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,7))/5;nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,52));nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,60));nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,51));nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,29))];
Crit50=[nanmean(1-data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,41)/1225);nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,7))/25;nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,52));nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,60));nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,51));nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,29))];
Crit100=[nanmean(1-data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,41)/4950);nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,7))/50;nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,52));nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,60));nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,51));nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round&data_grp(:,5)>350,29))];
Bet10=[nanmean(1-data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,41)/45);nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,7))/5;nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,52));nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,60));nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,51));nanmean(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,29))];
Bet50=[nanmean(1-data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,41)/1225);nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,7))/25;nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,52));nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,60));nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,51));nanmean(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,29))];
Bet100=[nanmean(1-data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,41)/4950);nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,7))/50;nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,52));nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,60));nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,51));nanmean(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round&data_grp(:,5)>350,29))];

T=table(features,round(Crit10,2),round(Crit50,2),round(Crit100,2),round(Bet10,2),round(Bet50,2),round(Bet100,2))

if (record)
    save('exp_stats.mat','Crit10','Crit50', 'Crit100', 'Bet10', 'Bet50', 'Bet100');
end;

table2latex(T, 'output_exp'); % latex format

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,29),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,29),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 160],'k:');
plot([0, 360], [Crit10(2), Crit10(2)],'r--');
plot([0, 360], [Bet10(2), Bet10(2)],'b--');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Efficiency');
%title('N=10');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/efficiency_10.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,29),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,29),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 160],'k:');
plot([0, 360], [Crit50(2), Crit50(2)],'r--');
plot([0, 360], [Bet50(2), Bet50(2)],'b--');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Efficiency');
%title('N=50');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/efficiency_50.png']);
end;

f=figure
%subplot(2,2,3)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,29),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,29),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 160],'k:');
plot([0, 360], [Crit100(2), Crit100(2)],'r--');
plot([0, 360], [Bet100(2), Bet100(2)],'b--');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Efficiency');
%title('N=100');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/efficiency_100.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,7)*2/10,tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,7)*2/10,tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit10(4), Crit10(4)],'r--');
plot([0, 360], [Bet10(4), Bet10(4)],'b--');
xlim([1 360]);
ylim([0 6]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Degree');
%title('N=10');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/degree_10.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,7)*2/50,tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,7)*2/50,tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit50(4), Crit50(4)],'r--');
plot([0, 360], [Bet50(4), Bet50(4)],'b--');
xlim([1 360]);
ylim([0 6]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Degree');
%title('N=50');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/degree_50.png']);
end;

f=figure
%subplot(2,2,3)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,7)*2/100,tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,7)*2/100,tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit100(4), Crit100(4)],'r--');
plot([0, 360], [Bet100(4), Bet100(4)],'b--');
xlim([1 360]);
ylim([0 6]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Degree');
%title('N=100');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','SouthEast')
legend boxoff;
if (record)
    saveas(f,[dir '/degree_100.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,52),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,52),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit10(5), Crit10(5)],'r--');
plot([0, 360], [Bet10(5), Bet10(5)],'b--');
xlim([1 360]);
ylim([0 6]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Max deg / median deg');
%title('N=10');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_degree_10.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,52),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,52),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit50(5), Crit50(5)],'r--');
plot([0, 360], [Bet50(5), Bet50(5)],'b--');
xlim([1 360]);
ylim([0 30]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Max deg / median deg');
%title('N=50');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_degree_50.png']);
end;

f=figure
%subplot(2,2,3)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,52),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,52),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit100(5), Crit100(5)],'r--');
plot([0, 360], [Bet100(5), Bet100(5)],'b--');
xlim([1 360]);
ylim([0 50]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Max deg / median deg');
%title('N=100');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_degree_100.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,51),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,51),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit10(3), Crit10(3)],'r--');
plot([0, 360], [Bet10(3), Bet10(3)],'b--');
xlim([1 360]);
ylim([0 6]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Max payoff / median payoff');
%title('N=10');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_payoff_10.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,51),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,51),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit50(3), Crit50(3)],'r--');
plot([0, 360], [Bet50(3), Bet50(3)],'b--');
xlim([1 360]);
ylim([0 25]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Max payoff / median payoff');
%title('N=50');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_payoff_50.png']);
end;

f=figure
%subplot(2,2,3)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,51),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,51),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit100(3), Crit100(3)],'r--');
plot([0, 360], [Bet100(3), Bet100(3)],'b--');
xlim([1 360]);
ylim([0 50]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Max payoff / median payoff');
%title('N=100');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/ineq_payoff_100.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
%subplot(2,2,1)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,60),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,60),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit10(6), Crit10(6)],'r--');
plot([0, 360], [Bet10(6), Bet10(6)],'b--');
xlim([1 360]);
ylim([0 3]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Distance (largest comp.)');
%title('N=10');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','South')
legend boxoff;
if (record)
    saveas(f,[dir '/distance_10.png']);
end;

f=figure
%subplot(2,2,2)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,60),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,60),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit50(6), Crit50(6)],'r--');
plot([0, 360], [Bet50(6), Bet50(6)],'b--');
xlim([1 360]);
ylim([0 11.5]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Distance (largest comp.)');
%title('N=50');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/distance_50.png']);
end;

f=figure
%subplot(2,2,3)
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,60),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,60),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 150],'k:');
plot([0, 360], [Crit100(6), Crit100(6)],'r--');
plot([0, 360], [Bet100(6), Bet100(6)],'b--');
xlim([1 360]);
ylim([0 24]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
%ylabel('Nb of links');
ylabel('Distance (largest comp.)');
%title('N=100');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/distance_100.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
f.Position = [500 210 660 550];
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,55),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,55),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Fraction of subjects with degree 1');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/subjects_deg1_10.png']);
end;

f=figure
f.Position = [500 210 660 550];
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,55),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,55),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Fraction of subjects with degree 1');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/subjects_deg1_50.png']);
end;

f=figure
f.Position = [500 210 660 550];
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,55),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,55),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Fraction of subjects with degree 1');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/subjects_deg1_100.png']);
end;


f=figure
f.Position = [500 210 660 550];
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,56),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,56),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Fraction of subjects with degree 2');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/subjects_deg2_10.png']);
end;

f=figure
f.Position = [500 210 660 550];
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,56),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,56),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Fraction of subjects with degree 2');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/subjects_deg2_50.png']);
end;

f=figure
f.Position = [500 210 660 550];
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,56),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,56),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Fraction of subjects with degree 2');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/subjects_deg2_100.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,53),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,53),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 9]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max degree');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/max_deg_10.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,53),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,53),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 49]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max degree');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/max_deg_50.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,53),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,53),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 99]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Max degree');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/max_deg_100.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,6),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,6),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 1],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Degree centrality');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/deg_centrality_10.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,6),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,6),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 1],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Degree centrality');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/deg_centrality_50.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,6),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,6),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 1],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Degree centrality');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/deg_centrality_100.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,42),tmp10c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,42),tmp10b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 1],'k:');
xlim([1 360]);
ylim([0 1]);
yticks([0:0.2:1])
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Closeness centrality');
%title('Criticality');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/closeness_centrality_10.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,42),tmp50c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,42),tmp50b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 1],'k:');
xlim([1 360]);
ylim([0 1]);
yticks([0:0.2:1])
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Closeness centrality');
%title('Criticality');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/closeness_centrality_50.png']);
end;

f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,42),tmp100c, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,42),tmp100b, {'mean'}),'b','LineWidth',2);
plot([60, 60], [0, 1],'k:');
xlim([1 360]);
ylim([0 1]);
yticks([0:0.2:1])
set(gca,'FontSize',20);
xlabel('Time in seconds');
ylabel('Closeness centrality');
%title('Criticality');
box off;
legend({'Criticality','Betweenness'},'NumColumns',2)
legend boxoff;
if (record)
    saveas(f,[dir '/closeness_centrality_100.png']);
end;
