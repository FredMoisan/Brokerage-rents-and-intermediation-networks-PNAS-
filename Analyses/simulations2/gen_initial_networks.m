clear all
close all force;

load ../time_series;

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


Treat_pl=Treat_pl(~isnan(Treat_pl));
net_pl=net_pl(~isnan(net_pl(:,1)),:);

crit_10=[];
crit_50=[];
crit_100=[];

bet_10=[];
bet_50=[];
bet_100=[];

for i=1:4*(7-start)*8
    if i<=4*(7-start)
        treat=1; % baseline
        start_data=0;    
        start_data2=0;
        ind=i;
        n=50;
        k=40;
    elseif i<=4*(7-start)*2
        treat=2; % baseline
        start_data=4*(7-start)*50;    
        start_data2=4*(7-start)*(50*50);    
        ind=i-4*(7-start);
        n=100;
        k=80;
    elseif i<=4*(7-start)*3
        treat=3; % smooth
        start_data=4*(7-start)*(50+100);    
        start_data2=4*(7-start)*(50*50+100*100);    
        ind=i-4*(7-start)*2;
        n=50;
        k=40;
    elseif i<=4*(7-start)*4
        treat=4; % alternative
        start_data=4*(7-start)*(50+100+50);    
        start_data2=4*(7-start)*(50*50+100*100+50*50);    
        ind=i-4*(7-start)*3;
        n=50;
        k=40;
    elseif i<=4*(7-start)*5
        treat=5; % baseline
        start_data=4*(7-start)*(50+100+50+50);    
        start_data2=4*(7-start)*(50*50+100*100+50*50+50*50);    
        ind=i-4*(7-start)*4;
        n=10;
        k=8;
    elseif i<=4*(7-start)*6
        treat=6; % smooth
        start_data=4*(7-start)*(50+100+50+50+10);    
        start_data2=4*(7-start)*(50*50+100*100+50*50+50*50+10*10);    
        ind=i-4*(7-start)*5;
        n=10;
        k=8;
    elseif i<=4*(7-start)*7
        treat=7; % alternative
        start_data=4*(7-start)*(50+100+50+50+10+10);    
        start_data2=4*(7-start)*((50*50)*3+100*100+(10*10)*2);    
        ind=i-4*(7-start)*6;
        n=10;
        k=8;
    elseif i<=4*(7-start)*8
        treat=8; % alternative
        start_data=4*(7-start)*(50*3+100+10*3);    
        start_data2=4*(7-start)*((50*50)*3+100*100+(10*10)*3);    
        ind=i-4*(7-start)*7;
        n=100;
        k=80;
    end;
    if treat==1
        crit_50=[crit_50;net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,60)'];
    elseif treat==2
        crit_100=[crit_100;net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,60)'];
    elseif treat==4
        bet_50=[bet_50;net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,60)'];
    elseif treat==5
        crit_10=[crit_10;net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,60)'];
    elseif treat==7
        bet_10=[bet_10;net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,60)'];
    elseif treat==8
        bet_100=[bet_100;net_pl(start_data2+(ind-1)*n*n+1:start_data2+ind*n*n,60)'];
    end;
end;
net=crit_10;
save(['start_crit_10.mat'],'net');
net=crit_50;
save(['start_crit_50.mat'],'net');
net=crit_100;
save(['start_crit_100.mat'],'net');

net=bet_10;
save(['start_bet_10.mat'],'net');
net=bet_50;
save(['start_bet_50.mat'],'net');
net=bet_100;
save(['start_bet_100.mat'],'net');
