function out = h_input_modified(theta0, theta, c, epsilon, conn_matrix, activity)
    
    theta = theta(:); %making it into column vector
    %activity has to be a vector
    activity = activity(:);
    h_ext = c*((1-epsilon)+epsilon*cos(2*(bsxfun(@minus, theta, theta0))));     
    out = conn_matrix*activity + h_ext;
    
end
