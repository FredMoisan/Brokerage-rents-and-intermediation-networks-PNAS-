function [res_conn cost_inter res_inter]=findbrokBR(dist,choice,j,nb_paths,init_net,n)

%test_net=init_net;
v=10;
r=3;
inter=min(dist(choice,:),[],1);
dist_j=inter+1;
%tmp_comp=bins_tmp;
%tmp_comp(j)=0;
inter(j)=0;
inter(inter>v/r)=0;
current_pl=find(dist_j<v/r+1);
dist_j(j)=0;
dist_j(dist_j>v/r+1)=inf;
nb_inter=0;

if length(choice)>=1
    nb_pathj=zeros(n,1);
    nb_pathj(choice)=1;
    curr_choice=choice;
    for x=2:max(dist_j(dist_j<inf))+1
        tmp=sum(init_net(curr_choice,:),1);
        tmp(curr_choice)=0;
        nb_pathj=nb_pathj+tmp';
        init_net(curr_choice,:)=0;
        init_net(:,curr_choice)=0;
        list=[];
        for y=1:max(tmp)
            list=[list repelem(find(tmp==y),y)];
        end;
        curr_choice=list;
    end;

    for y=1:length(current_pl)                                                
        for z=y+1:length(current_pl)
            if dist_j(current_pl(y))+dist_j(current_pl(z))<v/r+1
                if dist(current_pl(y),current_pl(z))>dist_j(current_pl(y))+dist_j(current_pl(z))
                    nb_inter=nb_inter+1;
                elseif dist(current_pl(y),current_pl(z))<inf && dist(current_pl(y),current_pl(z))==dist_j(current_pl(y))+dist_j(current_pl(z))
                    nb_inter=nb_inter+nb_pathj(current_pl(y))*nb_pathj(current_pl(z))/(nb_pathj(current_pl(y))*nb_pathj(current_pl(z))+nb_paths(current_pl(y),current_pl(z)));
                end;
            end;
        end;
    end;
end;

dist_j(dist_j>v/r+1)=0;
res_conn=sum(dist_j>0)*v/2;
cost_inter=sum(inter)*r/2;
res_inter=nb_inter*r;

end