clear all
close all force;

clear payoffs degree;
load(['simul_between_10']);
pay_between_10=payoffs;
deg_between_10=degree;

clear payoffs degree;
load(['simul_critical_10']);
pay_critical_10=payoffs;
deg_critical_10=degree;

clear payoffs degree;
load(['simul_between_50']);
pay_between_50=payoffs;
deg_between_50=degree;

clear payoffs degree;
load(['simul_critical_50']);
pay_critical_50=payoffs;
deg_critical_50=degree;

clear payoffs degree;
load(['simul_between_100']);
pay_between_100=payoffs;
deg_between_100=degree;

clear payoffs degree;
load(['simul_critical_100']);
pay_critical_100=payoffs;
deg_critical_100=degree;

start=0;
ending=300;


    for i=1:size(deg_critical_10,1)/10
            for l=start+1:ending

                for k=1:28 % select range of degrees
                    if k<11
                        low=k-1;
                        high=k;
                    else % blocks of 5 degrees to avoid limited samples
                        low=5*k-45;
                        high=5*k-40;
                    end;
                    if (k<11)
                        pay_tmp=pay_critical_10((i-1)*10+1:i*10,l);
                        deg_tmp=deg_critical_10((i-1)*10+1:i*10,l);
                        pay_crit_10_simul((i-1)*(ending-start)+l-start,k)=nanmean(pay_tmp(deg_tmp>=low & deg_tmp<high)); % payoff 
                        nb_crit_10_simul((i-1)*(ending-start)+l-start,k)=sum(deg_tmp>=low & deg_tmp<high); % number of subjects with specific degree ex post

                        pay_tmp=pay_between_10((i-1)*10+1:i*10,l);
                        deg_tmp=deg_between_10((i-1)*10+1:i*10,l);
                        pay_bet_10_simul((i-1)*(ending-start)+l-start,k)=nanmean(pay_tmp(deg_tmp>=low & deg_tmp<high)); % payoff 
                        nb_bet_10_simul((i-1)*(ending-start)+l-start,k)=sum(deg_tmp>=low & deg_tmp<high); % number of subjects with specific degree ex post
                    end;

                    if (k<19)
                        pay_tmp=pay_critical_50((i-1)*50+1:i*50,l);
                        deg_tmp=deg_critical_50((i-1)*50+1:i*50,l);
                        pay_crit_50_simul((i-1)*(ending-start)+l-start,k)=nanmean(pay_tmp(deg_tmp>=low & deg_tmp<high)); % payoff 
                        nb_crit_50_simul((i-1)*(ending-start)+l-start,k)=sum(deg_tmp>=low & deg_tmp<high); % number of subjects with specific degree ex post

                        pay_tmp=pay_between_50((i-1)*50+1:i*50,l);
                        deg_tmp=deg_between_50((i-1)*50+1:i*50,l);
                        pay_bet_50_simul((i-1)*(ending-start)+l-start,k)=nanmean(pay_tmp(deg_tmp>=low & deg_tmp<high)); % payoff 
                        nb_bet_50_simul((i-1)*(ending-start)+l-start,k)=sum(deg_tmp>=low & deg_tmp<high); % number of subjects with specific degree ex post
                    end;

                    pay_tmp=pay_critical_100((i-1)*100+1:i*100,l);
                    deg_tmp=deg_critical_100((i-1)*100+1:i*100,l);
                    pay_crit_100_simul((i-1)*(ending-start)+l-start,k)=nanmean(pay_tmp(deg_tmp>=low & deg_tmp<high)); % payoff 
                    nb_crit_100_simul((i-1)*(ending-start)+l-start,k)=sum(deg_tmp>=low & deg_tmp<high); % number of subjects with specific degree ex post

                    pay_tmp=pay_between_100((i-1)*100+1:i*100,l);
                    deg_tmp=deg_between_100((i-1)*100+1:i*100,l);
                    pay_bet_100_simul((i-1)*(ending-start)+l-start,k)=nanmean(pay_tmp(deg_tmp>=low & deg_tmp<high)); % payoff 
                    nb_bet_100_simul((i-1)*(ending-start)+l-start,k)=sum(deg_tmp>=low & deg_tmp<high); % number of subjects with specific degree ex post
                end;
            end;
        end;

save('ind_incentives_data_simul.mat','pay_crit_10_simul','nb_crit_10_simul','pay_crit_50_simul','nb_crit_50_simul','pay_crit_100_simul','nb_crit_100_simul','pay_bet_10_simul','nb_bet_10_simul','pay_bet_50_simul','nb_bet_50_simul','pay_bet_100_simul','nb_bet_100_simul')