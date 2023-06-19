clear all
close all force;

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

%%%%%%%%%%%%%%%%% simulation data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
clear x y;
load('delta/trial_1_10');
lambda_between_10_trial=abs(x);
out_between_10_trial=abs(y);

clear x y;
load('delta/real_1_10');
lambda_between_10_real=abs(x);
out_between_10_real=abs(y);

clear x y;
load('delta/trial_1_50');
lambda_between_50_trial=abs(x);
out_between_50_trial=abs(y);

clear x y;
load('delta/real_1_50');
lambda_between_50_real=abs(x);
out_between_50_real=abs(y);

clear x y;
load('delta/trial_1_100');
lambda_between_100_trial=abs(x);
out_between_100_trial=abs(y);

clear x y;
load('delta/real_1_100');
lambda_between_100_real=abs(x);
out_between_100_real=abs(y);

clear x y;
load('delta/trial_0_10');
lambda_critical_10_trial=abs(x);
out_critical_10_trial=abs(y);

clear x y;
load('delta/real_0_10');
lambda_critical_10_real=abs(x);
out_critical_10_real=abs(y);

clear x y;
load('delta/trial_0_50');
lambda_critical_50_trial=abs(x);
out_critical_50_trial=abs(y);

clear x y;
load('delta/real_0_50');
lambda_critical_50_real=abs(x);
out_critical_50_real=abs(y);

clear x y;
load('delta/trial_0_100');
lambda_critical_100_trial=abs(x);
out_critical_100_trial=abs(y);

clear x y;
load('delta/real_0_100');
lambda_critical_100_real=abs(x);
out_critical_100_real=abs(y);

save('estimation_results.mat','lambda_between_10_trial','lambda_between_10_real','lambda_between_50_trial','lambda_between_50_real','lambda_between_100_trial','lambda_between_100_real','lambda_critical_10_trial','lambda_critical_10_real','lambda_critical_50_trial','lambda_critical_50_real','lambda_critical_100_trial','lambda_critical_100_real');

features={'Lambda';'Prediction error ($\times$ 1e-18)';'Nb obs./est.'; 'Nb est.'};
Crit10={[num2str(round(nanmean(lambda_critical_10_real),2)) ' (' num2str(round(nanstd(lambda_critical_10_real)/sqrt(length(lambda_critical_10_real)),2)) ')'];num2str(round(1000000000000000000*nanmean(out_critical_10_real)/(300*4*5),0));num2str(300*4*5);num2str(10)};
Crit50={[num2str(round(nanmean(lambda_critical_50_real),2)) ' (' num2str(round(nanstd(lambda_critical_50_real)/sqrt(length(lambda_critical_50_real)),2)) ')'];num2str(round(1000000000000000000*nanmean(out_critical_50_real)/(300*4*5),0));num2str(300*4*5);num2str(10)};
Crit100={[num2str(round(nanmean(lambda_critical_100_real),2)) ' (' num2str(round(nanstd(lambda_critical_100_real)/sqrt(length(lambda_critical_100_real)),2)) ')'];num2str(round(1000000000000000000*nanmean(out_critical_100_real)/(300*4*5),0));num2str(300*4*5);num2str(10)};
Bet10={[num2str(round(nanmean(lambda_between_10_real),2)) ' (' num2str(round(nanstd(lambda_between_10_real)/sqrt(length(lambda_between_10_real)),2)) ')'];num2str(round(1000000000000000000*nanmean(out_between_10_real)/(300*4*5),0));num2str(300*4*5);num2str(10)};
Bet50={[num2str(round(nanmean(lambda_between_50_real),2)) ' (' num2str(round(nanstd(lambda_between_50_real)/sqrt(length(lambda_between_50_real)),2)) ')'];num2str(round(1000000000000000000*nanmean(out_between_50_real)/(300*4*5),0));num2str(300*4*5);num2str(10)};
Bet100={[num2str(round(nanmean(lambda_between_100_real),2)) ' (' num2str(round(nanstd(lambda_between_100_real)/sqrt(length(lambda_between_100_real)),2)) ')'];num2str(round(1000000000000000000*nanmean(out_between_100_real)/(300*4*5),0));num2str(300*4*5);num2str(10)};

T=table(features,Crit10,Crit50,Crit100,Bet10,Bet50,Bet100)

if (record)
    save('lambda_stats.mat','Crit10','Crit50', 'Crit100', 'Bet10', 'Bet50', 'Bet100');
end;

table2latex(T, 'output_est'); % latex format


mean_crit_trial=[mean(lambda_critical_10_trial),mean(lambda_critical_50_trial),mean(lambda_critical_100_trial)];
mean_bet_trial=[mean(lambda_between_10_trial),mean(lambda_between_50_trial),mean(lambda_between_100_trial)];
std_crit_trial=1.96*[std(lambda_critical_10_trial)/sqrt(length(lambda_critical_10_trial)),std(lambda_critical_50_trial)/sqrt(length(lambda_critical_50_trial)),std(lambda_critical_100_trial)/sqrt(length(lambda_critical_100_trial))];
std_bet_trial=1.96*[std(lambda_between_10_trial)/sqrt(length(lambda_between_10_trial)),std(lambda_between_50_trial)/sqrt(length(lambda_between_50_trial)),std(lambda_between_100_trial)/sqrt(length(lambda_between_100_trial))];

f=figure;
errorbar_groups([mean_crit_trial;mean_bet_trial],[std_crit_trial;std_bet_trial],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northoutside');
xticklabels({'10','50','100'})
xlabel({'N'});
ylim([0 12]);
ylabel('Lambda','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/lambda_trial.png']);
end;

mean_crit_real=[mean(lambda_critical_10_real),mean(lambda_critical_50_real),mean(lambda_critical_100_real)];
mean_bet_real=[mean(lambda_between_10_real),mean(lambda_between_50_real),mean(lambda_between_100_real)];
std_crit_real=1.96*[std(lambda_critical_10_real)/sqrt(length(lambda_critical_10_real)),std(lambda_critical_50_real)/sqrt(length(lambda_critical_50_real)),std(lambda_critical_100_real)/sqrt(length(lambda_critical_100_real))];
std_bet_real=1.96*[std(lambda_between_10_real)/sqrt(length(lambda_between_10_real)),std(lambda_between_50_real)/sqrt(length(lambda_between_50_real)),std(lambda_between_100_real)/sqrt(length(lambda_between_100_real))];

f=figure;
errorbar_groups([mean_crit_real;mean_bet_real],[std_crit_real;std_bet_real],'bar_width',0.75,'bar_colors',[[1 0 0];[0 0 1]],'errorbar_width',0.2,'FigID',f);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend({'Criticality','Betweenness'},'NumColumns',2,'Location','northoutside');
xticklabels({'10','50','100'})
xlabel({'N'});
ylim([0 12]);
ylabel('Lambda','FontSize', 25);
box off;
legend boxoff;

if (record)
    saveas(f,[dir '/lambda_real.png']);
end;

[h p]=ttest2(lambda_critical_10_real,lambda_between_10_real)
[h p]=ttest2(lambda_critical_50_real,lambda_between_50_real)
[h p]=ttest2(lambda_critical_100_real,lambda_between_100_real)

[h p]=ttest2(lambda_critical_10_real,lambda_critical_50_real)
[h p]=ttest2(lambda_between_10_real,lambda_between_50_real)
[h p]=ttest2(lambda_critical_10_real,lambda_critical_100_real)
[h p]=ttest2(lambda_between_10_real,lambda_between_100_real)
[h p]=ttest2(lambda_critical_50_real,lambda_critical_100_real)
[h p]=ttest2(lambda_between_50_real,lambda_between_100_real)
