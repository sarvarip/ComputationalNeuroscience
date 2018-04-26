function [matrix] = connection(teta_vec)
    J0 = 86; %86
    J2 = 112;
    [X,Y] = meshgrid(teta_vec, teta_vec');
    matrix = -J0 + J2*cos(2*(X-Y));
end

