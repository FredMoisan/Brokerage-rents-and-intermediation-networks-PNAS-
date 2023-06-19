function [pay_mat choice_mat]=find_payoffs(treat,prev_net,net,grp_size,k)
    
        real_net=prev_net.*prev_net';
        pay_mat=NaN((grp_size+1)*grp_size,1);
        choice_mat=zeros((grp_size+1)*grp_size,1);
%        [crit,crit_sd,bins,list_critical] = findcrit(real_net,grp_size); % find critical players and where they are critical
        for j=1:grp_size
            own_net=real_net; % realized network at t-1
            own_net(j,:)=0; % assume no link made by the agent
            own_net(:,j)=0; % assume no link made by the agent
%            own_net(j,:)=net(j,:).*prev_net(:,j)'; % actual choice with actual consequences
%            own_net(:,j)=own_net(j,:);
            init_net=own_net;
            if treat<3 || treat==5 
                [crit,crit_sd,bins,list_inter] = findcrit(own_net,grp_size); % find critical players and where they are critical
            elseif treat==3 || treat==6
                [inter,nb_conn,nb_pay,dist,nb_paths] = findbrok(own_net,grp_size); % first betweenness model (unused)
            else
                [inter,nb_conn,nb_pay,dist,nb_paths] = findbrok_alt(own_net,grp_size); % betweenness
            end;
            flag_no_action=0;
            for x=1:grp_size
%                if x==j || real_net(j,x)==1 || (prev_net(x,j)==1 && prev_net(j,x)==0)
                    if x~=j
                        own_net(j,:)=real_net(j,:); % previous choice
                        if own_net(j,x)==1
                            own_net(j,x)=0;
                            choice_mat((j-1)*(grp_size+1)+x)=-1; % delete a link
                        elseif prev_net(x,j)==1
                            own_net(j,x)=1;
                            choice_mat((j-1)*(grp_size+1)+x)=1; % add a link
                        elseif prev_net(j,x)==0
                            own_net(j,x)=1; % add hypothetical link
                            choice_mat((j-1)*(grp_size+1)+x)=0.5; % add a proposal
                        elseif prev_net(j,x)==1
                            choice_mat((j-1)*(grp_size+1)+x)=-0.5; % delete a proposal
                        end;
%                        own_net(j,x)=1-real_net(j,x); % change one link
                    else
                        own_net(j,:)=real_net(j,:); % no new choice
                    end;
                    if (own_net(j,x)~=real_net(j,x) || flag_no_action==0)
                        own_net(:,j)=own_net(j,:);
                        if treat<3 || treat==5 % baseline model
                            [res_conn cost_inter res_inter]=findcritBR_simple(own_net,grp_size,list_inter,find(own_net(j,:)),j); % criticality
                        elseif treat==3  || treat==6 % smooth model
                            [res_conn cost_inter res_inter]=findbrokBR_simple(dist,find(own_net(j,:)),j,nb_paths,init_net,grp_size); % first betweenness model (unused)
                        else % alternative model
                            [res_conn cost_inter res_inter]=findbrok_altBR_simple(dist,find(own_net(j,:)),j,nb_paths,init_net,grp_size);    % betweenness                        
                        end;
                        pay_mat((j-1)*(grp_size+1)+x)=res_conn-cost_inter+res_inter-sum(own_net(j,:))*k;
                        if (own_net(j,x)==real_net(j,x))
                            flag_no_action=1;
                            pay_no_action=pay_mat((j-1)*(grp_size+1)+x);
                        end;
                    else
                        pay_mat((j-1)*(grp_size+1)+x)=pay_no_action;
                    end;
%                 end;
            end;

            choices=find(abs(net(j,:)-prev_net(j,:)));
            pay_tmp=pay_mat((j-1)*(grp_size+1)+1:(j-1)*(grp_size+1)+grp_size);
            if (length(choices)>0)
                pay_mat(j*(grp_size+1))=max(pay_tmp(choices));
                choice_tmp=intersect(choices,find(pay_tmp==max(pay_tmp(choices))));
                choice_mat(j*(grp_size+1))=choice_tmp(1); % a highest payoff choice
            else
                pay_mat(j*(grp_size+1))=pay_no_action;
            end;

        end;                
end