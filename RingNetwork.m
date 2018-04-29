%% testing h_input

theta = linspace(-pi/2,pi/2,50);
input = h_input(0, theta, 3, 0.9);
figure;
plot(theta, input, 'LineWidth', 2);
title('Input wrt. Theta', 'FontSize', 20);
xlabel('Theta', 'FontSize', 15);
ylabel('Input', 'FontSize', 15);
xlim([-pi/2 pi/2]);

%% testing gain 

in = linspace(-15,15,100);
gain_out = gain(0.1,0,in);
figure;
plot(in, gain_out, 'LineWidth', 2);
title('Gain wrt. Input', 'FontSize', 20);
xlabel('Input', 'FontSize', 15);
ylabel('Gain', 'FontSize', 15);
xlim([-15, 15]);

%% Euler simulation - Step 2

close all
N = 50;
theta = linspace(-pi/2,pi/2,N);
epsilon = 0.9;
maxsteps = 30;
activity = zeros(maxsteps,N);
c_array = [1.2, 4, 100];

for c_idx = 1:3

    c = c_array(c_idx);
    h = h_input(0, theta, c, epsilon);


    for step = 1:(maxsteps-1)
        activity(step+1,:) = Euler_iter(activity(step,:),h);
    end
    
    figure(c_idx);
    %imagesc(activity);
    image(100*activity);
    %colorbar;
    xlabel('Preferred orientation', 'FontSize', 15);
    ylabel('Time', 'FontSize', 15);
    title('Activity of the ring network over time', 'FontSize', 20);
    
end

%increase c -> lose selectivity because nonlinearity cap

%% testing connection
imagesc(connection(theta));
colorbar;

%% Modelling the network - Step 3 - comment: essentially the same for
%different c values, since the gain function is already maxed out (for
%small times one can see a difference)

close all
N = 50;
theta = linspace(-pi/2,pi/2,N);
epsilon = 0.9;
maxsteps = 300;
activity = zeros(maxsteps,N);
c_array = [0.0000001 4  50 200 4000]; % for big values contrast invariance 
%is not true anymore! (because connection weight are not big relative to 
%contrast anymore, i.e. current to neuron is not dominated by network but
%by external current from stimuli!
conn_matrix = connection(theta);

for c_idx = 1:length(c_array)

    c = c_array(c_idx);
    

    for step = 1:(maxsteps-1)
        h = h_input_modified(0, theta, c, epsilon, conn_matrix, activity(step,:));
        activity(step+1,:) = (Euler_iter(activity(step,:)',h))'; %in this case we need the transpose, because we defined everything as a column vector
    end
    
    figure(c_idx);
    %imagesc(activity);
    image(100*activity);
    %colorbar;
    xlabel('Preferred orientation', 'FontSize', 15);
    ylabel('Time', 'FontSize', 15);
    title('Activity of the ring network over time', 'FontSize', 20);
    
end

%% Apply different stimuli to the ring network - Step 4
%4.1 - comment: activity sways to neurons with preferred location at about 2*pi/3 as expected 

close all
theta = linspace(-pi/2,pi/2,N);
maxsteps = 30;
epsilon = 0.9;
c = 100;
activity = zeros(maxsteps,N);
conn_matrix = connection(theta);
for step = 1:(maxsteps-1)
    h = h_input_modified(0, theta, c, epsilon, conn_matrix, activity(step,:));
    activity(step+1,:) = (Euler_iter(activity(step,:)',h))'; %in this case we need the transpose, because we defined everything as a column vector
end

activity_last = activity(end,:);


maxsteps = 500;
activity = zeros(maxsteps,N);
activity(1,:) = activity_last;

for step = 1:(maxsteps-1)
    h = h_input_modified(2*pi/3, theta, c, epsilon, conn_matrix, activity(step,:)); %looks wrong, but not, because 2*2*pi/3 = 4*pi/3 = -2*pi/3
    activity(step+1,:) = (Euler_iter(activity(step,:)',h))'; %in this case we need the transpose, because we defined everything as a column vector
end

%imagesc(activity);
%colorbar;
imagesc(100*activity);
xlabel('Preferred orientation', 'FontSize', 15);
ylabel('Time', 'FontSize', 15);
title('Activity of the ring network over time, theta0 is 2pi/3', 'FontSize', 20);

%% 4.2 - comment: activity stays the same w/o external stimulus

close all
N = 50;
theta = linspace(-pi/2,pi/2,N);
maxsteps = 30;
epsilon = 0.9;
c = 1.2;
activity = zeros(maxsteps,N);
conn_matrix = connection(theta);
for step = 1:(maxsteps-1)
    h = h_input_modified(0, theta, c, epsilon, conn_matrix, activity(step,:));
    activity(step+1,:) = (Euler_iter(activity(step,:)',h))'; %in this case we need the transpose, because we defined everything as a column vector
end

activity_last = activity(end,:);
activity_before = activity;

maxsteps = 30;
activity = zeros(maxsteps,N);
activity(1,:) = activity_last;
c = 0; %removing the external stimulus

for step = 1:(maxsteps-1)
    h = h_input_modified(2*pi/3, theta, c, epsilon, conn_matrix, activity(step,:)); %looks wrong, but not, because 2*2*pi/3 = 4*pi/3 = -2*pi/3
    activity(step+1,:) = (Euler_iter(activity(step,:)',h))'; %in this case we need the transpose, because we defined everything as a column vector
end

%imagesc(activity);
%colorbar;
%image(100*activity);
image(100*[activity_before;activity]);
xlabel('Preferred orientation', 'FontSize', 15);
ylabel('Time', 'FontSize', 15);
title('Activity of the ring network over time', 'FontSize', 20);

    