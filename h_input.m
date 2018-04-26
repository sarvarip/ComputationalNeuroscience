function out = h_input(theta0, theta, c, epsilon)

%theta vector

out = c*((1-epsilon)+epsilon*cos(2*(bsxfun(@minus, theta, theta0)))); 

end