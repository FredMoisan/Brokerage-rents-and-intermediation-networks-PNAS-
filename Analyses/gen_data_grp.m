clear all
close all force;

load time_series;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% remove first round(s) (including trial round)
start=2; % starting round
for i=1:4 % nb of groups
    Treat_pl((i-1)*50*6+1:(i-1)*50*6+50*(start-1))=0; % n=50 baseline
    Treat_pl(4*50*6+(i-1)*100*6+1:4*50*6+(i-1)*100*6+100*(start-1))=0; % n=100 baseline
    Treat_pl(4*(50+100)*6+(i-1)*50*6+1:4*(50+100)*6+(i-1)*50*6+50*(start-1))=0; % n=50 smooth
    Treat_pl(4*(50+100+50)*6+(i-1)*50*6+1:4*(50+100+50)*6+(i-1)*50*6+50*(start-1))=0; % n=50 alternative
    Treat_pl(4*(50+100+50+50)*6+(i-1)*10*6+1:4*(50+100+50+50)*6+(i-1)*10*6+10*(start-1))=0; % n=10 baseline
    Treat_pl(4*(50+100+50+50+10)*6+(i-1)*10*6+1:4*(50+100+50+50+10)*6+(i-1)*10*6+10*(start-1))=0; % n=10 smooth
    Treat_pl(4*(50+100+50+50+10+10)*6+(i-1)*10*6+1:4*(50+100+50+50+10+10)*6+(i-1)*10*6+10*(start-1))=0; % n=10 alternative
    Treat_pl(4*(50+100+50+50+10+10+10)*6+(i-1)*100*6+1:4*(50+100+50+50+10+10+10)*6+(i-1)*100*6+100*(start-1))=0; % n=100 alternative
end;

% remove unwanted rounds
Payoff_pl=Payoff_pl(find(Treat_pl>0),:);
Pay_conn_pl=Pay_conn_pl(find(Treat_pl>0),:);
Pay_inter_pl=Pay_inter_pl(find(Treat_pl>0),:);
Indeg_pl=Indeg_pl(find(Treat_pl>0),:);
Outdeg_pl=Outdeg_pl(find(Treat_pl>0),:);
Deg_pl=Deg_pl(find(Treat_pl>0),:);
Round_pl=Round_pl(find(Treat_pl>0));
Group_pl=Group_pl(find(Treat_pl>0));
Session_pl=Session_pl(find(Treat_pl>0));
id_pl=id_pl(find(Treat_pl>0));
diameter_pl=diameter_pl(find(Treat_pl>0),:);
closeness_pl=closeness_pl(find(Treat_pl>0),:);
%pairwise_add_pl=pairwise_add_pl(find(Treat_pl>0),:);
%pairwise_rem_pl=pairwise_rem_pl(find(Treat_pl>0),:);
%pairwise_pl=pairwise_pl(find(Treat_pl>0),:);
neighb_2_pl=neighb_2_pl(find(Treat_pl>0),:);
neighb_3_pl=neighb_3_pl(find(Treat_pl>0),:);
neighb_4_pl=neighb_4_pl(find(Treat_pl>0),:);
neighb_5_pl=neighb_5_pl(find(Treat_pl>0),:);
neighb_6_pl=neighb_6_pl(find(Treat_pl>0),:);
neighb_7_pl=neighb_7_pl(find(Treat_pl>0),:);
neighb_8_pl=neighb_8_pl(find(Treat_pl>0),:);
neighb_9_pl=neighb_9_pl(find(Treat_pl>0),:);
neighb_10_pl=neighb_10_pl(find(Treat_pl>0),:);
neighb_inf_pl=neighb_inf_pl(find(Treat_pl>0),:);
distance_pl=distance_pl(find(Treat_pl>0),:);
comp_size_pl=comp_size_pl(find(Treat_pl>0),:);
%Add_links_pl=Add_links_pl(find(Treat_pl>0),:);
%Rem_links_pl=Rem_links_pl(find(Treat_pl>0),:);
Treat_pl=Treat_pl(find(Treat_pl>0));

time=1;
begin=0;
r=3;
for k=1:8 % treatments
    switch k
        case 1
            n=50; % group size
            t=0; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=0;
            nb_grps=(6-(start-1))*4;
            c=40; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*v/6+(n-1)*(v/2+(n-2)*v/3)-2*(n-1)*c);
        case 7
            n=100; % group size
            t=0; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=length(find(Treat_pl<2));
            nb_grps=(6-(start-1))*4;
            c=80; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*v/6+(n-1)*(v/2+(n-2)*v/3)-2*(n-1)*c);
        case 2
            n=50; % group size
            t=1; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=length(find(Treat_pl<3));
            nb_grps=(6-(start-1))*4;
            c=40; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*r/2+(n-1)*(v/2+(n-2)*(v/2-r/2))-2*(n-1)*c);
        case 3
            n=50; % group size
            t=2; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=length(find(Treat_pl<4));
            nb_grps=(6-(start-1))*4;
            c=40; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*v/6+(n-1)*(v/2+(n-2)*v/3)-2*(n-1)*c);
        case 4
            n=10; % group size
            t=0; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=length(find(Treat_pl<5));
            nb_grps=(6-(start-1))*4;
            c=8; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*v/6+(n-1)*(v/2+(n-2)*v/3)-2*(n-1)*c);
        case 5
            n=10; % group size
            t=1; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=length(find(Treat_pl<6));
            nb_grps=(6-(start-1))*4;
            c=8; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*r/2+(n-1)*(v/2+(n-2)*(v/2-r/2))-2*(n-1)*c);
        case 6
            n=10; % group size
            t=2; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=length(find(Treat_pl<7));
            nb_grps=(6-(start-1))*4;
            c=8; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*v/6+(n-1)*(v/2+(n-2)*v/3)-2*(n-1)*c);
        case 8
            n=100; % group size
            t=2; % intermediation model (baseline=0, smooth=1, alternative=2)
            end_treat=length(find(Treat_pl<8));
            nb_grps=(6-(start-1))*4;
            c=80; % linking cost
            v=10;
            star=((n-1)*v/2+(n-1)*(n-2)*v/6+(n-1)*(v/2+(n-2)*v/3)-2*(n-1)*c);
    end;
    for i=1:nb_grps % groups
            for j=1:(360-begin)/time % blocks of time
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,1)=Group_pl((i-1)*n+1+end_treat); % group id
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,2)=Round_pl((i-1)*n+1+end_treat); % round number
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,3)=n; % group size
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,4)=t; % treatment
                hubs=zeros(1,n);
                hubs2=zeros(1,n);
                tmp_conn=mean(Pay_conn_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),2);
                tmp_inter=mean(Pay_inter_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),2);
                tmp_pay=mean(Payoff_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),2);
                tmp_outdeg=mean(Outdeg_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),2);
                tmp_indeg=mean(Indeg_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),2);
                tmp_deg=mean(Deg_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),2);
                tmp_closeness=mean(closeness_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),2);
                tmp_pl=id_pl((i-1)*n+1+end_treat:i*n+end_treat);
                overlap=tmp_deg./(tmp_indeg+tmp_outdeg-tmp_deg);
                overlap(isnan(overlap))=1;
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,5)=j; % block of time
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,6)=(n*max(tmp_deg)-sum(tmp_deg))/((n-1)*(n-2)); % degree centrality
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,7)=sum(tmp_deg)/2; % nb of links
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,8)=sum(tmp_pay); % total payoff
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,29)=sum(tmp_pay)/star; % social efficiency
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,30)=sum(tmp_inter); % total intermediation rent
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,31)=diameter_pl((i-1)*n+1+end_treat,(j-1)*time+1+begin:j*time+begin); % diameter
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,32)=sum(neighb_2_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 2
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,33)=sum(neighb_3_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 3
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,34)=sum(neighb_4_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 4
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,35)=sum(neighb_5_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 5
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,36)=sum(neighb_6_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 6
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,37)=sum(neighb_7_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 7
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,38)=sum(neighb_8_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 8
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,39)=sum(neighb_9_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 9
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,40)=sum(neighb_10_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % nb of links distance 10 or more
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,41)=sum(neighb_inf_pl((i-1)*n+1+end_treat:i*n+end_treat,(j-1)*time+1+begin:j*time+begin),1)/2; % % of disconnected players
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,42)=(n*max(tmp_closeness)-sum(tmp_closeness))/((n-1)*(n-2)/(2*n-2)); % closeness centrality
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,43)=max(tmp_inter); % max intermediation rent              
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,44)=sum(tmp_indeg); % nb of proposals
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,45)=sum(tmp_conn); % total connectivity rent
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,46)=0;%pairwise_pl((i-1)*n+1+end_treat,(j-1)*time+1+begin:j*time+begin); % profitable pairwise deviations
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,47)=mean(overlap); % average similarity (Jaccard) index
                if median(tmp_pay)>0
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,51)=max(tmp_pay)/median(tmp_pay); % inequality index
                else
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,51)=-1; % inequality index
                end;                
                if median(tmp_deg)>0
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,52)=max(tmp_deg)/median(tmp_deg); % max degree / average degree
                else
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,52)=-1; % max degree / average degree
                end;
                sorted_tmp=sort(tmp_deg,'descend');
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,53)=sorted_tmp(1); % first max degree
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,54)=sorted_tmp(2); % second max degree
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,55)=mean(tmp_deg==1); % fraction of degree 1
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,56)=mean(tmp_deg==2); % fraction of degree 2
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,57)=mean(tmp_deg==3); % fraction of degree 3
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,76)=mean(tmp_pay(tmp_deg==1)); % payoff degree 1
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,77)=mean(tmp_pay(tmp_deg==2)); % payoff degree 2
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,78)=mean(tmp_pay(tmp_deg==3)); % payoff degree 3
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,79)=mean(tmp_deg>=5 & tmp_deg<10); % fraction of degree 5-10
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,80)=mean(tmp_deg>=10 & tmp_deg<15); % fraction of degree 10-15
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,81)=mean(tmp_deg>=15 & tmp_deg<20); % fraction of degree 15-20
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,82)=mean(tmp_deg>=20 & tmp_deg<25); % fraction of degree 20-25
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,83)=mean(tmp_pay(tmp_deg>=5 & tmp_deg<10)); % payoff degree 5-10
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,84)=mean(tmp_pay(tmp_deg>=10 & tmp_deg<15)); % payoff degree 10-15
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,85)=mean(tmp_pay(tmp_deg>=15 & tmp_deg<20)); % payoff degree 15-20
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,86)=mean(tmp_pay(tmp_deg>=20 & tmp_deg<=25)); % payoff degree 20-25
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,58)=mean(tmp_closeness); % mean distance
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,59)=2*max(tmp_deg)/sum(tmp_deg); % proportion of links to one individual
                if (distance_pl((i-1)*n+1+end_treat,(j-1)*time+1+begin:j*time+begin)==inf)
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,60)=nan; % distance of largest component
                else
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,60)=distance_pl((i-1)*n+1+end_treat,(j-1)*time+1+begin:j*time+begin); % distance of largest component
                end;
                data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,61)=comp_size_pl((i-1)*n+1+end_treat,(j-1)*time+1+begin:j*time+begin); % size of largest component
                if (sum(tmp_deg)>0)
                    tmp_indeg_sorted=sort(tmp_indeg,'descend');
                    pl_max_inc_links=find(tmp_indeg==tmp_indeg_sorted(1)); % players with maximum nb of incoming proposals
                    chosen_hub=randi(length(pl_max_inc_links)); % randomly select one of the most connected players
                    hubs(pl_max_inc_links(chosen_hub))=1;
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,9)=tmp_outdeg(pl_max_inc_links(chosen_hub)); % nb of proposed links sent 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,10)=tmp_pay(pl_max_inc_links(chosen_hub)); % payoff 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,11)=tmp_conn(pl_max_inc_links(chosen_hub)); % payoff conn 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,12)=tmp_inter(pl_max_inc_links(chosen_hub)); % payoff intermediation 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,13)=tmp_indeg(pl_max_inc_links(chosen_hub)); % nb of proposed links received 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,14)=tmp_deg(pl_max_inc_links(chosen_hub)); % degree 1st hub
                    tmp_outdeg(pl_max_inc_links(chosen_hub))=nan;
                    tmp_conn(pl_max_inc_links(chosen_hub))=nan;
                    tmp_inter(pl_max_inc_links(chosen_hub))=nan;
                    tmp_pay(pl_max_inc_links(chosen_hub))=nan;
                    tmp_indeg(pl_max_inc_links(chosen_hub))=nan;                
                    tmp_deg(pl_max_inc_links(chosen_hub))=nan;
                    overlap(pl_max_inc_links(chosen_hub))=nan;
                    pl_max2_inc_links=find(tmp_indeg>=tmp_indeg_sorted(2)); % players with second maximum nb of incoming proposals
                    chosen_hub2=randi(length(pl_max2_inc_links)); % randomly select one of the most connected players
                    hubs2(pl_max2_inc_links(chosen_hub2))=1;
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,15)=nanmean(tmp_outdeg(pl_max2_inc_links(chosen_hub2))); % nb of proposed links sent 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,16)=nanmean(tmp_pay(pl_max2_inc_links(chosen_hub2))); % payoff 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,17)=nanmean(tmp_conn(pl_max2_inc_links(chosen_hub2))); % payoff conn 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,18)=nanmean(tmp_inter(pl_max2_inc_links(chosen_hub2))); % payoff intermediation 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,19)=nanmean(tmp_indeg(pl_max2_inc_links(chosen_hub2))); % nb of proposed links received 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,20)=nanmean(tmp_deg(pl_max2_inc_links(chosen_hub2))); % degree 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,21)=nanmean(tmp_outdeg); % mean nb of proposed links sent non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,22)=nanmedian(tmp_pay); % median payoff non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,23)=nanmean(tmp_conn); % median payoff conn non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,24)=nanmean(tmp_inter); % median payoff intermediation non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,25)=nanmean(tmp_indeg); % mean nb of proposed links received non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,26)=nanmean(tmp_deg); % mean degree non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,27)=tmp_pl(pl_max_inc_links(chosen_hub)); % id of main hub                    
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,62)= prctile(tmp_pay,10); % 10 percentile for others' payoffs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,63)= prctile(tmp_pay,25); % 25 percentile for others' payoffs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,64)= prctile(tmp_pay,75); % 75 percentile for others' payoffs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,65)=prctile(tmp_pay,90); % 90 percentile for others' payoffs
                    tmp=find(tmp_deg==1);
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,66)=median(tmp_pay(tmp)); % median payoff for others with 1 link
                    tmp=find(tmp_deg==2);
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,67)=median(tmp_pay(tmp)); % median payoff for others with 2 link
                    tmp=find(tmp_deg==3);
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,68)=median(tmp_pay(tmp)); % median payoff for others with at least 3 links
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,69)=length(find(tmp_deg==1)); % nb of players making 1 link
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,70)=length(find(tmp_deg==2)); % nb of players making 2 links
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,71)=length(find(tmp_deg==3)); % nb of players making 3+ links
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,72)=tmp_indeg_sorted(3); % indegree 3rd most connected
                    tmp=find(tmp_deg==1);
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,73)=mean(tmp_outdeg(tmp)); % mean outdeg for others with 1 link
                    tmp=find(tmp_deg==2);
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,74)=mean(tmp_outdeg(tmp)); % mean outdeg for others with 2 link
                    tmp=find(tmp_deg==3);
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,75)=mean(tmp_outdeg(tmp)); % mean outdeg for others with at least 3 links
                else
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,15)=0; % nb of proposed links sent 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,16)=0; % payoff 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,17)=0; % nb of proposed links received 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,18)=0; % degree 1st hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,19)=0; % nb of proposed links sent 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,20)=0; % payoff 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,21)=0; % nb of proposed links received 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,22)=0; % degree 2nd hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,23)=0; % mean nb of proposed links sent non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,24)=0; % median payoff non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,25)=0; % mean nb of proposed links received non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,26)=0; % mean degree non hubs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,27)=0; % id of main hub
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,62)= 0; % 10 percentile for others' payoffs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,63)= 0; % 25 percentile for others' payoffs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,64)= 0; % 75 percentile for others' payoffs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,65)=0; % 90 percentile for others' payoffs
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,66)=0; % median payoff for others with 1 link
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,67)=0; % median payoff for others with 2 link
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,68)=0; % median payoff for others with at least 3 links
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,69)=0; % nb of players making 1 link
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,70)=0; % nb of players making 2 links
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,71)=0; % nb of players making 3+ links
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,72)=0; % indegree 3rd most connected
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,73)=0; % mean outdeg for others with 1 link
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,74)=0; % mean outdeg for others with 2 link
                    data_grp((i-1+(k-1)*4*(6-start+1))*(360-begin)/time+j,75)=0; % mean outdeg for others with at least 3 links
                end;
            end;
    end;
end;

save('data_grp.mat','data_grp'); % save data
csvwrite('data_grp.csv',data_grp);