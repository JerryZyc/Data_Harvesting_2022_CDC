function data_rate = Phi_transmitting_speed(agent,X_target,r,R,n_target)
%Parameter setting
%Each meaning
B=0.5;
height=0.5;
K=2;
N=3;
data_rate=zeros(1,n_target);
distance=zeros(1,n_target);

%Computation of data_rate
for i=1:n_target
    distance(i)=abs(agent-X_target(i));
    if R(i)>= r(i)
        data_rate(i) = 0;
    else
        data_rate(i) = B*log2(1+K/(N*(distance(i)^2+ height^2)));
    end    
end







