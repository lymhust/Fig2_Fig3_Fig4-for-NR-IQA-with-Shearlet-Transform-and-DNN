function d = kld(hist1, hist2)

hist1 = hist1/sum(hist1);
hist2 = hist2/sum(hist2);
hist1(hist1 == 0) = eps;
hist2(hist2 == 0) = eps;

d = sum( hist1.*log( hist1./hist2 ) )/sum(hist1);
d = abs(d);

return