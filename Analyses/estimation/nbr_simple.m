function output = nbr_simple(pay,choice,id,n,lambda,delta,gamma)

epsil = 0.0000000000000000000001;
choice_actual=choice(:,n+1);
choice_actual(choice_actual==0)=id;

add_link=choice(:,1:n);
add_link(add_link<1)=0;
del_link=choice(:,1:n);
del_link(del_link>-1)=0;
del_link(del_link==-1)=1;
add_prop=choice(:,1:n);
add_prop(add_prop>0.5)=0;
add_prop(add_prop<0.5)=0;
add_prop(add_prop==0.5)=1;

act_add_link=max(add_link,[],2);
act_del_link=max(del_link,[],2);
act_add_prop=max(add_prop,[],2);

% compute expected payoff for adding a link
prob_add=add_link.*exp(delta(1)*pay(:,1:n).*add_link);
prob_add=prob_add./sum(prob_add,2);
prob_add(isnan(prob_add))=0;
selected_pay_add_link=sum(pay(:,1:n).*prob_add,2);
%selected_pay_add_link=sum(pay(:,1:n).*add_link,2)./max(1,sum(add_link,2));
%selected_pay_add_link=max(pay(:,1:n).*add_link,[],2);

% compute expected payoff for deleting a link
prob_del=del_link.*exp(delta(2)*pay(:,1:n).*del_link);
prob_del=prob_del./sum(prob_del,2);
prob_del(isnan(prob_del))=0;
selected_pay_del_link=sum(pay(:,1:n).*prob_del,2);
%selected_pay_del_link=sum(pay(:,1:n).*del_link,2)./max(1,sum(del_link,2));
%selected_pay_del_link=max(pay(:,1:n).*del_link,[],2);

% compute expected payoff for adding a proposal (assuming the link is realized)
prob_prop=add_prop.*exp(delta(3)*pay(:,1:n).*add_prop);
prob_prop=prob_prop./sum(prob_prop,2);
prob_prop(isnan(prob_prop))=0;
selected_pay_add_prop=sum(pay(:,1:n).*prob_prop,2)+gamma;
%selected_pay_add_prop=sum(pay(:,1:n).*add_prop,2)./max(1,sum(add_prop,2));
%selected_pay_add_prop=max(pay(:,1:n).*add_prop,[],2);

% payoff for doing nothing
pay_nothing=pay(:,id);


% compute expected payoff for actual choice (add/delete/propose/nothing)
action=diag(choice(:,choice_actual));
act_pay_add_link=action;
act_pay_add_link(act_pay_add_link<1)=0;
act_pay_del_link=action;
act_pay_del_link(act_pay_del_link>-1)=0;
act_pay_del_link(act_pay_del_link==-1)=1;
act_pay_add_prop=action;
act_pay_add_prop(act_pay_add_prop>0.5)=0;
act_pay_add_prop(act_pay_add_prop<0.5)=0;
act_pay_add_prop(act_pay_add_prop==0.5)=1;
act_pay_nothing=action;
act_pay_nothing(act_pay_nothing==0.5)=1;
act_pay_nothing(act_pay_nothing==-0.5)=0;
act_pay_nothing=1-abs(act_pay_nothing);
payoff=diag(pay(:,choice_actual));
act_pay=payoff.*(1-act_pay_add_prop)+act_pay_add_prop.*(payoff+gamma);
%act_pay=act_pay_add_link.*selected_pay_add_link+act_pay_del_link.*selected_pay_del_link+act_pay_add_prop.*selected_pay_add_prop+act_pay_nothing.*pay_nothing;

output=log(exp(lambda*act_pay)./(act_add_link.*exp(lambda*selected_pay_add_link)+act_del_link.*exp(lambda*selected_pay_del_link)+act_add_prop.*exp(lambda*selected_pay_add_prop)+exp(lambda*pay_nothing))+epsil);

end