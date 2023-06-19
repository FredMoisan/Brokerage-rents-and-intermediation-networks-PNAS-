clear all
close all force;

for i=1:3 % N
    if (i==1)
        n=10;
    elseif (i==2)
        n=50;
    elseif (i==3)
        n=100;
    end;
    for p=1:2 % model
        if (p==1)
            model_txt='critical';
            model_txt2='criticality';
        else
            model_txt='between';
            model_txt2='betweenness';
        end;
        for l=1:4 % init
            if (l==1)
                init_txt='ER_2';
                init_txt2='Erdos-Renyi deg=2';
            elseif (l==2)
                init_txt='ER_5';
                init_txt2='Erdos-Renyi deg=5';
            elseif (l==3)
                init_txt='BA_1';
                init_txt2='Barabasi-Albert deg=1';
            elseif (l==4)
                init_txt='BA_3';
                init_txt2='Barabasi-Albert deg=3';
            end;
            for stable=0:1
                if (stable==1)
                    stable_txt='stable';
                else
                    stable_txt='unstable';
                end;

                load([init_txt '/simul_' model_txt '_' num2str(n) '.mat']);

                for j=1:size(net,1)
                    if ((stable==1 && iterations(j)<=100) || (stable==0 && iterations(j)>100))
                        G=reshape(net(j,:),[n n])';
                        fig = figure('visible','off');
                        plot(graph(G.*G'));
                        if ~exist(['Limit_Networks/' init_txt2 '/' model_txt2 '/N_' num2str(n) '/' stable_txt], 'dir')
                            mkdir(['Limit_Networks/' init_txt2 '/' model_txt2 '/N_' num2str(n) '/' stable_txt]);
                        end;
                        saveas(fig,['Limit_Networks/' init_txt2 '/' model_txt2 '/N_' num2str(n) '/' stable_txt '/net_' num2str(j) '.png']);
                    end;
                end;

            end;
        end;
    end;
end;

