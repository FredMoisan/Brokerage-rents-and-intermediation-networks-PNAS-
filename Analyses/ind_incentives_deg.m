clear all
close all force;

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

load ind_incentives_data_deg;
load 'simulations2/ind_incentives_data_simul';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% max, min, actual gain

f=figure
plot([0:9],nanmean(pay_crit_10,1),'r','LineWidth',3);
hold on;
plot([0:9],nanmean(pay_bet_10,1),'b','LineWidth',3);
plot([0, 9], [0, 0],'k--');
xlim([0 9]);
set(gca,'FontSize',18);
xlabel('Links');
ylabel('Payoff');
xticks([0:9])
set(gca,'xticklabel',{'0','1','2','3','4','5','6','7','8','9'})
legend({'Criticality','Betweenness'},'NumColumns',1,'Location','NorthWest');
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/payoffs_subjects_deg_10.png']);
end;

mean_crit_real=mean(nb_crit_10,1)/10;
mean_bet_real=mean(nb_bet_10,1)/10;
std_crit_real=1.96*std(nb_crit_10)/sqrt(size(nb_crit_10,1))/10;
std_bet_real=1.96*std(nb_bet_10)/sqrt(size(nb_bet_10,1))/10;

f=figure;
f.WindowState = 'maximized';
errorbar_groups([mean_crit_real;mean_bet_real],[std_crit_real;std_bet_real],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northeast','FontSize', 25);
set(gca,'XTick',[1.5:2:10*2-0.5],'XTickLabel',{'0','1','2','3','4','5','6','7','8','9'});
xlabel({'Links'});
xlim([0 21]);
ylim([0 0.5]);
ylabel('Fraction of subjects','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/fraction_subjects_real_deg_10.png']);
end;

mean_crit_simul=mean(nb_crit_10_simul,1)/10;
mean_bet_simul=mean(nb_bet_10_simul,1)/10;
std_crit_simul=1.96*std(nb_crit_10_simul)/sqrt(size(nb_crit_10_simul,1))/10;
std_bet_simul=1.96*std(nb_bet_10_simul)/sqrt(size(nb_bet_10_simul,1))/10;

f=figure;
f.WindowState = 'maximized';
errorbar_groups([mean_crit_simul;mean_bet_simul],[std_crit_simul;std_bet_simul],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northeast','FontSize', 25);
%xticks([0:13])
set(gca,'XTick',[1.5:2:10*2-0.5],'XTickLabel',{'0','1','2','3','4','5','6','7','8','9'});
xlabel({'Links'});
xlim([0 21]);
ylim([0 0.5]);
ylabel('Fraction of subjects','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/fraction_subjects_simul_deg_10.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%% N=50 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
plot([0:17],nanmean(pay_crit_50,1),'r','LineWidth',3);
hold on;
plot([0:17],nanmean(pay_bet_50,1),'b','LineWidth',3);
plot([0, 17], [0, 0],'k--');
%plot([2, 2], [-200, 200],'k--');
xlim([0 13]);
%ylim([-120 125]);
set(gca,'FontSize',18);
xlabel('Links');
ylabel('Payoff');
xticks([0:13])
%set(gca,'xticklabel',{'0','1','2','3','4','5','6','7','8','9','10-14','15-19','20-24','25-29','30-34','35-39','40-44','45-49'})
set(gca,'xticklabel',{'0','1','2','3','4','5','6','7','8','9','10-14','15-19','20-24','25-29'})
legend({'Criticality','Betweenness'},'NumColumns',1,'Location','NorthWest');
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/payoffs_subjects_deg_50.png']);
end;

mean_crit_real=mean(nb_crit_50,1)/50;
mean_bet_real=mean(nb_bet_50,1)/50;
std_crit_real=1.96*std(nb_crit_50)/sqrt(size(nb_crit_50,1))/50;
std_bet_real=1.96*std(nb_bet_50)/sqrt(size(nb_bet_50,1))/50;

f=figure;
f.WindowState = 'maximized';
errorbar_groups([mean_crit_real;mean_bet_real],[std_crit_real;std_bet_real],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northeast','FontSize', 25);
set(gca,'XTick',[1.5:2:18*2-0.5],'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10-14','15-19','20-24','25-29'});
xlabel({'Links'});
xlim([0 29]);
ylim([0 0.5]);
ylabel('Fraction of subjects','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/fraction_subjects_real_deg_50.png']);
end;

mean_crit_simul=mean(nb_crit_50_simul,1)/50;
mean_bet_simul=mean(nb_bet_50_simul,1)/50;
std_crit_simul=1.96*std(nb_crit_50_simul)/sqrt(size(nb_crit_50_simul,1))/50;
std_bet_simul=1.96*std(nb_bet_50_simul)/sqrt(size(nb_bet_50_simul,1))/50;

f=figure;
f.WindowState = 'maximized';
errorbar_groups([mean_crit_simul;mean_bet_simul],[std_crit_simul;std_bet_simul],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northeast','FontSize', 25);
set(gca,'XTick',[1.5:2:18*2-0.5],'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10-14','15-19','20-24','25-29'});
xlabel({'Links'});
xlim([0 29]);
ylim([0 0.5]);
ylabel('Fraction of subjects','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/fraction_subjects_simul_deg_50.png']);
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%% N=100 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
plot([0:27],nanmean(pay_crit_100,1),'r','LineWidth',3);
hold on;
plot([0:27],nanmean(pay_bet_100,1),'b','LineWidth',3);
plot([0, 27], [0, 0],'k--');
xlim([0 13]);
set(gca,'FontSize',18);
xlabel('Links');
ylabel('Payoff');
xticks([0:13])
set(gca,'xticklabel',{'0','1','2','3','4','5','6','7','8','9','10-14','15-19','20-24','25-29'})
legend({'Criticality','Betweenness'},'NumColumns',1,'Location','SouthWest');
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/payoffs_subjects_deg_100.png']);
end;

mean_crit_real=mean(nb_crit_100,1)/100;
mean_bet_real=mean(nb_bet_100,1)/100;
std_crit_real=1.96*std(nb_crit_100)/sqrt(size(nb_crit_100,1))/100;
std_bet_real=1.96*std(nb_bet_100)/sqrt(size(nb_bet_100,1))/100;

f=figure;
f.WindowState = 'maximized';
errorbar_groups([mean_crit_real;mean_bet_real],[std_crit_real;std_bet_real],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northeast','FontSize', 25);
set(gca,'XTick',[1.5:2:28*2-0.5],'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10-14','15-19','20-24','25-29'});
xlabel({'Links'});
xlim([0 29]);
ylim([0 0.5]);
ylabel('Fraction of subjects','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/fraction_subjects_real_deg_100.png']);
end;

mean_crit_simul=mean(nb_crit_100_simul,1)/100;
mean_bet_simul=mean(nb_bet_100_simul,1)/100;
std_crit_simul=1.96*std(nb_crit_100_simul)/sqrt(size(nb_crit_100_simul,1))/100;
std_bet_simul=1.96*std(nb_bet_100_simul)/sqrt(size(nb_bet_100_simul,1))/100;

f=figure;
f.WindowState = 'maximized';
errorbar_groups([mean_crit_simul;mean_bet_simul],[std_crit_simul;std_bet_simul],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northeast','FontSize', 25);
set(gca,'XTick',[1.5:2:28*2-0.5],'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10-14','15-19','20-24','25-29'});
xlabel({'Links'});
xlim([0 29]);
ylim([0 0.5]);
ylabel('Fraction of subjects','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/fraction_subjects_simul_deg_100.png']);
end;