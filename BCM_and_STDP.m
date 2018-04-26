%% BCM

close all
clc, clear

%Initialization
x_1 = [20; 0];
x_2 = [0; 20];
timestep = 10^-3;
T = 10; %everything in seconds
y0 = 10;
tau = 50*10^-3;
n = 10^-3;
y = zeros(1, T/timestep);
w = zeros(2, T/timestep + 1);
w(:,1) = [0.5; 1];
teta = zeros(1, T/timestep + 1);
teta(1) = 23;

for t=1:T/timestep
    if rand > 0.5
        x = x_1;
    else
        x = x_2;
    end
    
    %Updates
    
    y(t) = w(:,t)'*x;
    w(:,t+1) = w(:,t)+timestep*n*x*y(t)*(y(t)-teta(t));
    teta(t+1) = teta(t) + 1/tau * timestep * (-teta(t)+y(t)^2/y0);
    
    %Hard bound on w
    w(:,t+1) = w(:,t+1).*(w(:,t+1)>=0);
    
end

t = 10^-3:10^-3:10;

%Plot weights
figure
plot(t,w(1,1:end-1),'LineWidth',2);
hold on
plot(t,w(2,1:end-1),'LineWidth',2);
legend('First component', 'Second component');
xlabel('Time', 'FontSize', 15);
ylabel('Magnitude', 'FontSize', 15);
title('Weights evoluation over time', 'FontSize', 15);

%Plot teta
figure
plot(t,teta(1:end-1),'LineWidth',2);
xlabel('Time', 'FontSize', 15);
ylabel('Teta', 'FontSize', 15);
title('Teta evoluation over time', 'FontSize', 15);

%Plot y - average indeed goes to y0!! 
figure
scatter(t,y,'LineWidth',2);
xlabel('Time', 'FontSize', 15);
ylabel('Postsynaptic firing rate (y)', 'FontSize', 15);
title('Y evoluation over time', 'FontSize', 15);

%% STDP

%tdiff is tpre - tpost

%Initialization
Aplus = 1;
Aminus = 1;
tauplus = 10; %time in miliseconds
tauminus = 20;
T = 60*10^3;
timestep = 1;
diffvec = (-50:5:50);
no_exp = length(diffvec);
w = zeros(no_exp, T/timestep + 1);
w(:,1) = 1;
tpre = 1:1000:T;


for j = 1:no_exp
    
    tpost = tpre + diffvec(j);
    
    x = 1; 
    y = 1;
    
    for t=1:T/timestep
        x = x + 1/tauplus * timestep * (-x+sum(t*timestep==tpre)); %sum is one max
        y = y + 1/tauminus * timestep * (-y+sum(t*timestep==tpost));
        w(j,t+1) = w(j,t) + timestep * Aplus*x*sum(t*timestep==tpost)-Aminus*y*sum(t*timestep==tpre);
    end
end

figure;
scatter(-diffvec, w(:,end), 'LineWidth', 2) %minus to make the x axis be t_pre - t_post as plotted in class
xlabel('tpre - tpost', 'FontSize', 15);
ylabel('Relative weight change', 'FontSize', 15);
title('Weight change vs. spiking time lags', 'FontSize', 15)
    
        
        




