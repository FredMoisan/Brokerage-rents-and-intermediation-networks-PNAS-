clear all
close all force;

load Matlab_data/expdata_50_1;
subjects_50_1=subjects;
clear subjects;
load Matlab_data/expdata_50_2;
subjects_50_2=subjects;
clear subjects;
load Matlab_data/expdata_50_3;
subjects_50_3=subjects;
clear subjects;
load Matlab_data/expdata_50_4;
subjects_50_4=subjects;
clear subjects;
load Matlab_data/expdata_50_6;
subjects_50_6=subjects;
clear subjects;
load Matlab_data/expdata_50_7;
subjects_50_7=subjects;
clear subjects;
load Matlab_data/expdata_50_8;
subjects_50_8=subjects;
clear subjects;
load Matlab_data/expdata_50_9;
subjects_50_9=subjects;
clear subjects;
load Matlab_data/expdata_100_1;
subjects_100_1=subjects;
clear subjects;
load Matlab_data/expdata_100_2;
subjects_100_2=subjects;
clear subjects;
load Matlab_data/expdata_100_3;
subjects_100_3=subjects;
clear subjects;
load Matlab_data/expdata_100_4;
subjects_100_4=subjects;
clear subjects;
load Matlab_data/expdata_50_10;
subjects_50_10=subjects;
clear subjects;
load Matlab_data/expdata_50_11;
subjects_50_11=subjects;
clear subjects;
load Matlab_data/expdata_50_12;
subjects_50_12=subjects;
clear subjects;
load Matlab_data/expdata_50_13;
subjects_50_13=subjects;
clear subjects;
load Matlab_data/expdata_10_1;
subjects_10_1=subjects;
clear subjects;
load Matlab_data/expdata_10_2;
subjects_10_2=subjects;
clear subjects;
load Matlab_data/expdata_10_3;
subjects_10_3=subjects;
clear subjects;
load Matlab_data/expdata_100_5;
subjects_100_5=subjects;
clear subjects;
load Matlab_data/expdata_100_6;
subjects_100_6=subjects;
clear subjects;
load Matlab_data/expdata_100_7;
subjects_100_7=subjects;
clear subjects;
load Matlab_data/expdata_100_8;
subjects_100_8=subjects;
clear subjects;
subjects=[subjects_50_1;subjects_50_2;subjects_50_3;subjects_50_4;subjects_50_6;subjects_50_7;subjects_50_8;subjects_50_9;subjects_100_1;subjects_100_2;subjects_100_3;subjects_100_4;subjects_50_10;subjects_50_11;subjects_50_12;subjects_50_13;subjects_10_1;subjects_10_2;subjects_10_3;subjects_100_5;subjects_100_6;subjects_100_7;subjects_100_8];

load Matlab_data/data_50_1;
data_50_1=data;
clear data;
load Matlab_data/data_50_2;
data_50_2=data;
clear data;
load Matlab_data/data_50_3;
data_50_3=data;
clear data;
load Matlab_data/data_50_4;
data_50_4=data;
clear data;
load Matlab_data/data_50_6;
data_50_6=data;
clear data;
load Matlab_data/data_50_7;
data_50_7=data;
clear data;
load Matlab_data/data_50_8;
data_50_8=data;
clear data;
load Matlab_data/data_50_9;
data_50_9=data;
clear data;
load Matlab_data/data_100_1;
data_100_1=data;
clear data;
load Matlab_data/data_100_2;
data_100_2=data;
clear data;
load Matlab_data/data_100_3;
data_100_3=data;
clear data;
load Matlab_data/data_100_4;
data_100_4=data;
clear data;
load Matlab_data/data_50_10;
data_50_10=data;
clear data;
load Matlab_data/data_50_11;
data_50_11=data;
clear data;
load Matlab_data/data_50_12;
data_50_12=data;
clear data;
load Matlab_data/data_50_13;
data_50_13=data;
clear data;
load Matlab_data/data_10_1;
data_10_1=data;
clear data;
load Matlab_data/data_10_2;
data_10_2=data;
clear data;
load Matlab_data/data_10_3;
data_10_3=data;
clear data;
load Matlab_data/data_100_5;
data_100_5=data;
clear data;
load Matlab_data/data_100_6;
data_100_6=data;
clear data;
load Matlab_data/data_100_7;
data_100_7=data;
clear data;
load Matlab_data/data_100_8;
data_100_8=data;
clear data;

v=10;
r=3;
data=[data_50_1;data_50_2;data_50_3;data_50_4;data_50_6;data_50_7;data_50_8;data_50_9;data_100_1;data_100_2;data_100_3;data_100_4;data_50_10;data_50_11;data_50_12;data_50_13;data_10_1;data_10_2;data_10_3;data_100_5;data_100_6;data_100_7;data_100_8];

data=data(data(:,6)>0,:);

net=zeros(100);
prev_net=zeros(100);
id=zeros(1,100);
effort=zeros(1,100);
Outdeg=zeros(1,100);
Change=zeros(1,100);
Indeg=zeros(1,100);
payoffs=zeros(1,100);
session=0;
group=0;
roundg=0;
time=1;
prev_time=1;
sampling=0; % sampling of data points in seconds (0 = every second)
time_saved_pl=zeros(16,100)+1;
for i=1:size(data,1)
    if (data(i,1)~=session || data(i,2)~=group || data(i,3)~=roundg) % end of round
        if (i~=1)
            prev_time=time;
            shortest_path=distances(digraph(real_net(1:grp_size,1:grp_size)));            
            graph_tmp=shortest_path;
            graph_tmp(graph_tmp==inf)=-1;
            diameter=max(graph_tmp(:));
            graph_tmp=1./shortest_path;
            graph_tmp(graph_tmp==inf)=0;
            closeness=sum(graph_tmp,2)/(grp_size-1);
            [bins nb] = conncomp(graph(real_net(1:grp_size,1:grp_size)));
            nb_comp=length(unique(bins));
            tmp_id=find(nb==max(nb));
            largest=find(bins==tmp_id(1));
            graph_tmp=shortest_path(largest,largest);
            distance=sum(graph_tmp(:))/(size(graph_tmp,1)*(size(graph_tmp,1)-1));
            if treat<3 || treat==5
                [crit,crit_sd,bins,list_inter] = findcrit(real_net,grp_size);
            elseif treat==3 || treat==6
                [inter,nb_conn,nb_pay] = findbrok(real_net,grp_size);
            else
                [inter,nb_conn,nb_pay] = findbrok_alt(real_net,grp_size);
            end;
            time=360;%data(i-1,4);
            for j=1:grp_size
                Indeg(j)=sum(net(1:grp_size,j));
                if treat<3 || treat==5
                    connect=zeros(1,grp_size);
                    connect(find(bins(j,:)==1))=1; % connected players
                    connect(j)=0;
                    conn_pay=connect./(sum(crit(j,:,:),3)+2); % benefits from connectivity
                    crit_pay=crit(:,:,j)./(crit_sd+2); % benefits from criticality
                    payoffs(j)=v*(sum(conn_pay)+sum(crit_pay(:))/2)-sum(real_net(j,:))*k;
                    pay_conn=v*sum(conn_pay);
                    cost_inter=sum(connect(:))*v/2-pay_conn;
                    pay_inter=v*sum(crit_pay(:))/2;
                elseif treat==3 || treat==6
                    payoffs(j)=nb_conn(j)*v+inter(j)*r-nb_pay(j)*r-sum(real_net(j,:))*k;
                    pay_conn=nb_conn(j)*v-nb_pay(j)*r;
                    cost_inter=nb_pay(j)*r;
                    pay_inter=inter(j)*r;
                else
                    payoffs(j)=nb_conn(j)*v+inter(j)*v-sum(real_net(j,:))*k;
                    pay_conn=nb_conn(j)*v;
                    cost_inter=nb_pay(j)*v-nb_conn(j)*v;
                    pay_inter=inter(j)*v;
                end;
                id_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=subjects(subjects(:,2)==session&subjects(:,3)==group&subjects(:,23+roundg)==j,1); %id(j);
                Outdeg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=Outdeg(j);
                Update_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=Change(j);
                Add_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=add(j);
                Rem_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=rem(j);
                Indeg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=Indeg(j);
                Deg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(net(j,:).*net(:,j)');
                Payoff_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=payoffs(j); 
                Pay_conn_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=pay_conn; 
                Cost_inter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=cost_inter; 
                Pay_inter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=pay_inter; 
                Treat_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=treat; 
                Group_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=group; 
                Session_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=session; 
                Round_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=roundg; 
                diameter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=diameter; % diameter of network (excluding infinite distance)
                closeness_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=closeness(j); % closeness centrality
                neighb_2_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==2); % nb of neighbours of distance 2
                neighb_3_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==3); % nb of neighbours of distance 3
                neighb_4_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==4); % nb of neighbours of distance 4
                neighb_5_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==5); % nb of neighbours of distance 5
                neighb_6_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==6); % nb of neighbours of distance 6
                neighb_7_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==7); % nb of neighbours of distance 7
                neighb_8_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==8); % nb of neighbours of distance 8
                neighb_9_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==9); % nb of neighbours of distance 9
                neighb_10_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)>9&shortest_path(j,:)<inf); % nb of neighbours of distance at least 10 (excluding inf)
                neighb_inf_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==inf); % nb of not connected players
                net_pl(start_data2+(group-1)*6*grp_size*grp_size+grp_size*grp_size*(roundg-1)+(j-1)*grp_size+1:start_data2+(group-1)*6*grp_size*grp_size+grp_size*grp_size*(roundg-1)+j*grp_size,prev_time:time)=repmat(net(j,:),time-prev_time+1,1)'; % proposals
                distance_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=distance; % distance of largest component
                comp_size_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=length(largest); % size largest component
            end;
            Change=zeros(1,grp_size);
            add=zeros(1,grp_size);
            rem=zeros(1,grp_size);
            prev_net=zeros(grp_size);
        end;
        session=data(i,1);
        group=data(i,2);
        roundg=data(i,3);
        if (session<=4)
            grp_size=50;
            start_data=0;
            start_data2=0;
            k=40;
            treat=1; % k=40 n=50 baseline model
        elseif (session<=10)
            grp_size=100;
            start_data=4*6*50;
            start_data2=4*6*50*50;
            k=80;
            treat=2; % k=80 n=100 baseline model
        elseif (session<=14)
            grp_size=50;
            start_data=4*6*(50+100);
            start_data2=4*6*(50*50+100*100);
            k=40;
            treat=3; % k=40 n=50 smooth model
        elseif (session<19)
            grp_size=50;
            start_data=4*6*(50+100+50);
            start_data2=4*6*(50*50+100*100+50*50);
            k=40;
            treat=4; % k=40 n=50 alternative model
        elseif (session==19)
            grp_size=10;
            start_data=4*6*(50+100+50+50);
            start_data2=4*6*(50*50+100*100+50*50+50*50);
            k=8;
            treat=5; % k=8 n=10 baseline model
        elseif (session==20)
            grp_size=10;
            start_data=4*6*(50+100+50+50+10);
            start_data2=4*6*(50*50+100*100+50*50+50*50+10*10);
            k=8;
            treat=6; % k=8 n=10 smooth model
        elseif (session==21)
            grp_size=10;
            start_data=4*6*(50+100+50+50+10+10);
            start_data2=4*6*(50*50+100*100+50*50+50*50+10*10+10*10);
            k=8;
            treat=7; % k=8 n=10 alternative model
        elseif (session<=25)
            grp_size=100;
            start_data=4*6*(50+100+50+50+10+10+10);
            start_data2=4*6*(50*50+100*100+50*50+50*50+10*10+10*10+10*10);
            k=80;
            treat=8; % k=80 n=100 alternative model
        end;
        net=zeros(grp_size);
        id=zeros(1,grp_size);
        Outdeg=zeros(1,grp_size);
        Change=zeros(1,grp_size);
        add=zeros(1,grp_size);
        rem=zeros(1,grp_size);
        Indeg=zeros(1,grp_size);
        payoffs=zeros(1,grp_size);
        prev_net=zeros(grp_size);
        time=1;
    elseif (data(i,4)>time+0) %end of second
        prev_time=time;
        time=data(i,4);
        shortest_path=distances(digraph(real_net(1:grp_size,1:grp_size)));
            graph_tmp=shortest_path;
            graph_tmp(graph_tmp==inf)=-1;
            diameter=max(graph_tmp(:));
            graph_tmp=1./shortest_path;
            graph_tmp(graph_tmp==inf)=0;
            closeness=sum(graph_tmp,2)/(grp_size-1);
            [bins nb] = conncomp(graph(real_net(1:grp_size,1:grp_size)));
            nb_comp=length(unique(bins));
            tmp_id=find(nb==max(nb));
            largest=find(bins==tmp_id(1));
            graph_tmp=shortest_path(largest,largest);
            distance=sum(graph_tmp(:))/(size(graph_tmp,1)*(size(graph_tmp,1)-1));
            if treat<3 || treat==5
                [crit,crit_sd,bins,list_inter] = findcrit(real_net,grp_size);
            elseif treat==3 || treat==6
                [inter,nb_conn,nb_pay] = findbrok(real_net,grp_size);
            else
                [inter,nb_conn,nb_pay] = findbrok_alt(real_net,grp_size);
            end;
            for j=1:grp_size
            Indeg(j)=sum(net(1:grp_size,j));
            if treat<3 || treat==5
                connect=zeros(1,grp_size);
                connect(find(bins(j,:)==1))=1; % connected players
                connect(j)=0;
                conn_pay=connect./(sum(crit(j,:,:),3)+2); % benefits from connectivity
                crit_pay=crit(:,:,j)./(crit_sd+2); % benefits from criticality
                payoffs(j)=v*(sum(conn_pay)+sum(crit_pay(:))/2)-sum(real_net(j,:))*k;
                pay_conn=v*sum(conn_pay);
                cost_inter=sum(connect(:))*v/2-pay_conn;
                pay_inter=v*sum(crit_pay(:))/2;
            elseif treat==3 || treat==6
                payoffs(j)=nb_conn(j)*v+inter(j)*r-nb_pay(j)*r-sum(real_net(j,:))*k;
                pay_conn=nb_conn(j)*v-nb_pay(j)*r;
                cost_inter=nb_pay(j)*r;
                pay_inter=inter(j)*r;
            else
                payoffs(j)=nb_conn(j)*v+inter(j)*v-sum(real_net(j,:))*k;
                pay_conn=nb_conn(j)*v;
                cost_inter=nb_pay(j)*v-nb_conn(j)*v;
                pay_inter=inter(j)*v;
            end;
            id_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=subjects(subjects(:,2)==session&subjects(:,3)==group&subjects(:,23+roundg)==j,1); %id(j);
            Outdeg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=Outdeg(j);
            Update_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=Change(j);
            Add_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=add(j);
            Rem_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=rem(j);
            Indeg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=Indeg(j);
            Deg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(net(j,:).*net(:,j)');
            Payoff_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=payoffs(j); 
            Pay_conn_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=pay_conn; 
            Cost_inter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=cost_inter; 
            Pay_inter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=pay_inter;
            Treat_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=treat; 
            Group_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=group; 
            Session_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=session; 
            Round_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=roundg; 
            diameter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=diameter; % diameter of network (excluding infinite distance)
            closeness_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=closeness(j); % closeness centrality
            neighb_2_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==2); % nb of neighbours of distance 2
            neighb_3_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==3); % nb of neighbours of distance 3
            neighb_4_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==4); % nb of neighbours of distance 4
            neighb_5_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==5); % nb of neighbours of distance 5
            neighb_6_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==6); % nb of neighbours of distance 6
            neighb_7_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==7); % nb of neighbours of distance 7
            neighb_8_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==8); % nb of neighbours of distance 8
            neighb_9_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==9); % nb of neighbours of distance 9
            neighb_10_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)>9&shortest_path(j,:)<inf); % nb of neighbours of distance at least 10 (excluding inf)
            neighb_inf_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=sum(shortest_path(j,:)==inf); % nb of not connected players
            net_pl(start_data2+(group-1)*6*grp_size*grp_size+grp_size*grp_size*(roundg-1)+(j-1)*grp_size+1:start_data2+(group-1)*6*grp_size*grp_size+grp_size*grp_size*(roundg-1)+j*grp_size,prev_time:time-1)=repmat(net(j,:),time-prev_time,1)'; % proposals
            distance_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=distance; % distance of largest component   
            comp_size_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time-1)=length(largest); % size largest component
        end;
        Change=zeros(1,grp_size);
        add=zeros(1,grp_size);
        rem=zeros(1,grp_size);
        prev_net=net;
    end;
    id(data(i,5))=data(i,7);
    time_saved_pl(data(i,5))=max(1,time);
    if net(data(i,5),data(i,6))
        rem(data(i,5))=rem(data(i,5))+1;
    else
        add(data(i,5))=add(data(i,5))+1;
    end;
    net(data(i,5),data(i,6))=abs(net(data(i,5),data(i,6))-1);
    Change(data(i,5))=Change(data(i,5))+1;
    Outdeg(data(i,5))=sum(net(data(i,5),1:grp_size));
    real_net=net.*net';
end;
prev_time=time;
            nb_large_acc=zeros(1,grp_size);
            shortest_path=distances(digraph(real_net(1:grp_size,1:grp_size)));
            graph_tmp=shortest_path;
            graph_tmp(graph_tmp==inf)=-1;
            diameter=max(graph_tmp(:));
            graph_tmp=1./shortest_path;
            graph_tmp(graph_tmp==inf)=0;
            closeness=sum(graph_tmp,2)/(grp_size-1);
            [bins nb] = conncomp(graph(real_net(1:grp_size,1:grp_size)));
            nb_comp=length(unique(bins));
            tmp_id=find(nb==max(nb));
            largest=find(bins==tmp_id(1));
            graph_tmp=shortest_path(largest,largest);
            distance=sum(graph_tmp(:))/(size(graph_tmp,1)*(size(graph_tmp,1)-1));   
            if treat<3 || treat==5
                [crit,crit_sd,bins,list_inter] = findcrit(real_net,grp_size);
            elseif treat==3 || treat==6
                [inter,nb_conn,nb_pay] = findbrok(real_net,grp_size);
            else
                [inter,nb_conn,nb_pay] = findbrok_alt(real_net,grp_size);
            end;
time=360;%data(i-1,4);
for j=1:grp_size % players
    Indeg(j)=sum(net(1:grp_size,j));
    if treat<3 || treat==5
        connect=zeros(1,grp_size);
        connect(find(bins(j,:)==1))=1; % connected players
        connect(j)=0;
        conn_pay=connect./(sum(crit(j,:,:),3)+2); % benefits from connectivity
        crit_pay=crit(:,:,j)./(crit_sd+2); % benefits from criticality
        payoffs(j)=v*(sum(conn_pay)+sum(crit_pay(:))/2)-sum(real_net(j,:))*k;
        pay_conn=v*sum(conn_pay);
        cost_inter=sum(connect(:))*v/2-pay_conn;
        pay_inter=v*sum(crit_pay(:))/2;
    elseif treat==3 || treat==6
        payoffs(j)=nb_conn(j)*v+inter(j)*r-nb_pay(j)*r-sum(real_net(j,:))*k;
        pay_conn=nb_conn(j)*v-nb_pay(j)*r;
        cost_inter=nb_pay(j)*r;
        pay_inter=inter(j)*r;
    else
        payoffs(j)=nb_conn(j)*v+inter(j)*v-sum(real_net(j,:))*k;
        pay_conn=nb_conn(j)*v;
        cost_inter=nb_pay(j)*v-nb_conn(j)*v;
        pay_inter=inter(j)*v;
    end;
    id_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=subjects(subjects(:,2)==session&subjects(:,3)==group&subjects(:,23+roundg)==j,1); %id(j);
    Outdeg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=Outdeg(j);
    Update_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=Change(j);
    Add_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=add(j);
    Rem_links_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=rem(j);
    Indeg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=Indeg(j);
    Deg_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(net(j,:).*net(:,j)');
    Payoff_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=payoffs(j);
    Pay_conn_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=pay_conn; 
    Cost_inter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=cost_inter; 
    Pay_inter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=pay_inter;
    Treat_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=treat; 
    Group_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=group; 
    Session_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=session; 
    Round_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1))=roundg; 
    diameter_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=diameter; % diameter of network (excluding infinite distance)
    closeness_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=closeness(j); % closeness centrality
    neighb_2_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==2); % nb of neighbours of distance 2
    neighb_3_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==3); % nb of neighbours of distance 3
    neighb_4_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==4); % nb of neighbours of distance 4
    neighb_5_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==5); % nb of neighbours of distance 5
    neighb_6_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==6); % nb of neighbours of distance 6
    neighb_7_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==7); % nb of neighbours of distance 7
    neighb_8_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==8); % nb of neighbours of distance 8
    neighb_9_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==9); % nb of neighbours of distance 9
    neighb_10_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)>9&shortest_path(j,:)<inf); % nb of neighbours of distance at least 10 (excluding inf)
    neighb_inf_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=sum(shortest_path(j,:)==inf); % nb of not connected players
    net_pl(start_data2+(group-1)*6*grp_size*grp_size+grp_size*grp_size*(roundg-1)+(j-1)*grp_size+1:start_data2+(group-1)*6*grp_size*grp_size+grp_size*grp_size*(roundg-1)+j*grp_size,prev_time:time)=repmat(net(j,:),time-prev_time+1,1)'; % proposals
    distance_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=distance; % distance of largest component
    comp_size_pl(j+start_data+(group-1)*6*grp_size+grp_size*(roundg-1),prev_time:time)=length(largest); % size largest component
end;

% remove extra time due to screen update
Outdeg_pl(:,361:size(Outdeg_pl,2))=[];
Update_links_pl(:,361:size(Update_links_pl,2))=[];
Add_links_pl(:,361:size(Add_links_pl,2))=[];
Rem_links_pl(:,361:size(Rem_links_pl,2))=[];
Indeg_pl(:,361:size(Indeg_pl,2))=[];
Deg_pl(:,361:size(Deg_pl,2))=[];
Payoff_pl(:,361:size(Payoff_pl,2))=[];
Pay_conn_pl(:,361:size(Pay_conn_pl,2))=[];
Cost_inter_pl(:,361:size(Cost_inter_pl,2))=[];
Pay_inter_pl(:,361:size(Pay_inter_pl,2))=[];
diameter_pl(:,361:size(diameter_pl,2))=[];
closeness_pl(:,361:size(closeness_pl,2))=[];
neighb_2_pl(:,361:size(neighb_2_pl,2))=[];
neighb_3_pl(:,361:size(neighb_3_pl,2))=[];
neighb_4_pl(:,361:size(neighb_4_pl,2))=[];
neighb_5_pl(:,361:size(neighb_5_pl,2))=[];
neighb_6_pl(:,361:size(neighb_6_pl,2))=[];
neighb_7_pl(:,361:size(neighb_7_pl,2))=[];
neighb_8_pl(:,361:size(neighb_8_pl,2))=[];
neighb_9_pl(:,361:size(neighb_9_pl,2))=[];
neighb_10_pl(:,361:size(neighb_10_pl,2))=[];
neighb_inf_pl(:,361:size(neighb_inf_pl,2))=[];
net_pl(:,361:size(net_pl,2))=[];
comp_size_pl(:,361:size(comp_size_pl,2))=[];
        
save('time_series.mat','id_pl','Deg_pl','Outdeg_pl','Indeg_pl','Add_links_pl','Rem_links_pl','Payoff_pl','Pay_conn_pl','Cost_inter_pl','Pay_inter_pl','Treat_pl','Group_pl','Session_pl','Round_pl','diameter_pl','closeness_pl','neighb_2_pl','neighb_3_pl','neighb_4_pl','neighb_5_pl','neighb_6_pl','neighb_7_pl','neighb_8_pl','neighb_9_pl','neighb_10_pl','neighb_inf_pl','net_pl','distance_pl','comp_size_pl','subjects'); % save time series data