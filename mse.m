function mse = mse(x,y)



[a1 b1] = size(x);
[a2 b2] = size(y);

a = max(a1,a2);
b = max(b1,b2);

mse = (1/(a*b))*sum( (x(:)-y(:)).^2 );
