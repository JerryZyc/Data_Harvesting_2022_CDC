%Initialization
load T_R_Phi_S_Final_List_3target_3_dif_end.mat
T_list=T_R_Phi_S_Final_List(1,:);
R_list=T_R_Phi_S_Final_List(2:4,:);
r_list=fliplr(R_list);
Phi_list=T_R_Phi_S_Final_List(5:7,:);
S_list=T_R_Phi_S_Final_List(end,:);
n_step=length(S_list);

%data_process
interval = 20;
r_new_list=r_list(:,1:interval:end);
S_new_list=S_list(:,1:interval:end);
n_new_step=length(S_new_list);

%Video Start
v=VideoWriter('r_t_bar_3d_3colar_Video_dif_test.evi');
open(v);

y_max=3;
x=[1.8 2.8 4.3];
color_bar1=[0.7,0.7,0.9]*0.8;
color_bar2=[0.9,0.7,0.7]*0.8;
color_bar3=[0.7,0.9,0.7]*0.8;
for i=1:n_new_step
    agent_x = S_new_list(i);
    agent_y = y_max-0.2;
    
    y1=r_new_list(3,i);
    y2=r_new_list(2,i);
    y3=r_new_list(1,i);
    y=[y1 y2 y3];
    
    h1=bar(x(1),y(1),0.5);
    %set(h1,'FaceColor',color_bar1*(y(1)/y_max));
    set(h1,'FaceColor',color_bar1);
    hold on
    h2=bar(x(2),y(2),0.5);
    set(h2,'FaceColor',color_bar2);
    hold on
    h3=bar(x(3),y(3),0.5);
    set(h3,'FaceColor',color_bar3);
    hold on
    set(gca,'XTick',[1.8 2.8 4.3],'xticklabel',{'Tar1','Tar2','Tar3'});
    %set(h3,'xticklabel','3','FaceColor',color_bar*(y(3)/y_max));
    
    plot(agent_x,agent_y,'o','MarkerSize',8);
    text(agent_x-0.22,agent_y-0.1,'drone');
    
    title('Targets Data Volume');
    xlabel('Target Position')
    ylabel('Data Volume')

    xlim([0,6]);
    ylim([0,3]);    
    hold off   
    
    %get frame
    frame = getframe(gcf);   
    writeVideo(v,frame);
    
end
close(v);

