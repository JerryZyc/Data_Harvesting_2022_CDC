function Result_plotout(T_list, R_list, Phi_list, S_list,n_target)
color_bar1=[0.9,0.5,0.9]*0.9;
color_bar2=[0.9,0.5,0.5]*0.9;
color_bar3=[0.5,0.8,0.9]*0.9;
color_bar4=[0.6,0.6,0.95]*0.8;
%color_bar5=[0.7,0.3,0.7]*0.9;

if n_target <=3
figure(1)
plot(T_list,R_list(1,:),'-','color',color_bar1,'LineWidth',2);
hold on
plot(T_list,R_list(2,:),'-','color',color_bar2,'LineWidth',2);
hold on
plot(T_list,R_list(3,:),'-','color',color_bar3,'LineWidth',2);
legend('Target1','Target2','Target3')
xlabel('Time')
ylabel('Data Volume')
%title('Data Collected from Targets')
%fig1 = figure(1);
%saveas(fig1,'C:\Users\12647\Desktop\fig1_R.eps','epsc')

%Plot of Phi the data rate
figure(2)
plot(T_list,Phi_list(1,:),'-','color',color_bar1,'LineWidth',2);
hold on
plot(T_list,Phi_list(2,:),'-','color',color_bar2,'LineWidth',2);
hold on
plot(T_list,Phi_list(3,:),'-','color',color_bar3,'LineWidth',2);
legend('Target1','Target2','Target3')
xlabel('Time')
ylabel('Data Transmitting Rate')
%title('Data Transmitting Rate of Targets')
%fig2 = figure(2);
%saveas(fig2,'C:\Users\12647\Desktop\fig2_Phi.eps','epsc')

%Plot of Phi the data rate
figure(3)
plot(T_list,S_list,'-','color',color_bar4,'LineWidth',2);
xlabel('Time')
ylabel('Agent Postition')
y_max=max(S_list);
xlim([0,T_list(end)]);
ylim([0,y_max+0.5]);   
%title('Agent Postition Plot')
%fig3 = figure(3);
%saveas(fig3,'C:\Users\12647\Desktop\fig3_St.eps','epsc')

end

%% 4 targets Plots
if n_target == 4
figure(1)
plot(T_list,R_list(1,:),'black -');
hold on
plot(T_list,R_list(2,:),'red -');
hold on
plot(T_list,R_list(3,:),'b -');
hold on 
plot(T_list,R_list(4,:),'c -');
xlabel('Time(s)')
ylabel('Data Volume')
title('Data Collected from Targets')

%Plot of Phi the data rate
figure(2)
plot(T_list,Phi_list(1,:),'black -');
hold on
plot(T_list,Phi_list(2,:),'red -');
hold on
plot(T_list,Phi_list(3,:),'b -');
hold on 
plot(T_list,Phi_list(4,:),'c -');
xlabel('Time(s)')
ylabel('Data Transmitting Rate')
title('Data Transmitting Rate of Targets')

%Plot of Phi the data rate
figure(3)
plot(T_list,S_list,'black -');
xlabel('Time(s)')
ylabel('Agent Postition')
title('Agent Postition Plot')
end  
    


