function f = meyer_wind(q)
% This function computes the Meyer window function

% Written by Wang-Q Lim on May 5, 2010. 
% Copyright 2010 by Wang-Q Lim. All Right Reserved.


L = length(q);
for j = 1:L
    x = q(j);
    if -1/3+1/2<x & x<1/3+1/2
        y = 1;
    elseif (1/3+1/2<=x & x<=2/3+1/2) | (-2/3+1/2<=x & x<=1/3+1/2)        
        w = 3.*abs(x-1/2)-1;
        z = w^4.*(35-84.*w+70.*w.^2-20.*w.^3);
        y = cos(pi/2*(z)).^2;
    else
        y = 0;
    end
f(j) = y;
end


    
        
        