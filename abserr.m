function abserr = abserr(x,y)
%
% Absolute error - compute the absolute error in db.
% abserr(x,y) = 10*log10((sum(x(:)-y(:))ˆ2));
%
% e = abserr(x,y);


abserr = 10*log10((sum(x(:)-y(:))^2));
