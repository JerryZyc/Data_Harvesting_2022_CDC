%Initialization
load T_R_Phi_S_Final_List_3target_3_dif_end.mat
T_list=T_R_Phi_S_Final_List(1,:);
R_list=T_R_Phi_S_Final_List(2:4,:);
r_list=fliplr(R_list);
Phi_list=T_R_Phi_S_Final_List(5:7,:);
S_list=T_R_Phi_S_Final_List(end,:);
n_step=length(S_list);
interval = 20;

color_bar1=[0.7,0.7,0.9]*0.9;
color_bar2=[0.9,0.7,0.7]*0.9;
color_bar3=[0.7,0.9,0.7]*0.9;

%data_process
Phi_new_list=Phi_list(:,1:interval:end);
S_new_list=S_list(:,1:interval:end);
n_new_step=length(S_new_list);

%Video Start
v=VideoWriter('Phi_t_3dVideo_dif_test.evi');
open(v);

y_max=max(Phi_new_list(2,:));
x=T_list(1:interval:end);
for i=1:n_new_step
    y1=Phi_new_list(1,1:i);
    y2=Phi_new_list(2,1:i);
    y3=Phi_new_list(3,1:i);
    
    plot(x(1:i),y1,'color',color_bar1,'LineWidth',2);
    hold on
    plot(x(1:i),y2,'color',color_bar2,'LineWidth',2);
    hold on
    plot(x(1:i),y3,'color',color_bar3,'LineWidth',2);
    title('Targets Data Transmitting Rate');
    xlabel('Time(s)')
    ylabel('Data Transmitting Rate')

    xlim([0,x(end)]);
    ylim([0,y_max+0.6]);    
    
    %get frame
    frame = getframe(gcf);   
    writeVideo(v,frame);
end
close(v);

