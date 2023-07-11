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
tic

n_target=3;
valied_target=3;
X_target=[2 2.5 4.5];
S=[0 6];
u=[1 -1];
r=[2 2 1.5];
R=[0 0 0];
Theta=[1 2 3];
W=[1 0.5 0.5];
[J,Final_Phi] = J_Computation(X_target,S,u,r,R,Theta,W,n_target);
J_list=[];
Theta_list=[];
W_list=[];
Final_Phi_list=[];
Best_Solution_Index=0;
J_best=J;

%Parameters of IPA
%delta_step - step to compute grandient of J
%delta_J - change of J to compute grandient of J
%move_step_Theta - moving step of Theta in IPA
%moving_step_W - moving step of W in IPA
%delta_bound - iteration lower bound of J's change
%gamma - Armijo Reducing Parameter
%k - index of Armijo
%k_bound - Max_iteration of Armijo
%alpha - Armijo Condition threshold
delta_J=1;
move_step_Theta_Pre=0.001;
move_step_W_Pre=0.001;
move_step_Theta_Pre2=0.0005;
move_step_W_Pre2=0.0005;
delta_bound=0.0001;
iteration_time=1;
J_value_count=0;
Armijo_Condition=0;
gamma=0.8;
k=1;
k_bound=5;
alpha=0.1;

%(2)IPA Start
while delta_J >= delta_bound || J_value_count <= 200
%Pre-processing
move_step_Theta=move_step_Theta_Pre;
move_step_W=move_step_W_Pre;
J_list=[J_list J];
Theta_list=[Theta_list Theta'];
W_list=[W_list W'];
fprintf('\nStarting %d iteration. The optimization function J = %.3f \n', iteration_time,J);

%(3)Gradient of J
[delta_Theta_J,delta_W_J] = Delta_J_Computation(X_target,r,R,Theta,W,valied_target,Final_Phi);
%[delta_Theta_J,delta_W_J] = Fix_Delta_J(delta_Theta_J,delta_W_J);
fprintf('The gradient of J: \n');
disp([delta_Theta_J;delta_W_J]);
disp(J_value_count);

%(4)Updating J Using IPA
[Next_Theta,Next_W] = Updating_Theta_W(Theta,W,move_step_Theta,move_step_W,delta_Theta_J,delta_W_J);
[J_Next,Final_Phi] = J_Computation(X_target,S,u,r,R,Next_Theta,Next_W,n_target);
if Armijo_Condition == 1
    disp('Armijo Start')
    J_Next_list=zeros(10);
    J_Next_best=J_Next;
    while k <= k_bound && J_Next >= J
        move_step_Theta=move_step_Theta_Pre2;
        move_step_W=move_step_W_Pre2;
        [move_step_W,move_step_Theta,k] = Armijo_Search(move_step_W,move_step_Theta,gamma,k,k_bound);
        [Next_Theta_Ar,Next_W_Ar] = Updating_Theta_W(Theta,W,move_step_Theta,move_step_W,delta_Theta_J,delta_W_J);
        [J_Next,Final_Phi] = J_Computation(X_target,S,u,r,R,Next_Theta_Ar,Next_W_Ar,n_target);
        J_Next_list(k) = J_Next;
        if J_Next < J_Next_best
            J_Next_best = J_Next;
            Next_Theta = Next_Theta_Ar;
            Next_W = Next_W_Ar;
        end
        k=k+1;
    end
    k=1;
end

delta_J=abs(J_Next-J);
Final_Phi_list=[Final_Phi_list Final_Phi'];
%delta_J=norm([delta_Theta_J,delta_W_J]);
fprintf('The next optimization function J_next = %.3f \n\n', J_Next);

%(5)Updating Parameters
Theta=Next_Theta;
W=Next_W;
J=J_Next;
iteration_time=iteration_time+1;
if J < J_best
    J_best=J;
    Best_Solution_Index=iteration_time;
end
if delta_J < delta_bound
    J_value_count = J_value_count+1;
end

%(6)Check Armijo Condition
if iteration_time > 300
    J_front_mean=mean(J_list(end-200:end-100));
    J_end_mean=mean(J_list(end-100:end));
    if abs(J_front_mean-J_end_mean) < alpha
        Armijo_Condition = 1;   
    end
end

%Optimization ending
end 

%(7)Output of Parameters
fprintf('The final Theta and W are:\n');
Theta_best=Theta_list(:,Best_Solution_Index);
W_best=W_list(:,Best_Solution_Index);
disp([Theta_best;W_best]);

%(8)Output of Plots
[T_list, R_list, Phi_list, S_list] = Data_collecting(X_target,S,u,r,R,Theta_best,W_best,n_target);
J=T_list(end);
Result_plotout(T_list, R_list, Phi_list, S_list, n_target);
figure(4)
plot([1:iteration_time-1],J_list,'blue -');
xlabel('Iterations')
ylabel('J Value')
title('J Value Plot')
fprintf('The final plots are printed.\n');


%(9)Saving results
%save J_3_value_T1_T2_W1_W2_2_IPA_Curve.mat J_list
%save W1_W2_3_mesh_data.mat W_list
%save T1_T2_3_mesh_data.mat W_list Theta_list

%T_R_Phi_S_Final_List =[T_list; R_list; Phi_list; S_list];
%save T_R_Phi_S_Final_List_3target_3_end.mat T_R_Phi_S_Final_List

toc


