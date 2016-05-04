function p = ggd(x,alfa,beta)
% From wiki
p = exp(-(abs(x./alfa)).^beta)./(2*alfa*gamma(1/beta)/beta);

% sbeta =sqrt(beta);
% p = exp(-abs(sbeta*x).^rho) * sbeta / (2*gamma(1+1/rho));

return