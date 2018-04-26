%data

%x = [0,0;0,1;1,0;1,1];
%y = [0;1;1;1];
%y = [0;1;1;0]; %-> nonlinear, if >= in heaviside then no convergence, w oscillates between (0,0) and (1,1), otherwise if > in heaviside then w = (1,1)
%n = 2;

%random data

p = 50; % for p = 30 converges
n = 100;
x = round(rand(p,n));
y = round(rand(p,1));

%initialization

w = zeros(n,1);
b = 1;
alfa = 1;
maxiter = 50;
i = 0;
cost = inf;

%perceptron

while i<maxiter & cost~=0
    pred = ((x*w-b)>=0); %>
    err = (y-pred);
    cost = sum(err.^2);
    disp(cost);
    w = w+alfa*x'*err;
    i = i+1;
end




