close all

v=VideoWriter('exp3dVideo.evi');
open(v);

y=zeros(50);
for k=0:50
    
    x=(1:50)/5;
    for i=1:k
        y(i)=cos(x(i));
    end
    
    plot(x(1:k),y(1:k));
    
    xlim([0,10]);
    ylim([-1,1]);    
      
    %get frame
    frame = getframe(gcf);   
    writeVideo(v,frame);
end
close(v);


