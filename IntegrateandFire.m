clc, clear
close all

deltaT = 10^-3;
current = [9 11 15 100];
v = zeros(100,length(current));
th = 10;
spike = zeros(100,length(current));
t = 1:100;
for current_idx = 1:length(current)
    for i=1:99
        v(i+1,current_idx) = v(i,current_idx)+(deltaT/10^-2)*(-v(i, current_idx)+current(current_idx));
        if v(i+1,current_idx)>th
            v(i+1,current_idx) = 0;
            spike(i+1,current_idx) = 1;
        end
    end
    figure(current_idx)
    subplot(1,2,1)
    plot(deltaT*t, v(:,current_idx))
    title(['Voltage vs. time, current is ', num2str(current(current_idx))]);
    subplot(1,2,2)
    scatter(deltaT*t, spike(:,current_idx))
    title(['Spike train vs. time, current is ', num2str(current(current_idx))]);
end





    