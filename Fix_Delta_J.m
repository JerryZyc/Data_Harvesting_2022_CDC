function [delta_Theta_J,delta_W_J]= Fix_Delta_J(delta_Theta_J,delta_W_J)

length_n=length(delta_Theta_J);

for i=1:length_n
    if abs(delta_Theta_J(i)) > 10
        delta_Theta_J(i) = 10*delta_Theta_J(i)/abs(delta_Theta_J(i));
    end
    if abs(delta_W_J(i)) > 10 
        delta_W_J(i) = 10*delta_W_J(i)/abs(delta_W_J(i));
    end    
end