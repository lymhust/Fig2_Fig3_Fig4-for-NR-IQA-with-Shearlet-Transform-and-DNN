function d = shear_trans(x,pfilt,shear)
% This function generates the shearlet coefficients.
%
% Input :
%        x : input image
%        pfilt: name of filter for nuosubsampled LP (see atrousdec.m)
%        shear: cell array of directional shearing filters
%               (see shearing_filters_Myer.m).
%
% Output :
%        d : cell array of shearlet coefficients
%
% For instruction, see instruction.txt.
%
%
% Written by Wang-Q Lim on May 5, 2010.
% Copyright 2010 by Wang-Q Lim. All Right Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

level = length(shear);
% number of scales


y = atrousdec(x,pfilt,level);
%decompose the input image into subbands of scales j = 1,...,level

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%显示金子塔分解的结果
% figure;
% for i=1:5
%     subplot(2,3,i);
%     mesh(y{i});
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d{1}=y{1};
% low frequency part

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% apply directional shearlet filters to decomposed images y{j} for each
% scale j

for j = 1:level
    %y{j+1} = fftshift(fft2((y{j+1})));
    y{j+1} = fft2((y{j+1}));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%显示对高频分量做FFT后的结果

% figure;
% for i=1:5
%     subplot(2,3,i);
%     if i==1
%         Fimg=fft2(y{1});
%         imshow(abs(fftshift(Fimg)),[]);
%     else
%         imshow(abs(fftshift(y{i})),[]);
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 1:level
    num = size(shear{j},3);
    for k=1:num
        d{j+1}(:,:,k) = (ifft2(shear{j}(:,:,k).*y{j+1}));     
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%滤波器和金子塔分解后的高频分量相乘

% coef=zeros(512,512,6);
% figure;
% for i=1:6
%     frefil=shear{5}(:,:,i).*y{5};
%     frefilshift=abs(fftshift(frefil));
%     subplot(2,3,i);
%     imshow(frefilshift,[],'Border','tight');
%     coef(:,:,i)=ifft2(frefil);
% end
% 
% figure;
% coefsum=zeros(512,512);
% for i=1:6
%     subplot(2,3,i);
%     mesh(abs(coef(:,:,i)));
%     coefsum=coefsum+coef(:,:,i);
% end
% figure;mesh(abs(coefsum));% matlab中的坐标系是列为x，行为y
% figure;imshow(real(coefsum));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





