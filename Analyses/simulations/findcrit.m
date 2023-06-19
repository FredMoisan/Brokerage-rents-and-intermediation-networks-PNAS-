function [crit,crit_sd,comps,list]=findcrit(net,grp_size)

    comps=(net+eye(grp_size))^grp_size>0;
    crit_sd=zeros(grp_size);
    list=zeros(1,grp_size);
    for j=1:grp_size
        crit(:,:,j)=zeros(grp_size);
        tmp_net=net;
        tmp_net(j,:)=0;
        tmp_net(:,j)=0;
        tmp_comps=unique((tmp_net+eye(grp_size))^grp_size>0,'rows');
        main_comp=comps(j,:);
        main_comp(j)=0;
        for m=1:size(tmp_comps,1)
            tmp_comp=find(tmp_comps(m,:)==1);            
            if (tmp_comp(1)~=j && main_comp(tmp_comp(1)) && sum(main_comp)>length(tmp_comp))
                diff=setdiff(find(main_comp==1),tmp_comp);
                crit_sd(tmp_comp,diff)=crit_sd(tmp_comp,diff)+1;
                crit(tmp_comp,diff,j)=1;
                list(j)=1;
            end;
        end;
    end;
    list=find(list);
end