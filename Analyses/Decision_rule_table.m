clear all
close all force;

load data_grp;

load 'simulations/simul_stats';

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

start_round=60; % remove trial period at the beginning of each round

data_grp=data_grp(data_grp(:,5)>start_round,:); % remove trial period

start_round=2; % starting round

block=5;


frac_deg1_crit10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,55);
frac_deg2_crit10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,56);
frac_deg3_crit10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,57);
frac_deg5_10_crit10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,79);
pay_deg1_crit10=data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,76);
pay_deg2_crit10=data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,77);
pay_deg3_crit10=data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,78);
pay_deg5_10_crit10=data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,83);
max_deg_crit10=data_grp(data_grp(:,3)==10&data_grp(:,4)==0&data_grp(:,2)>=start_round,53);

frac_deg1_crit50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,55);
frac_deg2_crit50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,56);
frac_deg3_crit50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,57);
frac_deg5_10_crit50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,79);
frac_deg10_15_crit50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,80);
frac_deg15_20_crit50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,81);
frac_deg20_25_crit50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,82);
pay_deg1_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,76);
pay_deg2_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,77);
pay_deg3_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,78);
pay_deg5_10_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,83);
pay_deg10_15_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,84);
pay_deg15_20_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,85);
pay_deg20_25_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,86);
max_deg_crit50=data_grp(data_grp(:,3)==50&data_grp(:,4)==0&data_grp(:,2)>=start_round,53);

frac_deg1_crit100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,55);
frac_deg2_crit100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,56);
frac_deg3_crit100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,57);
frac_deg5_10_crit100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,79);
frac_deg10_15_crit100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,80);
frac_deg15_20_crit100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,81);
frac_deg20_25_crit100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,82);
pay_deg1_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,76);
pay_deg2_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,77);
pay_deg3_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,78);
pay_deg5_10_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,83);
pay_deg10_15_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,82);
pay_deg15_20_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,83);
pay_deg20_25_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,84);
max_deg_crit100=data_grp(data_grp(:,3)==100&data_grp(:,4)==0&data_grp(:,2)>=start_round,53);

frac_deg1_bet10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,55);
frac_deg2_bet10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,56);
frac_deg3_bet10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,57);
frac_deg5_10_bet10=100*data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,79);
pay_deg1_bet10=data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,76);
pay_deg2_bet10=data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,77);
pay_deg3_bet10=data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,78);
pay_deg5_10_bet10=data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,83);
max_deg_bet10=data_grp(data_grp(:,3)==10&data_grp(:,4)==2&data_grp(:,2)>=start_round,53);

frac_deg1_bet50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,55);
frac_deg2_bet50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,56);
frac_deg3_bet50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,57);
frac_deg5_10_bet50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,79);
frac_deg10_15_bet50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,80);
frac_deg15_20_bet50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,81);
frac_deg20_25_bet50=100*data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,82);
pay_deg1_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,76);
pay_deg2_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,77);
pay_deg3_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,78);
pay_deg5_10_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,83);
pay_deg10_15_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,84);
pay_deg15_20_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,85);
pay_deg20_25_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,86);
max_deg_bet50=data_grp(data_grp(:,3)==50&data_grp(:,4)==2&data_grp(:,2)>=start_round,53);

frac_deg1_bet100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,55);
frac_deg2_bet100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,56);
frac_deg3_bet100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,57);
frac_deg5_10_bet100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,79);
frac_deg10_15_bet100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,80);
frac_deg15_20_bet100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,81);
frac_deg20_25_bet100=100*data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,82);
pay_deg1_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,76);
pay_deg2_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,77);
pay_deg3_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,78);
pay_deg5_10_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,83);
pay_deg10_15_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,84);
pay_deg15_20_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,85);
pay_deg20_25_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,86);
max_deg_bet100=data_grp(data_grp(:,3)==100&data_grp(:,4)==2&data_grp(:,2)>=start_round,53);

precise=1;

features={'\% degree=1';'Payoff degree=1';'\% degree=2';'Payoff degree=2';'\% degree=3'; 'Payoff degree=3'};
Links={'\multirow{2}{*}{1}';'';'\multirow{2}{*}{2}';'';'\multirow{2}{*}{3}';'';'\vdots';'\multirow{2}{*}{5-10}';'';'\multirow{2}{*}{10-15}';'';'\multirow{2}{*}{15-20}';'';'\multirow{2}{*}{20-25}';''};
Stats={'\%';'Payoff';'\%';'Payoff';'\%';'Payoff';'\vdots';'\%';'Payoff';'\%';'Payoff';'\%';'Payoff';'\%';'Payoff'};

Crit10={[num2str(round(nanmean(frac_deg1_crit10),precise))];[num2str(round(nanmean(pay_deg1_crit10),precise))];['\textbf{' num2str(round(nanmean(frac_deg2_crit10),precise)) '}'];['\textbf{' num2str(round(nanmean(pay_deg2_crit10),precise)) '}'];[num2str(round(nanmean(frac_deg3_crit10),precise))];[num2str(round(nanmean(pay_deg3_crit10),precise))];'\vdots';[num2str(round(nanmean(frac_deg5_10_crit10),precise))];[num2str(round(nanmean(pay_deg5_10_crit10),precise))];'.';'.';'.';'.';'.';'.'};
Crit50={[num2str(round(nanmean(frac_deg1_crit50),precise))];[num2str(round(nanmean(pay_deg1_crit50),precise))];['\textbf{' num2str(round(nanmean(frac_deg2_crit50),precise)) '}'];['\textbf{' num2str(round(nanmean(pay_deg2_crit50),precise)) '}'];[num2str(round(nanmean(frac_deg3_crit50),precise))];[num2str(round(nanmean(pay_deg3_crit50),precise))];'\vdots';[num2str(round(nanmean(frac_deg5_10_crit50),precise))];[num2str(round(nanmean(pay_deg5_10_crit50),precise))];[num2str(round(nanmean(frac_deg10_15_crit50),precise))];[num2str(round(nanmean(pay_deg10_15_crit50),precise))];[num2str(round(nanmean(frac_deg15_20_crit50),precise))];[num2str(round(nanmean(pay_deg15_20_crit50),precise))];[num2str(round(nanmean(frac_deg20_25_crit50),precise))];[num2str(round(nanmean(pay_deg20_25_crit50),precise))]};
Crit100={[num2str(round(nanmean(frac_deg1_crit100),precise))];[num2str(round(nanmean(pay_deg1_crit100),precise))];['\textbf{' num2str(round(nanmean(frac_deg2_crit100),precise)) '}'];['\textbf{' num2str(round(nanmean(pay_deg2_crit100),precise)) '}'];[num2str(round(nanmean(frac_deg3_crit100),precise))];[num2str(round(nanmean(pay_deg3_crit100),precise))];'\vdots';[num2str(round(nanmean(frac_deg5_10_crit100),precise))];[num2str(round(nanmean(pay_deg5_10_crit100),precise))];[num2str(round(nanmean(frac_deg10_15_crit100),precise))];[num2str(round(nanmean(pay_deg10_15_crit100),precise))];[num2str(round(nanmean(frac_deg15_20_crit100),precise))];[num2str(round(nanmean(pay_deg15_20_crit100),precise))];[num2str(round(nanmean(frac_deg20_25_crit100),precise))];[num2str(round(nanmean(pay_deg20_25_crit100),precise))]};
Bet10={[num2str(round(nanmean(frac_deg1_bet10),precise))];[num2str(round(nanmean(pay_deg1_bet10),precise))];[num2str(round(nanmean(frac_deg2_bet10),precise))];[num2str(round(nanmean(pay_deg2_bet10),precise))];[num2str(round(nanmean(frac_deg3_bet10),precise))];[num2str(round(nanmean(pay_deg3_bet10),precise))];'\vdots';['\textbf{' num2str(round(nanmean(frac_deg5_10_bet10),precise)) '}'];['\textbf{' num2str(round(nanmean(pay_deg5_10_bet10),precise)) '}'];'.';'.';'.';'.';'.';'.'};
Bet50={[num2str(round(nanmean(frac_deg1_bet50),precise))];[num2str(round(nanmean(pay_deg1_bet50),precise))];[num2str(round(nanmean(frac_deg2_bet50),precise))];[num2str(round(nanmean(pay_deg2_bet50),precise))];[num2str(round(nanmean(frac_deg3_bet50),precise))];[num2str(round(nanmean(pay_deg3_bet50),precise))];'\vdots';[num2str(round(nanmean(frac_deg5_10_bet50),precise))];[num2str(round(nanmean(pay_deg5_10_bet50),precise))];[num2str(round(nanmean(frac_deg10_15_bet50),precise))];[num2str(round(nanmean(pay_deg10_15_bet50),precise))];[num2str(round(nanmean(frac_deg15_20_bet50),precise))];[num2str(round(nanmean(pay_deg15_20_bet50),precise))];['\textbf{' num2str(round(nanmean(frac_deg20_25_bet50),precise)) '}'];['\textbf{' num2str(round(nanmean(pay_deg20_25_bet50),precise)) '}']};
Bet100={[num2str(round(nanmean(frac_deg1_bet100),precise))];[num2str(round(nanmean(pay_deg1_bet100),precise))];[num2str(round(nanmean(frac_deg2_bet100),precise))];[num2str(round(nanmean(pay_deg2_bet100),precise))];[num2str(round(nanmean(frac_deg3_bet100),precise))];[num2str(round(nanmean(pay_deg3_bet100),precise))];'\vdots';[num2str(round(nanmean(frac_deg5_10_bet100),precise))];[num2str(round(nanmean(pay_deg5_10_bet100),precise))];[num2str(round(nanmean(frac_deg10_15_bet100),precise))];[num2str(round(nanmean(pay_deg10_15_bet100),precise))];[num2str(round(nanmean(frac_deg15_20_bet100),precise))];[num2str(round(nanmean(pay_deg15_20_bet100),precise))];['\textbf{' num2str(round(nanmean(frac_deg20_25_bet100),precise)) '}'];['\textbf{' num2str(round(nanmean(pay_deg20_25_bet100),precise)) '}']};

T=table(Links,Stats,Crit10,Crit50,Crit100,Bet10,Bet50,Bet100)

table2latex(T, 'table_incentives'); % latex format