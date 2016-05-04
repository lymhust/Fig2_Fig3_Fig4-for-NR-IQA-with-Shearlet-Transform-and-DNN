function dshear=shearing_filters_Myer(m,num,L)
% This function computes the shearing filters (wedge shaped) using the Meyer window
% function.
%
% Inputs: m - size of shearing filter matrix desired, m = [m(1),...,m(N)] where
%             each entry m(j) determines size of shearing filter matrix at scale j. 
%         num - the parameter determining the number of directions. 
%               num = [num(1),...,num(N)] where each entry num(j)
%               determines the number of directions at scale j.  
%               num(j) ---> 2^(num(j)) + 2 directions.
%         L - size of the input image ; L by L input image. 
%
%
% Outputs: dshear{j}(:,:,k) - m(j) by m(j) shearing  filter matrix at orientation
%                             k and scale j.  
%
%
% For example, dshear=shearing_filters_Myer([100 100 180 180],[3 3 4 4],L);
% produces cell array 'dshear' consisting of 
%          10 shearing filters (100 by 100) at scale j = 1 (coarse scale)  
%          10 shearing filters (100 by 100) at scale j = 2 
%          18 shearing filters (180 by 180) at scale j = 3 
%          18 shearing filters (180 by 180) at scale j = 4 (fine scale) 



% Originally written by Glenn R. Easley on Feb 2, 2006.
% Modified by Wang-Q Lim, Dec. 2010

for j = 1:length(num)
    n1 = m(j); level = num(j);    
    [x11,y11,x12,y12,F1]=gen_x_y_cordinates(n1);
    N=2*n1;
    M=2^level+2;

    wf=windowing(ones(N,1),2^level,1);
    w_s{j}=zeros(n1,n1,M);
    w = zeros(n1,n1);
    for k=1:M,
        temp=wf(:,k)*ones(N/2,1)';
        w_s{j}(:,:,k)=rec_from_pol(temp,n1,x11,y11,x12,y12,F1);
        w = w + w_s{j}(:,:,k);
    end
    for k = 1:M
        w_s{j}(:,:,k) = sqrt(1./w.*w_s{j}(:,:,k));
        w_s{j}(:,:,k) = real(fftshift(ifft2(ifftshift((w_s{j}(:,:,k))))));
    end
end

for j = 1:length(num)
    [r c n] = size(w_s{j});
    w = zeros(L);
    for k = 1:n
        shear{j}(:,:,k) = zeros(L);
        shear{j}(1:r,1:c,k) = w_s{j}(:,:,k);
        tmp = fft2(shear{j}(:,:,k));
        shear{j}(:,:,k) = tmp;
        w = w + tmp.^2;
    end
    z = zeros(L);
    for k = 2:n-1
        dshear{j}(:,:,k) = sqrt(1./w.*shear{j}(:,:,k).^2);
        z = z+dshear{j}(:,:,k).^2;
    end
    s = 1-z;
    dshear{j}(:,:,1) = sqrt([zeros(L/2) ones(L/2); ones(L/2) zeros(L/2)].*s);
    dshear{j}(:,:,n) = sqrt([ones(L/2) zeros(L/2); zeros(L/2) ones(L/2)].*s);
end
