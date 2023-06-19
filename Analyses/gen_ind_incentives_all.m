clear all
close all force;

start=60;
ending=360;

round=2;

for t=1:6
    if (t==1)
        treat=5; % criticality n=10
        pricing=0;
        n=10;
    elseif (t==2)
        treat=1; % criticality n=50
        pricing=0;
        n=50;
    elseif (t==3)
        treat=2; % criticality n=100
        pricing=0;
        n=100;
    elseif (t==4)
        treat=7; % betweenness n=10
        pricing=1;
        n=10;
    elseif (t==5)
        treat=4; % betweenness n=50
        pricing=1;
        n=50;
    elseif (t==6)
        treat=8; % betweenness n=100
        pricing=1;
        n=100;
    end;
    for i=1:4
        for j=round:6
            filename=['preprocessed/payoffs_' num2str(treat) '_' num2str(i) '_' num2str(j) '.mat'];
            load(filename);
            for l=start+1:ending
                clear pay_tmp choice_tmp pay_max_add pay_min_add pay_max_del pay_min_del pay_max pay_min;
                for k=1:n % replace hypothetical payoffs with real payoffs
                    tmp=choice_link(k*(n+1),l);
                    if (tmp==0) % action of doing nothing
                        tmp=k;
                    end;
                    my_choices=choice_link((k-1)*(n+1)+1:(k-1)*(n+1)+n,l); % set of actual + hypothetical choices
                    my_payoffs=pay_link((k-1)*(n+1)+1:(k-1)*(n+1)+n,l); % set of actual + hypothetical payoffs
                    if (my_choices(tmp)==0.5 || my_choices(tmp)==-0.5) % filter actual choices
                        pay_tmp(k)=my_payoffs(k);
                        choice_tmp(k)=0;
                    else
                        pay_tmp(k)=pay_link(k*(n+1),l);
                        choice_tmp(k)=my_choices(tmp);
                    end;
                    if (isempty(my_payoffs(my_choices==1))) % max/min payoff for adding a link
                        pay_max_add(k)=nan;
                        pay_min_add(k)=nan;
                    else
                        pay_max_add(k)=max(my_payoffs(my_choices==1));
                        pay_min_add(k)=min(my_payoffs(my_choices==1));
                    end;
                    if (isempty(my_payoffs(my_choices==-1))) % max/min payoff for deleting a link
                        pay_max_del(k)=nan;
                        pay_min_del(k)=nan;
                    else
                        pay_max_del(k)=max(my_payoffs(my_choices==-1));
                        pay_min_del(k)=min(my_payoffs(my_choices==-1));
                    end;
                    if (isempty(my_payoffs(my_choices==1|my_choices==-1))) % max/min payoff for adding or deleting a link
                        pay_max(k)=nan;
                        pay_min(k)=nan;
                    else
                        pay_max(k)=max(my_payoffs(my_choices==1|my_choices==-1));
                        pay_min(k)=min(my_payoffs(my_choices==1|my_choices==-1));
                    end;
                end;
                for k=1:28 % select range of degrees
                    if k<11
                        low=k-1;
                        high=k;
                    else % blocks of 5 degrees to avoid limited samples
                        low=5*k-45;
                        high=5*k-40;
                    end;
                    deg_post=deg_link(:,l)'+choice_tmp; % actual degree ex post
                    payoffs_add=pay_tmp(deg_link(:,l)>=low & deg_link(:,l)<high & choice_tmp'==1);
                    payoffs_del=pay_tmp(deg_link(:,l)>=low & deg_link(:,l)<high & choice_tmp'==-1);
                    payoffs_all=pay_tmp(deg_post>=low & deg_post<high);
                    payoffs_max_add=pay_max_add(deg_link(:,l)>=low & deg_link(:,l)<high);
                    payoffs_max_del=pay_max_add(deg_link(:,l)>=low & deg_link(:,l)<high);
                    payoffs_max=pay_max(deg_link(:,l)>=low & deg_link(:,l)<high);
                    payoffs_min_add=pay_min_add(deg_link(:,l)>=low & deg_link(:,l)<high);
                    payoffs_min_del=pay_min_add(deg_link(:,l)>=low & deg_link(:,l)<high);
                    payoffs_min=pay_min(deg_link(:,l)>=low & deg_link(:,l)<high);
                    if (n==10 && k<11)
                        if (pricing==0)
                            max_add_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_add); % max payoff for adding a link
                            max_del_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_del); % max payoff for deleting a link
                            max_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max); % max payoff for adding/deleting a link or doing nothing

                            min_add_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_add); % min payoff for adding a link
                            min_del_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_del); % min payoff for deleting a link
                            min_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min); % min payoff for adding/deleting a link or doing nothing
                            
                            pay_add_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_add); % actual payoff for adding a link
                            pay_del_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_del); % actual payoff for deleting a link
                            pay_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_all); % actual payoff for adding/deleting a link or doing nothing (ex post)

                            nb_crit_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=sum(deg_post>=low & deg_post<high); % number of subjects with specific degree ex post
                            nb_crit_add_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_add); % number of subjects adding a link
                            nb_crit_del_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_del); % number of subjects deleting a link
                        else
                            max_add_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_add); % max payoff for adding a link
                            max_del_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_del); % max payoff for deleting a link
                            max_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max); % max payoff for adding/deleting a link or doing nothing

                            min_add_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_add); % min payoff for adding a link
                            min_del_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_del); % min payoff for deleting a link
                            min_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min); % min payoff for adding/deleting a link or doing nothing (ex post)
                            
                            pay_add_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_add); % actual payoff for adding a link
                            pay_del_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_del); % actual payoff for deleting a link
                            pay_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_all); % actual payoff for adding/deleting a link or doing nothing

                            nb_bet_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=sum(deg_post>=low & deg_post<high); % number of subjects with specific degree ex post
                            nb_bet_add_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_add); % number of subjects adding a link
                            nb_bet_del_10((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_del); % number of subjects deleting a link
                        end;
                    end;
                    if (n==50 && k<19)
                        if (pricing==0)
                            max_add_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_add); % max payoff for adding a link
                            max_del_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_del); % max payoff for deleting a link
                            max_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max); % max payoff for adding/deleting a link or doing nothing

                            min_add_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_add); % min payoff for adding a link
                            min_del_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_del); % min payoff for deleting a link
                            min_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min); % min payoff for adding/deleting a link or doing nothing
                            
                            pay_add_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_add); % actual payoff for adding a link
                            pay_del_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_del); % actual payoff for deleting a link
                            pay_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_all); % actual payoff for adding/deleting a link or doing nothing (ex post)

                            nb_crit_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=sum(deg_post>=low & deg_post<high); % number of subjects with specific degree ex post
                            nb_crit_add_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_add); % number of subjects adding a link
                            nb_crit_del_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_del); % number of subjects deleting a link
                        else
                            max_add_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_add); % max payoff for adding a link
                            max_del_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_del); % max payoff for deleting a link
                            max_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max); % max payoff for adding/deleting a link or doing nothing

                            min_add_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_add); % min payoff for adding a link
                            min_del_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_del); % min payoff for deleting a link
                            min_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min); % min payoff for adding/deleting a link or doing nothing (ex post)
                            
                            pay_add_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_add); % actual payoff for adding a link
                            pay_del_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_del); % actual payoff for deleting a link
                            pay_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_all); % actual payoff for adding/deleting a link or doing nothing

                            nb_bet_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=sum(deg_post>=low & deg_post<high); % number of subjects with specific degree ex post
                            nb_bet_add_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_add); % number of subjects adding a link
                            nb_bet_del_50((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_del); % number of subjects deleting a link
                        end;
                    end;
                    if (n==100)
                        if (pricing==0)
                            max_add_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_add); % max payoff for adding a link
                            max_del_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_del); % max payoff for deleting a link
                            max_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max); % max payoff for adding/deleting a link or doing nothing

                            min_add_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_add); % min payoff for adding a link
                            min_del_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_del); % min payoff for deleting a link
                            min_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min); % min payoff for adding/deleting a link or doing nothing
                            
                            pay_add_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_add); % actual payoff for adding a link
                            pay_del_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_del); % actual payoff for deleting a link
                            pay_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_all); % actual payoff for adding/deleting a link or doing nothing (ex post)

                            nb_crit_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=sum(deg_post>=low & deg_post<high); % number of subjects with specific degree ex post
                            nb_crit_add_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_add); % number of subjects adding a link
                            nb_crit_del_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_del); % number of subjects deleting a link
                        else
                            max_add_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_add); % max payoff for adding a link
                            max_del_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max_del); % max payoff for deleting a link
                            max_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_max); % max payoff for adding/deleting a link or doing nothing

                            min_add_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_add); % min payoff for adding a link
                            min_del_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min_del); % min payoff for deleting a link
                            min_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_min); % min payoff for adding/deleting a link or doing nothing (ex post)
                            
                            pay_add_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_add); % actual payoff for adding a link
                            pay_del_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_del); % actual payoff for deleting a link
                            pay_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=nanmean(payoffs_all); % actual payoff for adding/deleting a link or doing nothing

                            nb_bet_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=sum(deg_post>=low & deg_post<high); % number of subjects with specific degree ex post
                            nb_bet_add_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_add); % number of subjects adding a link
                            nb_bet_del_100((i-1)*(7-round)*(ending-start)+(j-round)*(ending-start)+l-start,k)=length(payoffs_del); % number of subjects deleting a link
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

save('ind_incentives_data_deg.mat','max_add_crit_10','min_add_crit_10','pay_add_crit_10','max_del_crit_10','min_del_crit_10','pay_del_crit_10','pay_crit_10','max_add_bet_10','min_add_bet_10','pay_add_bet_10','max_del_bet_10','min_del_bet_10','pay_del_bet_10','pay_bet_10','max_add_crit_50','min_add_crit_50','pay_add_crit_50','max_del_crit_50','min_del_crit_50','pay_del_crit_50','pay_crit_50','max_add_bet_50','min_add_bet_50','pay_add_bet_50','max_del_bet_50','min_del_bet_50','pay_del_bet_50','pay_bet_50','max_add_crit_100','min_add_crit_100','pay_add_crit_100','max_del_crit_100','min_del_crit_100','pay_del_crit_100','pay_crit_100','max_add_bet_100','min_add_bet_100','pay_add_bet_100','max_del_bet_100','min_del_bet_100','pay_del_bet_100','pay_bet_100','nb_crit_10','nb_crit_add_10','nb_crit_del_10','nb_crit_50','nb_crit_add_50','nb_crit_del_50','nb_crit_100','nb_crit_add_100','nb_crit_del_100','nb_bet_10','nb_bet_add_10','nb_bet_del_10','nb_bet_50','nb_bet_add_50','nb_bet_del_50','nb_bet_100','nb_bet_add_100','nb_bet_del_100')