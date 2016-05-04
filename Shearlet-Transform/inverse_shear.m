function x = inverse_shear(d,pfilt,shear)
% This function computes inverse shearlet transform 
%
% Input: d : shearlet coefficients. 
%        pfilt: name of filter for nonsubsampled LP (see atrousdec.m).
%        shear : cell array of shearing filters 
%                 (see shearing_filters_Myer.m).
%
% Output: x : reconstructed image 

% For more details, see instruction.m


level = length(shear);
% number of scales

for j = 1:level
    num(j) = size(shear{j},3);
end
%num(j) contains the number of directions across each scale j.


y{1}=d{1};
[r c] = size(y{1});

for  j = 1:level
    y{j+1} = zeros(r,c);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% apply directional shearlet filters to decomposed images y{j} for each
% scale j
for j = 1:level
    for k=1:num(j),
        y{j+1} = y{j+1}+ifft2(fft2(d{j+1}(:,:,k)).*shear{j}(:,:,k));
    end
end

x=real(atrousrec(y,pfilt));