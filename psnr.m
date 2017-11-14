function p = psnr(x,y, vmax)
% psnr - compute the Peack Signal to Noise Ratio, defined by :
%       PSNR(x,y) = 10*log10( max(max(x),max(y))^2 / |x-y|^2 ).
%
%   p = psnr(x,y);

[h,w,c] = size(x);
if nargin<3
    m1 = max(max( abs(x(:))) );
    m2 = max(max( abs(y(:))) );
    vmax = max(m1,m2);
end

d = 0;
for i = 1:c
    d = d+sum(sum((x(:,:,i)-y(:,:,i)).^2));
end
d = d/(c*w*h);

p = 10*log10( vmax^2/d );