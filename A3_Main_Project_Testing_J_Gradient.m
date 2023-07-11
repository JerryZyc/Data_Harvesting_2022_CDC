%This is the Second version of a data harvesting program. Here I tend to
%compute the optimization target J.
%(1)Setting of Agents and Targets:
%X - set of target position
%S - start and final position of agent
%r - set of data volume to be harvested
%R - set of data collected from targets
%u - set of speed
%Theta - set of event position (dwelling position)
%W - set of dwelling time
%J - the fincal optimization function
%J_list - recording of J's change
n_target=3;
X_target=[2 3 4];
S=[0 4];
u=[1 -1];
r=[3 2 0];
R=[0 0 0];
Theta=[0 3 4];
W=[1.5 1 0];
J = J_Computation(X_target,S,u,r,R,Theta,W,n_target);
J_list=[];
Theta_list=[];
W_list=[];
Delta_J_List=[];

%Parameters of IPA
%delta_step - step to compute grandient of J
%delta_J - change of J to compute grandient of J
%move_step_Theta - moving step of Theta in IPA
%moving_step_W - moving step of W in IPA
%delta_bound - iteration lower bound of J's change
delta_step=0.001;
delta_J=1;
move_step_Theta=0.01;
move_step_W=0.01;
iteration_time=1;

%IPA Start
Next_Theta=[0 0 0];
while Next_Theta(1) < 5
%(2)Data collecting process
J_list=[J_list J];
Theta_list=[Theta_list Theta'];
W_list=[W_list W'];
fprintf('\nStarting %d iteration. The optimization function J = %.3f \n', iteration_time,J);

%(4)Updating J Using IPA
Next_Theta = Theta + [move_step_Theta 0 0];
Next_W = W;
J_Next = J_Computation(X_target,S,u,r,R,Next_Theta,Next_W,n_target);
delta_J=abs(J_Next-J);
Delta_J_List=[Delta_J_List delta_J];
fprintf('The next optimization function J_next = %.3f \n\n', J_Next);

%(5)Updating Parameters
Theta=Next_Theta;
W=Next_W;
J=J_Next;
iteration_time=iteration_time+1;
end

%(6)Output of Parameters
fprintf('The final Theta and W are:\n');
disp([Theta;W]);

%(7)Output of Plots
[T_list, R_list, Phi_list, S_list] = Data_collecting(X_target,S,u,r,R,Theta,W,n_target);
J=T_list(end);
Result_plotout(T_list, R_list, Phi_list, S_list);

figure(4)
plot([1:iteration_time-1]*0.01,J_list,'blue -');
xlabel('Theta1 Value')
ylabel('J Value')
title('J Value Plot with W(1.5 1)')
fprintf('The final plots are printed.\n');

figure(5)
plot([1:iteration_time-1]*0.01,Delta_J_List,'red -');
xlabel('Theta1 Value')
ylabel('J Delta Value')
title('J Delta Value Plot with W(1.5 1)')
fprintf('The final plots are printed.\n');










