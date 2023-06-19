clear all
close all force;

load time_series;

% remove first round(s) (including trial round)
start=2; % starting round
for i=1:4 % nb of groups
    Treat_pl((i-1)*50*6+1:(i-1)*50*6+50*(start-1))=nan; % n=50 baseline
    Treat_pl(4*50*6+(i-1)*100*6+1:4*50*6+(i-1)*100*6+100*(start-1))=nan; % n=100 baseline
    Treat_pl(4*(50+100)*6+(i-1)*50*6+1:4*(50+100)*6+(i-1)*50*6+50*(start-1))=nan; % n=50 smooth
    Treat_pl(4*(50+100+50)*6+(i-1)*50*6+1:4*(50+100+50)*6+(i-1)*50*6+50*(start-1))=nan; % n=50 alternative
    Treat_pl(4*(50+100+50+50)*6+(i-1)*10*6+1:4*(50+100+50+50)*6+(i-1)*10*6+10*(start-1))=nan; % n=10 baseline
    Treat_pl(4*(50+100+50+50+10)*6+(i-1)*10*6+1:4*(50+100+50+50+10)*6+(i-1)*10*6+10*(start-1))=nan; % n=10 smooth
    Treat_pl(4*(50+100+50+50+10+10)*6+(i-1)*10*6+1:4*(50+100+50+50+10+10)*6+(i-1)*10*6+10*(start-1))=nan; % n=10 alternative
    Treat_pl(4*(50+100+50+50+10+10+10)*6+(i-1)*100*6+1:4*(50+100+50+50+10+10+10)*6+(i-1)*100*6+100*(start-1))=nan; % n=100 alternative
    
    net_pl((i-1)*50*50*6+1:(i-1)*50*50*6+50*50*(start-1),:)=nan; % n=50 baseline
    net_pl(4*50*50*6+(i-1)*100*100*6+1:4*50*50*6+(i-1)*100*100*6+100*100*(start-1),:)=nan; % n=100 baseline
    net_pl(4*(50*50+100*100)*6+(i-1)*50*50*6+1:4*(50*50+100*100)*6+(i-1)*50*50*6+50*50*(start-1),:)=nan; % n=50 smooth
    net_pl(4*(50*50+100*100+50*50)*6+(i-1)*50*50*6+1:4*(50*50+100*100+50*50)*6+(i-1)*50*50*6+50*50*(start-1),:)=nan; % n=50 alternative
    net_pl(4*(50*50+100*100+50*50+50*50)*6+(i-1)*10*10*6+1:4*(50*50+100*100+50*50+50*50)*6+(i-1)*10*10*6+10*10*(start-1))=nan; % n=10 baseline
    net_pl(4*(50*50+100*100+50*50+50*50+10*10)*6+(i-1)*10*10*6+1:4*(50*50+100*100+50*50+50*50+10*10)*6+(i-1)*10*10*6+10*10*(start-1))=nan; % n=10 smooth
    net_pl(4*(50*50+100*100+50*50+50*50+10*10+10*10)*6+(i-1)*10*10*6+1:4*(50*50+100*100+50*50+50*50+10*10+10*10)*6+(i-1)*10*10*6+10*10*(start-1))=nan; % n=10 alternative
    net_pl(4*(50*50+100*100+50*50+50*50+10*10+10*10+10*10)*6+(i-1)*100*100*6+1:4*(50*50+100*100+50*50+50*50+10*10+10*10+10*10)*6+(i-1)*100*100*6+100*100*(start-1))=nan; % n=100 alternative
end;

Round_pl=Round_pl(~isnan(Treat_pl));
Group_pl=Group_pl(~isnan(Treat_pl));
Treat_pl=Treat_pl(~isnan(Treat_pl));
net_pl=net_pl(~isnan(net_pl(:,1)),:);

lag=1;

if ~exist('preprocessed', 'dir')
    mkdir('preprocessed');
end;

for i=1:4*5*9
    if i<=4*5
        treat=1; % baseline
        start_data=0;    
        start_data2=0;
        ind=i;
        n=50;
        k=40;
    elseif i<=4*5*2
        treat=2; % baseline
        start_data=4*5*50;    
        start_data2=4*5*(50*50);    
        ind=i-4*5;
        n=100;
        k=80;
    elseif i<=4*5*3
        treat=3; % smooth
        start_data=4*5*(50+100);    
        start_data2=4*5*(50*50+100*100);    
        ind=i-4*5*2;
        n=50;
        k=40;
    elseif i<=4*5*4
        treat=4; % alternative
        start_data=4*5*(50+100+50);    
        start_data2=4*5*(50*50+100*100+50*50);    
        ind=i-4*5*3;
        n=50;
        k=40;
    elseif i<=4*5*5
        treat=5; % baseline
        start_data=4*5*(50+100+50+50);    
        start_data2=4*5*(50*50+100*100+50*50+50*50);    
        ind=i-4*5*4;
        n=10;
        k=8;
    elseif i<=4*5*6
        treat=6; % smooth
        start_data=4*5*(50+100+50+50+10);    
        start_data2=4*5*(50*50+100*100+50*50+50*50+10*10);    
        ind=i-4*5*5;
        n=10;
        k=8;
    elseif i<=4*5*7
        treat=7; % alternative
        start_data=4*5*(50+100+50+50+10+10);    
        start_data2=4*5*((50*50)*3+100*100+(10*10)*2);    
        ind=i-4*5*6;
        n=10;
        k=8;
    elseif i<=4*5*8
        treat=8; % alternative
        start_data=4*5*(50*3+100+10*3);    
        start_data2=4*5*((50*50)*3+100*100+(10*10)*3);    
        ind=i-4*5*7;
        n=100;
        k=80;
    end;
    if treat~=3 && treat~=6
    group=Group_pl(start_data+(ind-1)*n+1);
    roundg=Round_pl(start_data+(ind-1)*n+1);
    clear prev_net net pay_link choice_link deg_link;
    parfor j=2:360/lag
        prev_net=reshape(net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,j*lag-lag),[n,n])';
        net=reshape(net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,j*lag),[n,n])';
        [pay choice]=find_payoffs(treat,prev_net,net,n,k);       
        pay_link(:,j)=pay;
        choice_link(:,j)=choice;
        deg_link(:,j)=sum(prev_net.*prev_net',2);
    end;
    save(['preprocessed/payoffs_' num2str(treat) '_' num2str(group) '_' num2str(roundg) '.mat'],'pay_link','choice_link','deg_link');
    end;
end;