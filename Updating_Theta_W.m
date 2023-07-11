function [Next_Theta,Next_W]=Updating_Theta_W(Theta,W,move_step_Theta,move_step_W,delta_Theta_J,delta_W_J)
length_n=length(Theta);
Next_Theta = Theta - delta_Theta_J*move_step_Theta;
Next_W = W - delta_W_J*move_step_W;

for i=1:length_n
    if Next_Theta(i) < 0
        Next_Theta(i) = 0;
    end
    
    if Next_W(i) < 0
        Next_W(i) = 0;
    end
end