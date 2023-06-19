function [pay_res inter_res conn_res distance deg indeg outdeg add_prop add_link del_link no_move G] = simul_critical(G,act,n, k,iter_trial,lambda,delta)

v=10;

pay_conn=zeros(1,n);
pay_inter=zeros(1,n);
add_link=zeros(1,n);
add_prop=zeros(1,n);
del_link=zeros(1,n);
no_move=zeros(1,n);
next_G=G;
Gu=G.*G';
[crit,crit_sd,bins,list_inter] = findcrit(Gu,n);
nb_connect=0;
% initial network
for i=1:n
    connect=zeros(1,n);
    connect(find(bins(i,:)))=1; % connected players
    connect(i)=0;
    nb_connect=nb_connect+sum(connect);
    conn_pay=connect./(sum(crit(i,:,:),3)+2); % benefits from connectivity
    crit_pay=crit(:,:,i)./(crit_sd+2); % benefits from criticality
    pay_res(i,1)=v*(sum(conn_pay)+sum(crit_pay(:))/2)-sum(Gu(i,:))*k;
    pay_inter(i)=sum(crit_pay(:))/2;
    pay_conn(i)=sum(conn_pay);
end;
shortest_path=distances(digraph(Gu)); 
[bins nb] = conncomp(graph(Gu));
nb_comp=length(unique(bins));
tmp_id=find(nb==max(nb));
largest=find(bins==tmp_id(1));
graph_tmp=shortest_path(largest,largest);
if (size(graph_tmp,1)>1)
    distance(1)=sum(graph_tmp(:))/(size(graph_tmp,1)*(size(graph_tmp,1)-1));
else
    distance(1)=0;
end;
conn_res(1)=nb_connect/(n*(n-1));
inter_res(1)=sum(pay_inter)/(sum(pay_conn)+sum(pay_inter));
deg(:,1)=sum(Gu,2); 
indeg(:,1)=sum(G,1)';
outdeg(:,1)=sum(G,2);
lambda_var=lambda(1);
delta_var=delta(1);
% start simulation
seconds=size(act,1);
for j=1:seconds
    if (j==iter_trial+1)
        lambda_var=lambda(2);
        delta_var=delta(2);
    end;
    for i=1:n
        if (act(j,i)==1)
            rnd_choice=find_payoffs(0,G,i,n,k,lambda_var,delta_var);
            deg_tmp=sum(G(i,:).*G(:,i)')+1;
            if (rnd_choice~=i)
                next_G(i,rnd_choice)=abs(G(i,rnd_choice)-1);
                if (next_G(i,rnd_choice)==1 && G(rnd_choice,i)==1)
                    add_link(deg_tmp)=add_link(deg_tmp)+1;
                elseif (next_G(i,rnd_choice)==1 && G(rnd_choice,i)==0)
                    add_prop(deg_tmp)=add_prop(deg_tmp)+1;
                elseif (next_G(i,rnd_choice)==0)
                    del_link(deg_tmp)=del_link(deg_tmp)+1;
                end;
            else
                no_move(deg_tmp)=no_move(deg_tmp)+1;
            end;
            G=next_G; % update network after each move (comment if simultaneous updates)
        end;
    end;
    G=next_G;
    Gu=G.*G';
    [crit,crit_sd,bins,list_inter] = findcrit(Gu,n);
    nb_connect=0;
    for i=1:n
        connect=zeros(1,n);
        connect(find(bins(i,:)))=1; % connected players
        connect(i)=0;
        nb_connect=nb_connect+sum(connect);
        conn_pay=connect./(sum(crit(i,:,:),3)+2); % benefits from connectivity
        crit_pay=crit(:,:,i)./(crit_sd+2); % benefits from criticality
        pay_res(i,j)=v*(sum(conn_pay)+sum(crit_pay(:))/2)-sum(Gu(i,:))*k;
        pay_inter(i)=sum(crit_pay(:))/2;
        pay_conn(i)=sum(conn_pay);
    end;
    shortest_path=distances(digraph(Gu)); 
    [bins nb] = conncomp(graph(Gu));
    nb_comp=length(unique(bins));
    tmp_id=find(nb==max(nb));
    largest=find(bins==tmp_id(1));
    graph_tmp=shortest_path(largest,largest);
    if (size(graph_tmp,1)>1)
        distance(j)=sum(graph_tmp(:))/(size(graph_tmp,1)*(size(graph_tmp,1)-1));
    else
        distance(j)=0;
    end;
    conn_res(j)=nb_connect/(n*(n-1));
    inter_res(j)=sum(pay_inter)/(sum(pay_conn)+sum(pay_inter));
%    soc_eff(j)=sum(pay_end)/((n-1)*(v-2*k+(n-2)*v/2));
%    ineq(j)=max(pay_end)/median(pay_end);
    deg(:,j)=sum(Gu,2);
    indeg(:,j)=sum(G,1)';
    outdeg(:,j)=sum(G,2);
end;

% soc_eff=sum(pay)/((n-1)*(v-2*k+(n-2)*v/2));
% ineq=max(pay)/median(pay);
% inter=sum(pay_inter)/(sum(pay_conn)+sum(pay_inter));
% %[a,b]=sort(pay);
% %distr_inter=pay_inter(b)/((n-1)*(n-2)*v/3);
% nb_proposals=sum(G(:));
% Gu=G.*G';
% nb_links=sum(Gu(:))/2;
% deg=sum(Gu);
% indeg=sum(G,1);
% outdeg=sum(G,2)';
% %distr_deg=histcounts(sum(G),[0:1:n]);
% shortest_path=graphallshortestpaths(sparse(Gu),'directed',false); 
% graph_tmp=shortest_path;
% graph_tmp(graph_tmp==inf)=-1;
% diameter=max(graph_tmp(:));
% graph_tmp=1./shortest_path;
% graph_tmp(graph_tmp==inf)=0;
% closeness=sum(graph_tmp,2)/(n-1);
% closeness_centrality=(n*max(closeness)-sum(closeness))/((n-1)*(n-2)/(2*n-3));
% deg_centrality=(n*max(sum(Gu))-sum(Gu(:)))/((n-1)*(n-2));

%plot(graph(G.*G'))

end