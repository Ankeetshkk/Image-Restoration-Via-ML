function thre = BayesThres(y,sigma)


n = length(y);
y = y - mean(y); % Shift it so mean becomes 0.
sigmaYSquare = (1/n)*sum(y.^2);
sigmaS = sqrt(max((sigmaYSquare-sigma^2),0));

if sigmaS == 0
sigmaS = max(y(:)); % this will set the threshold to low
end

thre = sigma^2/sigmaS;
