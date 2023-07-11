%Initialization
load T_R_Phi_S_Final_List_3target_3_dif_end.mat
T_list=T_R_Phi_S_Final_List(1,:);
R_list=T_R_Phi_S_Final_List(2:4,:);
r_list=fliplr(R_list);
Phi_list=T_R_Phi_S_Final_List(5:7,:);
S_list=T_R_Phi_S_Final_List(end,:);
n_step=length(S_list);
interval = 20;

%data_process
r_new_list=r_list(:,1:interval:end);
S_new_list=S_list(:,1:interval:end);
n_new_step=length(S_new_list);

color_bar1=[0.7,0.7,0.9]*0.9;
color_bar2=[0.9,0.7,0.7]*0.9;
color_bar3=[0.7,0.9,0.7]*0.9;

%Video Start
v=VideoWriter('r_s_3dVideo_dif_test.evi');
open(v);

x=T_list(1:interval:end);
for i=1:n_new_step
    y1=r_new_list(1,1:i);
    y2=r_new_list(2,1:i);
    y3=r_new_list(3,1:i);
    
    plot(x(1:i),y3,'color',color_bar1,'LineWidth',2);
    hold on
    plot(x(1:i),y2,'color',color_bar2,'LineWidth',2);
    hold on
    plot(x(1:i),y1,'color',color_bar3,'LineWidth',2);
    title('Targets Data Volume');
    xlabel('Time(s)')
    ylabel('Data')

    xlim([0,x(end)]);
    ylim([0,3]);    
    
    %get frame
    frame = getframe(gcf);   
    writeVideo(v,frame);
end
close(v);

