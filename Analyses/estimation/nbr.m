function [choice prob] = nbr(pay,options,id,n,lambda,delta)

    choice_real=abs(options(1:n)); % undistinguish add/delete actions
    choice_real(id)=1; % action of doing nothing
    choice_real(choice_real==0.5)=0; % ignore proposals
%    choice=-1;
      
    nothing_pay=pay(:,id); % payoff for doing nothing
    num_real=exp(lambda*(choice_real.*pay(1:n)+(1-choice_real).*(delta*pay(1:n)+(1-delta)*nothing_pay))); % compute numerators of probabilistic function
%     den_real=0;
%     for j=1:n % compute denominator of probabilistic function
%         real_choice=choice_real(j);
%         real_pay=pay(j);
%         den_real=den_real+exp(lambda*(real_choice*real_pay+(1-real_choice)*(delta*real_pay+(1-delta)*nothing_pay)));
%     end;
%     if (length(find(num_real==inf))>0) % if inf, select a choice with highest payoff
%         num_real=pay(1:n);
%         num_real(find(num_real<max(num_real)))=0;
%         num_real(find(num_real==max(num_real)))=1;
%     end;
    num_real(id)=0; % remove possibility of doing nothing
    prob=num_real./sum(num_real); % probability distribution across choices
    val=rand;
    cumul_p=0;
    % random selection of action based on probability distribution
    for i=1:n
        cumul_p=cumul_p+prob(i);
        if (val<=cumul_p)
            choice=i;
            break;
        end;
    end;
end