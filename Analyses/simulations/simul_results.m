clear all
close all force;

record=0; % save files = 1, else = 0
dir = '.'; % directory to save figure files

pay_between_10=[];
pay_inter_between_10=[];
deg_between_10=[];
indeg_between_10=[];
outdeg_between_10=[];
connected_pairs_between_10=[];
distance_between_10=[];

pay_between_50=[];
pay_inter_between_50=[];
deg_between_50=[];
indeg_between_50=[];
outdeg_between_50=[];
connected_pairs_between_50=[];
distance_between_50=[];

pay_between_100=[];
pay_inter_between_100=[];
deg_between_100=[];
indeg_between_100=[];
outdeg_between_100=[];
connected_pairs_between_100=[];
distance_between_100=[];

pay_critical_10=[];
pay_inter_critical_10=[];
deg_critical_10=[];
indeg_critical_10=[];
outdeg_critical_10=[];
connected_pairs_critical_10=[];
distance_critical_10=[];

pay_critical_50=[];
pay_inter_critical_50=[];
deg_critical_50=[];
indeg_critical_50=[];
outdeg_critical_50=[];
connected_pairs_critical_50=[];
distance_critical_50=[];

pay_critical_100=[];
pay_inter_critical_100=[];
deg_critical_100=[];
indeg_critical_100=[];
outdeg_critical_100=[];
connected_pairs_critical_100=[];
distance_critical_100=[];


for l=1:4
    if (l==1)
        init_txt='ER_2';
    elseif (l==2)
        init_txt='ER_5';
    elseif (l==3)
        init_txt='BA_1';
    elseif (l==4)
        init_txt='BA_3';
    end;

    clear payoffs payoffs_inter degree indegree outdegree;
    load([init_txt '/simul_between_10']);
    pay_between_10=[pay_between_10;payoffs];
    pay_inter_between_10=[pay_inter_between_10;payoffs_inter];
    deg_between_10=[deg_between_10;degree];
    indeg_between_10=[indeg_between_10;indegree];
    outdeg_between_10=[outdeg_between_10;outdegree];
    connected_pairs_between_10=[connected_pairs_between_10;connected_pairs];
    distance_between_10=[distance_between_10;distance];

    clear payoffs payoffs_inter degree indegree outdegree;
    load([init_txt '/simul_between_50']);
    pay_between_50=[pay_between_50;payoffs];
    pay_inter_between_50=[pay_inter_between_50;payoffs_inter];
    deg_between_50=[deg_between_50;degree];
    indeg_between_50=[indeg_between_50;indegree];
    outdeg_between_50=[outdeg_between_50;outdegree];
    connected_pairs_between_50=[connected_pairs_between_50;connected_pairs];
    distance_between_50=[distance_between_50;distance];

    clear payoffs payoffs_inter degree indegree outdegree;
    load([init_txt '/simul_between_100']);
    pay_between_100=[pay_between_100;payoffs];
    pay_inter_between_100=[pay_inter_between_100;payoffs_inter];
    deg_between_100=[deg_between_100;degree];
    indeg_between_100=[indeg_between_100;indegree];
    outdeg_between_100=[outdeg_between_100;outdegree];
    connected_pairs_between_100=[connected_pairs_between_100;connected_pairs];
    distance_between_100=[distance_between_100;distance];

    clear payoffs payoffs_inter degree indegree outdegree;
    load([init_txt '/simul_critical_10']);
    pay_critical_10=[pay_critical_10;payoffs];
    pay_inter_critical_10=[pay_inter_critical_10;payoffs_inter];
    deg_critical_10=[deg_critical_10;degree];
    indeg_critical_10=[indeg_critical_10;indegree];
    outdeg_critical_10=[outdeg_critical_10;outdegree];
    connected_pairs_critical_10=[connected_pairs_critical_10;connected_pairs];
    distance_critical_10=[distance_critical_10;distance];

    clear payoffs payoffs_inter degree indegree outdegree;
    load([init_txt '/simul_critical_50']);
    pay_critical_50=[pay_critical_50;payoffs];
    pay_inter_critical_50=[pay_inter_critical_50;payoffs_inter];
    deg_critical_50=[deg_critical_50;degree];
    indeg_critical_50=[indeg_critical_50;indegree];
    outdeg_critical_50=[outdeg_critical_50;outdegree];
    connected_pairs_critical_50=[connected_pairs_critical_50;connected_pairs];
    distance_critical_50=[distance_critical_50;distance];

    clear payoffs payoffs_inter degree indegree outdegree;
    load([init_txt '/simul_critical_100']);
    pay_critical_100=[pay_critical_100;payoffs];
    pay_inter_critical_100=[pay_inter_critical_100;payoffs_inter];
    deg_critical_100=[deg_critical_100;degree];
    indeg_critical_100=[indeg_critical_100;indegree];
    outdeg_critical_100=[outdeg_critical_100;outdegree];
    connected_pairs_critical_100=[connected_pairs_critical_100;connected_pairs];
    distance_critical_100=[distance_critical_100;distance];

end;

v=10;

iterations=size(pay_between_100,2);

for i=1:iterations
    for j=1:size(pay_between_100,1)/100
       k=8;
        efficiency_between_10(j,i)=sum(pay_between_10((j-1)*10+1:j*10,i))/((10-1)*(v-2*k+(10-2)*v/2));
        ineq_between_10(j,i)=max(pay_between_10((j-1)*10+1:j*10,i))/median(pay_between_10((j-1)*10+1:j*10,i));
        links_between_10(j,i)=sum(deg_between_10((j-1)*10+1:j*10,i))/2;
        ineq_deg_between_10(j,i)=max(deg_between_10((j-1)*10+1:j*10,i))/median(deg_between_10((j-1)*10+1:j*10,i));
        tmp=sort(deg_between_10((j-1)*10+1:j*10,i),'descend');
        diff_max_deg_between_10(j,i)=tmp(1)-tmp(2);
        diff2_max_deg_between_10(j,i)=tmp(2)-tmp(3);
        max1_deg_between_10(j,i)=tmp(1);
        max2_deg_between_10(j,i)=tmp(2);
        max3_deg_between_10(j,i)=tmp(3);
        max4_deg_between_10(j,i)=tmp(4);
        max5_deg_between_10(j,i)=tmp(5);
        max6_deg_between_10(j,i)=tmp(6);
        outdegree_between_10(j,i)=mean(outdeg_between_10((j-1)*10+1:j*10,i));
        if (i==iterations)
            distr_deg_between_10(j,:)=tmp;
        end;

        efficiency_critical_10(j,i)=sum(pay_critical_10((j-1)*10+1:j*10,i))/((10-1)*(v-2*k+(10-2)*v/2));
        ineq_critical_10(j,i)=max(pay_critical_10((j-1)*10+1:j*10,i))/median(pay_critical_10((j-1)*10+1:j*10,i));
        links_critical_10(j,i)=sum(deg_critical_10((j-1)*10+1:j*10,i))/2;
        ineq_deg_critical_10(j,i)=max(deg_critical_10((j-1)*10+1:j*10,i))/median(deg_critical_10((j-1)*10+1:j*10,i));
        tmp=sort(deg_critical_10((j-1)*10+1:j*10,i),'descend');
        diff_max_deg_critical_10(j,i)=tmp(1)-tmp(2);
        diff2_max_deg_critical_10(j,i)=tmp(2)-tmp(3);
        max1_deg_critical_10(j,i)=tmp(1);
        max2_deg_critical_10(j,i)=tmp(2);
        max3_deg_critical_10(j,i)=tmp(3);
        max4_deg_critical_10(j,i)=tmp(4);
        max5_deg_critical_10(j,i)=tmp(5);
        max6_deg_critical_10(j,i)=tmp(6);
        outdegree_critical_10(j,i)=mean(outdeg_critical_10((j-1)*10+1:j*10,i));
        if (i==iterations)
            distr_deg_critical_10(j,:)=tmp;
        end;

        k=40;
        efficiency_between_50(j,i)=sum(pay_between_50((j-1)*50+1:j*50,i))/((50-1)*(v-2*k+(50-2)*v/2));
        ineq_between_50(j,i)=max(pay_between_50((j-1)*50+1:j*50,i))/median(pay_between_50((j-1)*50+1:j*50,i));
        links_between_50(j,i)=sum(deg_between_50((j-1)*50+1:j*50,i))/2;
        ineq_deg_between_50(j,i)=max(deg_between_50((j-1)*50+1:j*50,i))/median(deg_between_50((j-1)*50+1:j*50,i));
        tmp=sort(deg_between_50((j-1)*50+1:j*50,i),'descend');
        diff_max_deg_between_50(j,i)=tmp(1)-tmp(2);
        diff2_max_deg_between_50(j,i)=tmp(2)-tmp(3);
        max1_deg_between_50(j,i)=tmp(1);
        max2_deg_between_50(j,i)=tmp(2);
        max3_deg_between_50(j,i)=tmp(3);
        max4_deg_between_50(j,i)=tmp(4);
        max5_deg_between_50(j,i)=tmp(5);
        max6_deg_between_50(j,i)=tmp(6);
        outdegree_between_50(j,i)=mean(outdeg_between_50((j-1)*50+1:j*50,i));
        if (i==iterations)
            distr_deg_between_50(j,:)=tmp;
        end;

        efficiency_critical_50(j,i)=sum(pay_critical_50((j-1)*50+1:j*50,i))/((50-1)*(v-2*k+(50-2)*v/2));
        ineq_critical_50(j,i)=max(pay_critical_50((j-1)*50+1:j*50,i))/median(pay_critical_50((j-1)*50+1:j*50,i));
        links_critical_50(j,i)=sum(deg_critical_50((j-1)*50+1:j*50,i))/2;
        ineq_deg_critical_50(j,i)=max(deg_critical_50((j-1)*50+1:j*50,i))/median(deg_critical_50((j-1)*50+1:j*50,i));
        tmp=sort(deg_critical_50((j-1)*50+1:j*50,i),'descend');
        diff_max_deg_critical_50(j,i)=tmp(1)-tmp(2);
        diff2_max_deg_critical_50(j,i)=tmp(2)-tmp(3);
        max1_deg_critical_50(j,i)=tmp(1);
        max2_deg_critical_50(j,i)=tmp(2);
        max3_deg_critical_50(j,i)=tmp(3);
        max4_deg_critical_50(j,i)=tmp(4);
        max5_deg_critical_50(j,i)=tmp(5);
        max6_deg_critical_50(j,i)=tmp(6);
        outdegree_critical_50(j,i)=mean(outdeg_critical_50((j-1)*50+1:j*50,i));
        if (i==iterations)
            distr_deg_critical_50(j,:)=tmp;
        end;        

        k=80;
        efficiency_between_100(j,i)=sum(pay_between_100((j-1)*100+1:j*100,i))/((100-1)*(v-2*k+(100-2)*v/2));
        ineq_between_100(j,i)=max(pay_between_100((j-1)*100+1:j*100,i))/median(pay_between_100((j-1)*100+1:j*100,i));
        links_between_100(j,i)=sum(deg_between_100((j-1)*100+1:j*100,i))/2;
        ineq_deg_between_100(j,i)=max(deg_between_100((j-1)*100+1:j*100,i))/median(deg_between_100((j-1)*100+1:j*100,i));
        tmp=sort(deg_between_100((j-1)*100+1:j*100,i),'descend');
        diff_max_deg_between_100(j,i)=tmp(1)-tmp(2);
        diff2_max_deg_between_100(j,i)=tmp(2)-tmp(3);
        max1_deg_between_100(j,i)=tmp(1);
        max2_deg_between_100(j,i)=tmp(2);
        max3_deg_between_100(j,i)=tmp(3);
        max4_deg_between_100(j,i)=tmp(4);
        max5_deg_between_100(j,i)=tmp(5);
        max6_deg_between_100(j,i)=tmp(6);
        outdegree_between_100(j,i)=mean(outdeg_between_100((j-1)*100+1:j*100,i));
        if (i==iterations)
            distr_deg_between_100(j,:)=tmp;
        end;

        efficiency_critical_100(j,i)=sum(pay_critical_100((j-1)*100+1:j*100,i))/((100-1)*(v-2*k+(100-2)*v/2));
        ineq_critical_100(j,i)=max(pay_critical_100((j-1)*100+1:j*100,i))/median(pay_critical_100((j-1)*100+1:j*100,i));
        links_critical_100(j,i)=sum(deg_critical_100((j-1)*100+1:j*100,i))/2;
        ineq_deg_critical_100(j,i)=max(deg_critical_100((j-1)*100+1:j*100,i))/median(deg_critical_100((j-1)*100+1:j*100,i));
        tmp=sort(deg_critical_100((j-1)*100+1:j*100,i),'descend');
        diff_max_deg_critical_100(j,i)=tmp(1)-tmp(2);
        diff2_max_deg_critical_100(j,i)=tmp(2)-tmp(3);
        max1_deg_critical_100(j,i)=tmp(1);
        max2_deg_critical_100(j,i)=tmp(2);
        max3_deg_critical_100(j,i)=tmp(3);
        max4_deg_critical_100(j,i)=tmp(4);
        max5_deg_critical_100(j,i)=tmp(5);
        max6_deg_critical_100(j,i)=tmp(6);
        outdegree_critical_100(j,i)=mean(outdeg_critical_100((j-1)*100+1:j*100,i));
        if (i==iterations)
            distr_deg_critical_100(j,:)=tmp;
        end;
    end;
end

%%%%%%%%%%%%%% stats %%%%%%%%%%%%%%%%%%%%%%

features={'Connectedness'; 'Average degree';'Max degree / Median degree';'Distance (largest component)';'Max payoff / Median payoff';'Efficiency';'Degree 1st most connected';'Degree 2nd most connected';'Degree 3rd most connected';'Degree 4th most connected';'Degree 5th most connected';'Degree 6th most connected'};
Crit10=[nanmean(connected_pairs_critical_10(:,101));nanmean(links_critical_10(:,101))/5;nanmean(ineq_deg_critical_10(:,101));nanmean(distance_critical_10(:,101));nanmean(ineq_critical_10(:,101));nanmean(efficiency_critical_10(:,101));nanmean(max1_deg_critical_10(:,101));nanmean(max2_deg_critical_10(:,101));nanmean(max3_deg_critical_10(:,101));nanmean(max4_deg_critical_10(:,101));nanmean(max5_deg_critical_10(:,101));nanmean(max6_deg_critical_10(:,101))];
Crit50=[nanmean(connected_pairs_critical_50(:,101));nanmean(links_critical_50(:,101))/25;nanmean(ineq_deg_critical_50(:,101));nanmean(distance_critical_50(:,101));nanmean(ineq_critical_50(:,101));nanmean(efficiency_critical_50(:,101));nanmean(max1_deg_critical_50(:,101));nanmean(max2_deg_critical_50(:,101));nanmean(max3_deg_critical_50(:,101));nanmean(max4_deg_critical_50(:,101));nanmean(max5_deg_critical_50(:,101));nanmean(max6_deg_critical_50(:,101))];
Crit100=[nanmean(connected_pairs_critical_100(:,101));nanmean(links_critical_100(:,101))/50;nanmean(ineq_deg_critical_100(:,101));nanmean(distance_critical_100(:,101));nanmean(ineq_critical_100(:,101));nanmean(efficiency_critical_100(:,101));nanmean(max1_deg_critical_100(:,101));nanmean(max2_deg_critical_100(:,101));nanmean(max3_deg_critical_100(:,101));nanmean(max4_deg_critical_100(:,101));nanmean(max5_deg_critical_100(:,101));nanmean(max6_deg_critical_100(:,101))];
Bet10=[nanmean(connected_pairs_between_10(:,101));nanmean(links_between_10(:,101))/5;nanmean(ineq_deg_between_10(:,101));nanmean(distance_between_10(:,101));nanmean(ineq_between_10(:,101));nanmean(efficiency_between_10(:,101));nanmean(max1_deg_between_10(:,101));nanmean(max2_deg_between_10(:,101));nanmean(max3_deg_between_10(:,101));nanmean(max4_deg_between_10(:,101));nanmean(max5_deg_between_10(:,101));nanmean(max6_deg_between_10(:,101))];
Bet50=[nanmean(connected_pairs_between_50(:,101));nanmean(links_between_50(:,101))/25;nanmean(ineq_deg_between_50(:,101));nanmean(distance_between_50(:,101));nanmean(ineq_between_50(:,101));nanmean(efficiency_between_50(:,101));nanmean(max1_deg_between_50(:,101));nanmean(max2_deg_between_50(:,101));nanmean(max3_deg_between_50(:,101));nanmean(max4_deg_between_50(:,101));nanmean(max5_deg_between_50(:,101));nanmean(max6_deg_between_50(:,101))];
Bet100=[nanmean(connected_pairs_between_100(:,101));nanmean(links_between_100(:,101))/50;nanmean(ineq_deg_between_100(:,101));nanmean(distance_between_100(:,101));nanmean(ineq_between_100(:,101));nanmean(efficiency_between_100(:,101));nanmean(max1_deg_between_100(:,101));nanmean(max2_deg_between_100(:,101));nanmean(max3_deg_between_100(:,101));nanmean(max4_deg_between_100(:,101));nanmean(max5_deg_between_100(:,101));nanmean(max6_deg_between_100(:,101))];

T=table(features,round(Crit10,2),round(Crit50,2),round(Crit100,2),round(Bet10,2),round(Bet50,2),round(Bet100,2))

save('simul_stats.mat','Crit10','Crit50', 'Crit100', 'Bet10', 'Bet50', 'Bet100');

table2latex(T, 'output_simul'); % latex format

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=figure
f.WindowState = 'maximized';
subplot(2,2,1)
plot([1:iterations],nanmean(efficiency_critical_10,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(efficiency_between_10,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Efficiency');
title('N=10');


subplot(2,2,2)
plot([1:iterations],nanmean(efficiency_critical_50,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(efficiency_between_50,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Efficiency');
title('N=50');

subplot(2,2,3)
plot([1:iterations],nanmean(efficiency_critical_100,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(efficiency_between_100,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
legend('Criticality','Betweenness','NumColumns',1,'Position',[0.5 0.25 0.5 0.1]);
xlabel('Iterations');
ylabel('Efficiency');
box off;
legend boxoff;
title('N=100');

if (record)
    saveas(f,[dir '/simul_efficiency.png']);
end;

f=figure
f.WindowState = 'maximized';
subplot(2,2,1)
plot([1:iterations],nanmean(ineq_critical_10,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(ineq_between_10,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 4]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Max payoff / Median payoff');
title('N=10');

subplot(2,2,2)
plot([1:iterations],nanmean(ineq_critical_50,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(ineq_between_50,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 15]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Max payoff / Median payoff');
title('N=50');

subplot(2,2,3)
plot([1:iterations],nanmean(ineq_critical_100,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(ineq_between_100,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 30]);
set(gca,'FontSize',18);
set(gcf,'color','w');
legend('Criticality','Betweenness','NumColumns',1,'Position',[0.5 0.25 0.5 0.1]);
xlabel('Iterations');
ylabel('Max payoff / Median payoff');
box off;
legend boxoff;
title('N=100');

if (record)
    saveas(f,[dir '/simul_payoff_inequality.png']);
end;

f=figure
f.WindowState = 'maximized';
subplot(2,2,1)
plot([1:iterations],nanmean(links_critical_10,1)/5,'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(links_between_10,1)/5,'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 4]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Degree');
title('N=10');

subplot(2,2,2)
plot([1:iterations],nanmean(links_critical_50,1)/25,'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(links_between_50,1)/25,'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 4]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Degree');
title('N=50');

subplot(2,2,3)
plot([1:iterations],nanmean(links_critical_100,1)/50,'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(links_between_100,1)/50,'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 4]);
set(gca,'FontSize',18);
set(gcf,'color','w');
legend('Criticality','Betweenness','NumColumns',1,'Position',[0.5 0.25 0.5 0.1]);
xlabel('Iterations');
ylabel('Degree');
box off;
legend boxoff;
title('N=100');

if (record)
    saveas(f,[dir '/simul_degree.png']);
end;

f=figure
f.WindowState = 'maximized';
subplot(2,2,1)
plot([1:iterations],nanmean(connected_pairs_critical_10,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(connected_pairs_between_10,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('% connected pairs');
title('N=10');

subplot(2,2,2)
plot([1:iterations],nanmean(connected_pairs_critical_50,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(connected_pairs_between_50,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('% connected pairs');
title('N=50');

subplot(2,2,3)
plot([1:iterations],nanmean(connected_pairs_critical_100,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(connected_pairs_between_100,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 1]);
set(gca,'FontSize',18);
set(gcf,'color','w');
legend('Criticality','Betweenness','NumColumns',1,'Position',[0.5 0.25 0.5 0.1]);
xlabel('Iterations');
ylabel('% connected pairs');
box off;
legend boxoff;
title('N=100');

if (record)
    saveas(f,[dir '/simul_connectedness.png']);
end;

f=figure
f.WindowState = 'maximized';
subplot(2,2,1)
plot([1:iterations],nanmean(ineq_deg_critical_10,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(ineq_deg_between_10,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 9]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Max deg / Median deg');
title('N=10');

subplot(2,2,2)
plot([1:iterations],nanmean(ineq_deg_critical_50,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(ineq_deg_between_50,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 25]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Max deg / Median deg');
title('N=50');

subplot(2,2,3)
plot([1:iterations],nanmean(ineq_deg_critical_100,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(ineq_deg_between_100,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 50]);
set(gca,'FontSize',18);
set(gcf,'color','w');
legend('Criticality','Betweenness','NumColumns',1,'Position',[0.5 0.25 0.5 0.1]);
xlabel('Iterations');
ylabel('Max deg / Median deg');
box off;
legend boxoff;
title('N=100');

if (record)
    saveas(f,[dir '/simul_degree_inequality.png']);
end;

f=figure
f.WindowState = 'maximized';
subplot(2,2,1)
plot([1:iterations],nanmean(distance_critical_10,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(distance_between_10,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 3]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Distance (largest comp.)');
title('N=10');

subplot(2,2,2)
plot([1:iterations],nanmean(distance_critical_50,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(distance_between_50,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 15]);
set(gca,'FontSize',18);
set(gcf,'color','w');
xlabel('Iterations');
ylabel('Distance (largest comp.)');
title('N=50');

subplot(2,2,3)
plot([1:iterations],nanmean(distance_critical_100,1),'r','LineWidth',2);
hold on;
plot([1:iterations],nanmean(distance_between_100,1),'b','LineWidth',2);
xlim([1 iterations]);
ylim([0 50]);
set(gca,'FontSize',18);
set(gcf,'color','w');
legend('Criticality','Betweenness','NumColumns',1,'Position',[0.5 0.25 0.5 0.1]);
xlabel('Iterations');
ylabel('Distance (largest comp.)');
box off;
legend boxoff;
title('N=100');

if (record)
    saveas(f,[dir '/simul_distance.png']);
end;

f=figure
f.WindowState = 'maximized';
subplot(2,2,1);
bar([1:1:10],[mean(distr_deg_between_10,1); mean(distr_deg_critical_10,1)]);
hold on;
xlim([0 11]);
ylim([0 8]);
set(gca,'FontSize',20);
set(gcf,'color','w');
xlabel('Individuals (ranked from highest to lowest degree)','FontSize', 20);
ylabel('Degree','FontSize', 20);
title('N=10');

subplot(2,2,2);
bar([1:1:10],[mean(distr_deg_between_50(:,1:10),1); mean(distr_deg_critical_50(:,1:10),1)]);
hold on;
xlim([0 11]);
ylim([0 25]);
set(gca,'FontSize',20);
set(gcf,'color','w');
xlabel('Individuals (ranked from highest to lowest degree)','FontSize', 20);
ylabel('Degree','FontSize', 20);
title('N=50');

subplot(2,2,3);
bar([1:1:10],[mean(distr_deg_between_100(:,1:10),1); mean(distr_deg_critical_100(:,1:10),1)]);
hold on;
xlim([0 11]);
ylim([0 50]);
set(gca,'FontSize',20);
set(gcf,'color','w');
legend('Criticality','Betweenness','NumColumns',1,'Position',[0.5 0.25 0.5 0.1]);
xlabel('Individuals (ranked from highest to lowest degree)','FontSize', 20);
ylabel('Degree','FontSize', 20);
box off;
legend boxoff;
title('N=100');

if (record)
    saveas(f,[dir '/simul_degree_ranks.png']);
end;
