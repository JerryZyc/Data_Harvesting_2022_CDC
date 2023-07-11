function Partial_Phi_Theta = Partial_Phi_Partial_Theta(Theta_i,X_target_j)
B=0.5;
height=0.5;
K=2;
N=3;

Theta_d=Theta_i-X_target_j;

Theta2_H2=Theta_d*Theta_d+height*height;
    
KNTheta=1+(K/(N*Theta2_H2));
    
Partial_Phi_Theta=B*(1/(KNTheta*log(2)))*(-K/N)*((Theta2_H2)^(-2))*2*Theta_d;