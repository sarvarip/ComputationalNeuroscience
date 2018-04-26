function out = gain(beta, T, h)

    out = beta*(bsxfun(@minus, h, T)).*(h>T).*(h<T+1/beta) + (h>T+1/beta);
    
end