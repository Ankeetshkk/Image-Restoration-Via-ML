function CT = visu_threshold(C,L,incd,type,sigma)



CT = [];
thr = sqrt(2*log(length(C)))*sigma;

%% Reduce the soft threshold,
%% because generally threshold is too large.
%%
if strcmp(type,'Soft'),
thr = thr*2/8;
end

thr=thr*3/4;

if incd == 0
mn = L(1,:); m=mn(1); n=mn(2);
cD = C(m*n+1:end);

if strcmp(type,'Hard'),
CT = [C(1:m*n),HardThresh(cD,thr)];
else
CT = [C(1:m*n),SoftThresh(cD,thr)];
end
else
if strcmp(type,'Hard'),
CT = HardThresh(C,thr);
else
CT = SoftThresh(C,thr);
end
end
