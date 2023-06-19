clear all
close all force;

load data_50_1;
data_50_1=data;
clear data;
load data_50_2;
data_50_2=data;
clear data;
load data_50_3;
data_50_3=data;
clear data;
load data_50_4;
data_50_4=data;
clear data;
load data_50_6;
data_50_6=data;
clear data;
load data_50_7;
data_50_7=data;
clear data;
load data_50_8;
data_50_8=data;
clear data;
load data_50_9;
data_50_9=data;
clear data;
load data_100_1;
data_100_1=data;
clear data;
load data_100_2;
data_100_2=data;
clear data;
load data_100_3;
data_100_3=data;
clear data;
load data_100_4;
data_100_4=data;
clear data;
load data_50_10;
data_50_10=data;
clear data;
load data_50_11;
data_50_11=data;
clear data;
load data_50_12;
data_50_12=data;
clear data;
load data_50_13;
data_50_13=data;
clear data;
load data_10_1;
data_10_1=data;
clear data;
load data_10_2;
data_10_2=data;
clear data;
load data_10_3;
data_10_3=data;
clear data;
load data_100_5;
data_100_5=data;
clear data;
load data_100_6;
data_100_6=data;
clear data;
load data_100_7;
data_100_7=data;
clear data;
load data_100_8;
data_100_8=data;
clear data;

data=[data_50_1;data_50_2;data_50_3;data_50_4;data_50_6;data_50_7;data_50_8;data_50_9;data_100_1;data_100_2;data_100_3;data_100_4;data_50_10;data_50_11;data_50_12;data_50_13;data_10_1;data_10_2;data_10_3;data_100_5;data_100_6;data_100_7;data_100_8];

activity_crit_10=zeros(4*5*360,10);
activity_crit_50=zeros(4*5*360,50);
activity_crit_100=zeros(4*5*360,100);
activity_bet_10=zeros(4*5*360,10);
activity_bet_50=zeros(4*5*360,50);
activity_bet_100=zeros(4*5*360,100);
for i=1:size(data,1)
    id_grp=data(i,5);
    id_unique=data(i,7);
    group=data(i,2);
    roundg=data(i,3);
    time=data(i,4);
    choice=data(i,6);
    if (roundg>1 && choice>0 && time>0 && time<=360)
        if (data(i,1)<=4) % critical n=50
            activity_crit_50((group-1)*360*5+(roundg-2)*360+time,id_grp)=1;
        elseif (data(i,1)<=10) % critical n=100
            activity_crit_100((group-1)*360*5+(roundg-2)*360+time,id_grp)=1;
        elseif (data(i,1)>14 && data(i,1)<=18) % between n=50
            activity_bet_50((group-1)*360*5+(roundg-2)*360+time,id_grp)=1;
        elseif (data(i,1)==19) % critical n=10
            activity_crit_10((group-1)*360*5+(roundg-2)*360+time,id_grp)=1;
        elseif (data(i,1)==21) % between n=10
            activity_bet_10((group-1)*360*5+(roundg-2)*360+time,id_grp)=1;
        elseif (data(i,1)>21 && data(i,1)<=25) % between n=100
            activity_bet_100((group-1)*360*5+(roundg-2)*360+time,id_grp)=1;
        end;
    end;
end;

save('activity.mat','activity_crit_10','activity_crit_50','activity_crit_100','activity_bet_10','activity_bet_50','activity_bet_100');