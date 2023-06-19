clear all
close all force;

load data_grp;

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

start_round=0; % remove trial period at the beginning of each round
end_round=0; % remove period at the end of each round to avoid end game effects

data_grp=data_grp(data_grp(:,5)>start_round,:); % remove trial period
data_grp=data_grp(data_grp(:,5)<=360-end_round,:); % remove end period

round=2; % starting round

block=5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmp=data_grp(data_grp(:,3)==10&data_grp(:,4)==0,5);
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
end;
f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0,14)/9,tmp, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0,20)/9,tmp, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==0,26)/9,tmp, {'mean'}),'g:','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Most popular','2nd most popular','Others'},'NumColumns',1)
legend boxoff;
if (record)
    saveas(f,[dir '/deg_crit_10.png']);
end;

tmp=data_grp(data_grp(:,3)==50&data_grp(:,4)==0,5);
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
end;
f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0,14)/49,tmp, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0,20)/49,tmp, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==0,26)/49,tmp, {'mean'}),'g:','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Most popular','2nd most popular','Others'},'NumColumns',1)
legend boxoff;
if (record)
    saveas(f,[dir '/deg_crit_50.png']);
end;

tmp=data_grp(data_grp(:,3)==100&data_grp(:,4)==0,5);
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
end;
f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0,14)/99,tmp, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0,20)/99,tmp, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==0,26)/99,tmp, {'mean'}),'g:','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Most popular','2nd most popular','Others'},'NumColumns',1)
legend boxoff;
if (record)
    saveas(f,[dir '/deg_crit_100.png']);
end;

tmp=data_grp(data_grp(:,3)==10&data_grp(:,4)==2,5);
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
end;
f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2,14)/9,tmp, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2,20)/9,tmp, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==10&data_grp(:,4)==2,26)/9,tmp, {'mean'}),'g:','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Most popular','2nd most popular','Others'},'NumColumns',1,'Location','northeast')
legend boxoff;
if (record)
    saveas(f,[dir '/deg_bet_10.png']);
end;

tmp=data_grp(data_grp(:,3)==50&data_grp(:,4)==2,5);
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
end;
f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2,14)/49,tmp, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2,20)/49,tmp, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==50&data_grp(:,4)==2,26)/49,tmp, {'mean'}),'g:','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Most popular','2nd most popular','Others'},'NumColumns',1,'Location','northeast')
legend boxoff;
if (record)
    saveas(f,[dir '/deg_bet_50.png']);
end;

tmp=data_grp(data_grp(:,3)==100&data_grp(:,4)==2,5);
for i=1:360/block
    tmp(tmp>(i-1)*block&tmp<=i*block)=i;
end;
f=figure
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2,14)/99,tmp, {'mean'}),'r','LineWidth',2);
hold on;
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2,20)/99,tmp, {'mean'}),'b--','LineWidth',2);
plot([block:block:360],grpstats(data_grp(data_grp(:,3)==100&data_grp(:,4)==2,26)/99,tmp, {'mean'}),'g:','LineWidth',2);
plot([60, 60], [0, 100],'k:');
xlim([1 360]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Time in seconds');
ylabel('Degree');
box off;
legend({'Most popular','2nd most popular','Others'},'NumColumns',1,'Location','northeast')
legend boxoff;
if (record)
    saveas(f,[dir '/deg_bet_100.png']);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%