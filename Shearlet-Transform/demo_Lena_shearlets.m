%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This is a script for testing (Fourier based) shearlet transform
%   test image: Lena
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear;close all;

% Original image
im = imread('Lena_color.jpg');
im = double(im);
[M,N,channel] = size(im);

% Direction number and scale number.
% From coarse to fine. direction number is 2^j+2.
spara =[2 2 2 2 2];
% directional filter banks.
shear = shearing_filters_Myer([32 32 32 32 32],spara,M);

% Take translation invariant shearlet transform.
% '9-7':	 Filters obtained from 9-7 1-D prototypes
% 'maxflat': Filters derived from 1-D using maximally flat mapping function with 4 vanishing moments
% 'pyr':     Filters derived from 1-D using maximally flat mapping function with 2 vanishing moments
% 'pyrexc':	 Same as pyr but exchanging two highpass filters
filter = 'maxflat';

if (channel == 1)
    Csh = shear_trans(im,filter,shear);
    for s = 2:length(Csh)        % Index the scales.
        for w = 1:size(Csh{s},3) % Index the directions.
            temp = Csh{s}(:,:,w);
            maxval = max(abs(temp(:)));
            temp(abs(temp)~=maxval) = 0;
            Csh{s}(:,:,w) = temp;
        end % Index the directionsover.
    end % Index the scales over.
    Csh{1} = zeros(size(Csh{1}));
    % Apply inverse shearlet transform.
    imre = inverse_shear(Csh,filter,shear);
else
    imre = zeros(size(im));
    for i = 1:3
        img = im(:,:,i);
        Csh = shear_trans(img,filter,shear);
        for s = 2:length(Csh)        % Index the scales.
            for w = 1:size(Csh{s},3) % Index the directions.
                temp = Csh{s}(:,:,w);
                maxval = max(abs(temp(:)));
                temp(abs(temp)~=maxval) = 0;
                Csh{s}(:,:,w) = temp;
            end % Index the directionsover.
        end % Index the scales over.
        Csh{1} = zeros(size(Csh{1}));
        % Apply inverse shearlet transform.
        imre(:,:,i) = inverse_shear(Csh,filter,shear);
    end
    
end
imshow(imre,[]);

MSE = sum(sum( (im - imre).^2 ))/(M*N);
PSNR = 10*log10(255^2/MSE);

% Display results
subplot(1,2,1), imshow(im,[0,255]) ;
title( 'Input image' );
subplot(1,2,2), imshow(imre,[0,255]) ;
title( sprintf('Reconstructed image\nMSE = %.3E, PSNR = %.2f dB',MSE,PSNR) );

