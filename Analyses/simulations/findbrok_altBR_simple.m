function [res_conn cost_inter res_inter]=findbrokBR(dist,choice,j,nb_paths,init_net,n)

v=10;
inter=min(dist(choice,:),[],1);
dist_j=inter+1;
%tmp_comp=bins_tmp;
%tmp_comp(j)=0;
%inter(j)=0;
%inter(inter==inf)=0;
current_pl=find(dist_j<inf);
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
            if dist_j(current_pl(y))+dist_j(current_pl(z))<inf
                if dist(current_pl(y),current_pl(z))>dist_j(current_pl(y))+dist_j(current_pl(z))
                    nb_inter=nb_inter+1/(dist_j(current_pl(y))+dist_j(current_pl(z))+1);
                elseif dist(current_pl(y),current_pl(z))<inf && dist(current_pl(y),current_pl(z))==dist_j(current_pl(y))+dist_j(current_pl(z))
                    nb_inter=nb_inter+nb_pathj(current_pl(y))*nb_pathj(current_pl(z))/(nb_pathj(current_pl(y))*nb_pathj(current_pl(z))+nb_paths(current_pl(y),current_pl(z)))/(dist(current_pl(y),current_pl(z))+1);
                end;
            end;
        end;
    end;
else
%    inter=0;
    dist_j=0;
end;

dist_j(dist_j==inf)=0;
res_conn=sum(dist_j>0)*v/2;
if length(inter)>0
    cost_inter=res_conn-sum(v./(inter+2));
else
    cost_inter=0;
end;
res_inter=nb_inter*v;

end