function [pay_res inter_res conn_res distance deg indeg outdeg add_prop add_link del_link no_move iterations G] = simul_critical(G,n, k, max_iter,iter_trial,lambda,delta,prob_activity)

v=10;

iterations=1;
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
    pay_res(i,iterations)=v*(sum(conn_pay)+sum(crit_pay(:))/2)-sum(Gu(i,:))*k;
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
    distance(iterations)=sum(graph_tmp(:))/(size(graph_tmp,1)*(size(graph_tmp,1)-1));
else
    distance(iterations)=0;
end;
conn_res(iterations)=nb_connect/(n*(n-1));
inter_res(iterations)=sum(pay_inter)/(sum(pay_conn)+sum(pay_inter));
deg(:,iterations)=sum(Gu,2); 
indeg(:,iterations)=sum(G,1)';
outdeg(:,iterations)=sum(G,2);
lambda_var=lambda(1);
delta_var=delta(1);
flag=zeros(1,n);
% start simulation
while sum(flag)<n && iterations<=max_iter
	iterations=iterations+1;
    if (iterations>=iter_trial)
        lambda_var=lambda(2);
        delta_var=delta(2);
    end;
    rand_inds=randperm(n);
    for x=1:n
        i=rand_inds(x);
        if (rand<prob_activity(i))
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
                flag=zeros(1,n);
            else
                no_move(deg_tmp)=no_move(deg_tmp)+1;
                flag(i)=1;
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
        pay_res(i,iterations)=v*(sum(conn_pay)+sum(crit_pay(:))/2)-sum(Gu(i,:))*k;
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
        distance(iterations)=sum(graph_tmp(:))/(size(graph_tmp,1)*(size(graph_tmp,1)-1));
    else
        distance(iterations)=0;
    end;
    conn_res(iterations)=nb_connect/(n*(n-1));
    inter_res(iterations)=sum(pay_inter)/(sum(pay_conn)+sum(pay_inter));
    deg(:,iterations)=sum(Gu,2);
    indeg(:,iterations)=sum(G,1)';
    outdeg(:,iterations)=sum(G,2);
end;

if sum(flag)==n
    distance(:,iterations+1:max_iter+1)=repmat(distance(:,iterations),1,max_iter+1-iterations);
    conn_res(:,iterations+1:max_iter+1)=repmat(conn_res(:,iterations),1,max_iter+1-iterations);
    inter_res(:,iterations+1:max_iter+1)=repmat(inter_res(:,iterations),1,max_iter+1-iterations);
    pay_res(:,iterations+1:max_iter+1)=repmat(pay_res(:,iterations),1,max_iter+1-iterations);
    deg(:,iterations+1:max_iter+1)=repmat(deg(:,iterations),1,max_iter+1-iterations);
    indeg(:,iterations+1:max_iter+1)=repmat(indeg(:,iterations),1,max_iter+1-iterations);
    outdeg(:,iterations+1:max_iter+1)=repmat(outdeg(:,iterations),1,max_iter+1-iterations);
end;

%plot(graph(G.*G'))
iterations

end