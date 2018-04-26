function next = Euler_iter(previous, input)
    timestep = 10^-3;
    timeconstant = 5*10^-3;
    beta = 0.1;
    T = 0;
    next = previous + timestep/timeconstant * (-previous+gain(beta, T, input));
end