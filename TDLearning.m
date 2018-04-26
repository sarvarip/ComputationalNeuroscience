%cue at second 5, reward at second 20

Trials=100; %number of trials
Time=20;    %total time
rewTime=20; %reward time
cueTime=5; %start cue
endCueTime=rewTime; %end cue
n=endCueTime-cueTime+1; %cue duration

X= eye(n);
X=[zeros(n,cueTime-1), X, zeros(n,Time-endCueTime)];

V=zeros(Time,Trials);
w = zeros(n,1); %weights
weights = zeros(n,Trials); %to save weights, same as V(t+1)!
r = zeros(Time,Trials); %reward
r(rewTime,:)=1;
%skip one reward
r(rewTime,60)=0;
delta = zeros(Time, Trials); %prediction error


gamma= 1; %1
alpha= 1; %0.6

%t=time, i=trial
for i=1:Trials
    weights(:,i) = w;
    V(:,i)= X'*w; %value function
    delta(1:end-1,i)= r(1:end-1,i)+gamma*V(2:end,i)-V(1:end-1,i);%prediction error
    delta(end,i) = r(end,i)-V(end,i);
    w= w+alpha*X*delta(:,i);
end


%% Plot 

%Plot prediction error
figure
surf(delta')
ylabel('trials')
xlabel('time')
zlabel('prediction error')

%Plot value function 
figure
surf(V)
xlabel('trials')
ylabel('time')
zlabel('V')