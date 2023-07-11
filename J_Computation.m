function [J,Final_Phi] = J_Computation(X_target,S,u,r,R,Theta,W,n_target)
%Initilization of Parameters
%time_step
%T - time spent
%s_agent - position of agent
%u_speed - speed of agent
%i - parameter of Theta and W
time_step=0.001;
T=0;
T_dwelling=0;
s_agent=S(1);
n_visiting_points=length(Theta);

for i=1:n_visiting_points
    distance_2_point = Theta(i) - s_agent;
    
    if distance_2_point > 0  
        while distance_2_point > 0        
            data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
            R = R + time_step*data_rate;
            u_speed=u(1);       
            distance_2_point = Theta(i) - s_agent;
            s_agent =s_agent + time_step*u_speed;
            T = T + time_step;
        end            
    elseif distance_2_point < 0 
        while distance_2_point < 0        
            data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
            R = R + time_step*data_rate;
            u_speed=u(2);       
            distance_2_point = Theta(i) - s_agent;
            s_agent =s_agent + time_step*u_speed;
            T = T + time_step;
        end
    end
    
    while T_dwelling < W(i)
        data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
        R = R + time_step*data_rate;
        u_speed = 0;
        T_dwelling = T_dwelling + time_step;   
        s_agent =s_agent + time_step*u_speed;
        T = T + time_step;
    end    
    T_dwelling = 0;
end

%Collecting while moving
while abs(s_agent-S(2)) >= 0.001
    data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
    R = R + time_step*data_rate;
    u_speed=u(1);
    %Iteration of agent position and time
    direction=-(s_agent-S(2))/abs(s_agent-S(2));
    s_agent =s_agent + time_step*u_speed*direction;
    T = T + time_step;
end

%When reach to the end point
while R_Data_Satisfied(R,r) == 0
    u_speed=0;
    data_rate = Phi_transmitting_speed(s_agent,X_target,r,R,n_target);
    R = R + time_step*data_rate;
    s_agent =s_agent + time_step*u_speed;
    T = T + time_step;
end

%Final Output
Final_Phi = data_rate;
J = T;



