function rnd_choice=find_payoffs(model,G,j,n,k,lambda,delta)
    
        real_net=G.*G';
        pay_mat=NaN(n,1);
%        for j=1:n
            own_net=real_net; % realized network at t-1
            own_net(j,:)=0; % assume no link made by the agent
            own_net(:,j)=0; % assume no link made by the agent
            init_net=own_net;
            if model==0
                [crit,crit_sd,bins,list_inter] = findcrit(own_net,n); % find critical players and where they are critical
            else
                [inter,nb_conn,nb_pay,dist,nb_paths] = findbrok_alt(own_net,n); % betweenness
            end;
            flag_no_action=0;
            real_link=zeros(n,1);
            add_link=zeros(n,1);
            del_link=zeros(n,1);
            add_prop=zeros(n,1);
            del_prop=zeros(n,1);
            for x=1:n
%                if x==j || real_net(j,x)==1 || (G(x,j)==1 && G(j,x)==0)
                    if x~=j
                        own_net(j,:)=real_net(j,:); % previous choice
                        if own_net(j,x)==1
                            own_net(j,x)=0; % delete a link
                            real_link(x)=1;
                            del_link(x)=1;
                        elseif G(x,j)==1
                            own_net(j,x)=1; % add a link
                            real_link(x)=1;
                            add_link(x)=1;
                        elseif G(j,x)==0
                            own_net(j,x)=1; % add hypothetical link
                            add_prop(x)=1;
                        else
                            del_prop(x)=1;
                        end;
%                        own_net(j,x)=1-real_net(j,x); % change one link
                    else
                        own_net(j,:)=real_net(j,:); % no new choice
                    end;
                    if (own_net(j,x)~=real_net(j,x) || flag_no_action==0)
                        own_net(:,j)=own_net(j,:); % hypothetical links
                        if model==0
                            [res_conn cost_inter res_inter]=findcritBR_simple(own_net,n,list_inter,find(own_net(j,:)),j); % criticality
                        else % alternative model
                            [res_conn cost_inter res_inter]=findbrok_altBR_simple(dist,find(own_net(j,:)),j,nb_paths,init_net,n);    % betweenness                        
                        end;
                        pay_mat(x)=res_conn-cost_inter+res_inter-sum(own_net(j,:))*k;
                        if (own_net(j,x)==real_net(j,x))
                            flag_no_action=1;
                            pay_no_action=pay_mat(x);
                        end;
                    else
                        pay_mat(x)=pay_no_action;
                    end;
%                 end;
            end;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % simple noisy best response (add link / delete link / add proposal / do nothing)
%             acts_simple=zeros(1,4);
%             selected_add_link_pay=0;
%             selected_del_link_pay=0;
%             selected_add_prop_pay=0;
%             if (sum(add_link)>0)
%                 prob_add=exp(delta(1)*pay_mat(find(add_link)));
%                 prob_add=prob_add/sum(prob_add);
%                 selected_add_link_pay=sum(prob_add.*pay_mat(find(add_link)));
%                 prob_add_all=add_link;
%                 prob_add_all(find(add_link))=prob_add;
% %                selected_add_link_pay=mean(pay_mat(find(add_link)));
% %                selected_add_link_pay=max(pay_mat(find(add_link)));
%                 acts_simple(1)=1;
%             end;
%             if (sum(del_link)>0)
%                 prob_del=exp(delta(2)*pay_mat(find(del_link)));
%                 prob_del=prob_del/sum(prob_del);
%                 selected_del_link_pay=sum(prob_del.*pay_mat(find(del_link)));
%                 prob_del_all=del_link;
%                 prob_del_all(find(del_link))=prob_del;
% %                selected_del_link_pay=sum(pay_mat(find(del_link)));
% %                selected_del_link_pay=max(pay_mat(find(del_link)));
%                 acts_simple(2)=1;
%             end;
%             if (sum(add_prop)>0)
%                 prob_prop=exp(delta(3)*(pay_mat(find(add_prop))));
%                 prob_prop=prob_prop/sum(prob_prop);
%                 selected_add_prop_pay=sum(prob_prop.*pay_mat(find(add_prop)))+gamma;
%                 prob_prop_all=add_prop;
%                 prob_prop_all(find(add_prop))=prob_prop;
% %                selected_add_prop_pay=sum(pay_mat(find(add_prop)));
% %                selected_add_prop_pay=max(pay_mat(find(add_prop)));
%                 acts_simple(3)=1;
%             end;
%             acts_simple(4)=1;
%             act_pay=acts_simple.*exp(lambda*[selected_add_link_pay selected_del_link_pay selected_add_prop_pay pay_no_action]);
%             prob_mat=act_pay/sum(act_pay);
%             rnd_val=rand;
%             choice_simple=0;
%             cumul_prob=0;
%             while rnd_val>cumul_prob
%                 choice_simple=choice_simple+1;
%                 cumul_prob=cumul_prob+prob_mat(choice_simple);
%             end;
%             if (choice_simple==1)
%                 rnd_add=rand;
%                 rnd_choice=0;
%                 cumul_prob=0;
%                 while rnd_add>cumul_prob
%                     rnd_choice=rnd_choice+1;
%                     cumul_prob=cumul_prob+prob_add_all(rnd_choice);
%                 end;
% %                rnd_choice=randsample(find(add_link),1);
%             elseif (choice_simple==2)
%                 rnd_del=rand;
%                 rnd_choice=0;
%                 cumul_prob=0;
%                 while rnd_del>cumul_prob
%                     rnd_choice=rnd_choice+1;
%                     cumul_prob=cumul_prob+prob_del_all(rnd_choice);
%                 end;
% %                rnd_choice=randsample(find(del_link),1);
%             elseif (choice_simple==3)
%                 rnd_prop=rand;
%                 rnd_choice=0;
%                 cumul_prob=0;
%                 while rnd_prop>cumul_prob
%                     rnd_choice=rnd_choice+1;
%                     cumul_prob=cumul_prob+prob_prop_all(rnd_choice);
%                 end;
% %                rnd_choice=randsample(find(add_prop),1);
%             else %if (choice_simple==4)
%                 rnd_choice=j;
%             end;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % standard noisy best response with all linking actions
            pay_min=min(pay_mat);
            pay_max=max(pay_mat);
            pay_norm=(pay_mat-pay_min)./(pay_max-pay_min);
            unrec_prop=G(j,:)'.*(1-G(:,j)); % rule out choice of deleting unreciprocated proposal
            util=real_link.*pay_mat+(1-real_link).*(delta*pay_mat+(1-delta)*pay_no_action); % payoff function
            if (isinf(lambda))
                prob_mat=zeros(n,1);
                tmp_pay=util;
%                tmp_pay=(1-unrec_prop).*util; % filter deletion of unreciprocated proposals
                prob_mat(find(tmp_pay==max(tmp_pay)))=1;
            else
                max_delta=max(0,max(lambda*util)-log(realmax)+1); % prevent inf values
                prob_mat=exp(lambda*util-max_delta); % exponential function (substract max value to prevent inf values)
%                prob_mat=(1-unrec_prop).*exp(lambda*util-max_delta); % exponential function (substract max value to prevent inf values) + filter deletion of unreciprocated proposals
                prob_mat(find(isnan(prob_mat)))=0; % remove nan values (because of deleting unreciprocated proposals)
                prob_mat=prob_mat/max(prob_mat); % avoid any infinite sum                
            end;
            prob_mat=prob_mat/sum(prob_mat);
            rnd_val=rand;
            rnd_choice=0;
            cumul_prob=0;
            while rnd_val>cumul_prob
                rnd_choice=rnd_choice+1;
                cumul_prob=cumul_prob+prob_mat(rnd_choice);
            end;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end