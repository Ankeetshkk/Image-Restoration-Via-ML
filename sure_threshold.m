function CT = sure_threshold(C,L,incd,sigma)


% FindOut number of decompositions
DecLevels = length(L)-2;

CT = [];
index = 1;

%% Average coefficients
mn = L(1,:); m=mn(1); n=mn(2);
y = C(1:m*n);
if (incd == 0)
CT = [CT,y];
else
t = find_sure_thres(y,sigma);
CT = [CT,SoftThresh(y,t)];
end
index = m*n+1;

%% Detail coefficients
for i = 2:(DecLevels+1)
mn = L(i,:); m=mn(1); n=mn(2);
for j = 1:3 %% 3 loops for horizontal, vertical and diagonal details
y = C(index:index+m*n-1);
index = index+m*n;
t = find_sure_thres(y,sigma);
CT = [CT,SoftThresh(y,t)];
end
end