function [delta_Theta_J,delta_W_J]= Delta_J_Computation(X_target,r,R,Theta,W,valied_target,Final_Phi_list)

%Initialized Variables
Logical_Phi=logical(Final_Phi_list);
Case_Log_Phi=sum(Logical_Phi);

if Case_Log_Phi>0
    [~,y] = max(Logical_Phi);
    target_j = y;
    %disp(y);
end

n=valied_target;
n_target=length(Theta);
delta_Theta_J=zeros(size(Theta));
delta_W_J=zeros(size(W));

switch Case_Log_Phi
    %case1: All targets' data have been collected well
    case 0
        for i=1:n
            delta_Theta_J(i)=0;
            delta_W_J(i)=1;
        end
        
        
    %case2: Only 1 target need to be collected when reach to final point
    case 1    
        for i=1:n
            Phi_Final = Final_Phi_list(target_j);
            %disp(Phi_Final);
    
            Partial_Phi_Theta = Partial_Phi_Partial_Theta(Theta(i),X_target(target_j));
            delta_Theta_J(i)=(-W(i)/(Phi_Final))*Partial_Phi_Theta;
    
            Phi_Theta_i = Phi_transmitting_speed(Theta(i),X_target,r,R,n_target);
            delta_W_J(i)=(-Phi_Theta_i(target_j)/Phi_Final)+1; 
        end
end


