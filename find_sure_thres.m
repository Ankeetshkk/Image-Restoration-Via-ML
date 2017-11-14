function thres = find_sure_thres(x,sigma)
%

n = length(x);
thre_range = linspace(0,sqrt(2*log(n)),20); %
r_list = [];

for t = thre_range
thres = t;
r = (n*sigma^2-2*sigma^2*(sum(abs(x) < thres))...
+ sum(min(abs(x),thres).^2))/n;
r_list = [r_list,r];
end
[tmp,i] = min(r_list); 
thres = thre_range(i);

%% Multiply it with log10(n) to achieve the better performance.

thres = log10(n)*thres;
