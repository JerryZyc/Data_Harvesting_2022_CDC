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

color_bar1=[0.7,0.7,0.9]*0.6;

%Video Start
v=VideoWriter('s_t_3dVideo_dif_test.evi');
open(v);

x=T_list(1:interval:end);
for i=1:n_new_step
    y1=S_new_list(1,1:i);
    
    plot(x(1:i),y1,'color',color_bar1,'LineWidth',2);
    hold on
    
    title('Agent Position Plot');
    xlabel('Time(s)')
    ylabel('Position')

    xlim([0,x(end)]);
    ylim([0,7]);    
    
    %get frame
    frame = getframe(gcf);   
    writeVideo(v,frame);
end
close(v);