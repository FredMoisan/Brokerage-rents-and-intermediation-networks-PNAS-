function [res_conn cost_inter res_inter]=findcritBR(net,grp_size,list_inter,choice,ind)

    v=10;   
    comps=(net+eye(grp_size))^grp_size>0;
    crit_sd=zeros(grp_size);
    list_inter=unique([list_inter choice ind]);
    for j=1:length(list_inter) % for each (potential) critical player in the component
        z=list_inter(j);
        crit(:,:,z)=zeros(grp_size);
        tmp_net=net;
        tmp_net(z,:)=0;
        tmp_net(:,z)=0;
        tmp_comps=unique((tmp_net+eye(grp_size))^grp_size>0,'rows');
        main_comp=comps(z,:);
        main_comp(z)=0;
        for m=1:size(tmp_comps,1)
            tmp_comp=find(tmp_comps(m,:));            
            if (tmp_comp(1)~=z && main_comp(tmp_comp(1)) && sum(main_comp)>length(tmp_comp))
                diff=setdiff(find(main_comp==1),tmp_comp);
                crit_sd(tmp_comp,diff)=crit_sd(tmp_comp,diff)+1;
                crit(tmp_comp,diff,z)=1;
            end;
        end;
    end;
    connect=zeros(1,grp_size);
    connect(find(comps(ind,:)==1))=1; % connected players
    connect(ind)=0;    
    conn_pay=connect./(sum(crit(ind,:,:),3)+2); % benefits from connectivity
    crit_pay=crit(:,:,ind)./(crit_sd+2); % benefits from criticality    
    res_conn=sum(connect)*v/2;
    cost_inter=res_conn-v*sum(conn_pay);    
    res_inter=v*sum(crit_pay(:))/2;
    
%     crit_sd2=zeros(grp_size);
% %    list_inter=[list_inter choice ind];
%     for j=1:grp_size %length(list_inter) % for each (potential) critical player in the component
%         z=j;%list_inter(j);
%         crit2(:,:,z)=zeros(grp_size);
%         tmp_net=net;
%         tmp_net(z,:)=0;
%         tmp_net(:,z)=0;
%         tmp_comps=unique((tmp_net+eye(grp_size))^grp_size>0,'rows');
%         main_comp=comps(z,:);
%         main_comp(z)=0;
%         for m=1:size(tmp_comps,1)
%             tmp_comp=find(tmp_comps(m,:));            
%             if (tmp_comp(1)~=z && main_comp(tmp_comp(1)) && sum(main_comp)>length(tmp_comp))
%                 diff=setdiff(find(main_comp==1),tmp_comp);
%                 crit_sd2(tmp_comp,diff)=crit_sd2(tmp_comp,diff)+1;
%                 crit2(tmp_comp,diff,z)=1;
%             end;
%         end;
%     end;
%     connect=zeros(1,grp_size);
%     connect(find(comps(ind,:)==1))=1; % connected players
%     connect(ind)=0;    
%     conn_pay2=connect./(sum(crit2(ind,:,:),3)+2); % benefits from connectivity
%     crit_pay2=crit2(:,:,ind)./(crit_sd2+2); % benefits from criticality    
%     res_conn2=sum(connect)*v/2;
%     cost_inter2=res_conn2-v*sum(conn_pay2);    
%     res_inter2=v*sum(crit_pay2(:))/2;
%     if abs(res_inter2-res_inter)>0.001 || abs(cost_inter2-cost_inter)>0.001 || abs(res_conn2-res_conn)>0.001
%         test=1;
%     end;
end