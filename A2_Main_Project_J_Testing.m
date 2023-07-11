%This is the frist version of a data harvesting program. Here I tend to
%test the function and methods of my project.The objective is to collect all
%the data in each target.

%(1)Setting of Agents and Targets:
%X - set of target position
%S - start and final position of agent
%r - set of data volume to be harvested
%R - set of data collected from targets
%u - set of speed 
%Theta - set of event position
%W - set of dwelling time
%J - the fincal optimization function
n_target=3;
X_target=[2 3 4];
S=[0 4];
u=[1 -1];
r=[3 2 0];
R=[0 0 0];
Theta=[2 1 4];
W=[1 2 0];
J = J_Computation(X_target,S,u,r,R,Theta,W,n_target);


%(2)Data collecting process
[T_list, R_list, Phi_list, S_list] = Data_collecting(X_target,S,u,r,R,Theta,W,n_target);
J=T_list(end);


%(3)Plot output
%Plot of R the data collected
Result_plotout(T_list, R_list, Phi_list, S_list);
fprintf('The optimization function J = %.3f \n', J);





