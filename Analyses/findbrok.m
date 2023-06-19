function [inter,nb_conn,nb_pay,dist,nb_paths]=findbrok(net,grp_size)

v=10;
r=3;
dist=net;
dist(dist==0)=grp_size;
inter=zeros(grp_size,1);
nb_conn=sum(net,1)/2;
nb_pay=zeros(1,grp_size);
path=zeros(grp_size,grp_size,grp_size);
nb_paths=net;

for l=1:grp_size
    for i=1:grp_size
        for j=i+1:grp_size
            if (l~=i && l~=j && dist(i,l)+dist(l,j)<=dist(i,j) && dist(i,l)+dist(l,j)<=v/r+1)
                if (dist(i,j)>v/r+1)
                    nb_conn(i)=nb_conn(i)+1/2;
                    nb_conn(j)=nb_conn(j)+1/2;
                end;
                tmp=path(:,i,l)+path(:,l,j);
                tmp(l)=1;
                new_paths=nb_paths(i,l)*nb_paths(l,j);
                inter=inter-path(:,i,j);
                nb_pay(i)=nb_pay(i)-sum(path(:,i,j))/2;
                nb_pay(j)=nb_pay(j)-sum(path(:,i,j))/2;
                if (dist(i,l)+dist(l,j)<dist(i,j))                            
                    path(:,i,j)=tmp;
                    nb_paths(i,j)=new_paths;
                else
                    path(:,i,j)=(path(:,i,j)*nb_paths(i,j)+tmp*new_paths)/(nb_paths(i,j)+new_paths);
                    nb_paths(i,j)=nb_paths(i,j)+new_paths;
                end;
                inter=inter+path(:,i,j);
                nb_pay(i)=nb_pay(i)+sum(path(:,i,j))/2;           
                nb_pay(j)=nb_pay(j)+sum(path(:,i,j))/2;
                path(:,j,i)=path(:,i,j);
                nb_paths(j,i)=nb_paths(i,j);
                dist(i,j)=dist(i,l)+dist(l,j);
                dist(j,i)=dist(i,j);
            end;
        end;
    end;
end;

dist=dist.*abs(1-eye(grp_size));
dist(dist>=grp_size)=inf;

end