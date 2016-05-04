clc;clear;close all;
%% Setting parameters
spara =[3 3 3 3];
shear = shearing_filters_Myer([32 32 32 32],spara,512);
scale = length(spara);
direction = 2^spara(1) + 2;
filter = 'maxflat';
folder = sprintf('.\\%s\\','ReviseHist');
%  total number of images.
Files = dir(strcat(folder,'*.*'));
dataNum = length(Files) - 2;

Hist = [];
HistLog = [];
binnum = 100;
bins1 = -50:0.5:50;
bins2 = -10:0.1:10;

for num_file = 3:length(Files) % Traverse image folder
    str = Files(num_file).name;
    I = imread(strcat(folder,str));
    I = imresize(I,[512 512]);
    I = rgb2gray(I);
    I = double(I);
    Csh = shear_trans(I,filter,shear);
    for s = 2:length(Csh)
        for w = 1:size(Csh{s},3)
            if s == length(Csh) && w == 1
                temp = Csh{s}(:,:,w);
                hs = real(temp(:));
                hsabs = log2(abs(temp(:)));
                Histreal = hist(hs,bins1);
                Histabs = hist(hsabs,bins2);
                len = length(hs);
                Histreal = Histreal/len;
                Histabs = Histabs/len;
                Hist = [Hist Histreal'];
                HistLog = [HistLog Histabs'];
                figure;
                imshow(real(temp),'Border','tight');
            end
        end
    end
end
Plot_ReviseHist(bins1,log(Hist+0.000001));
legend('ORI','JPEG2K','JPEG','GWN','GBLUR','FF');
Plot_ReviseHist(bins2,HistLog);
legend('ORI','JPEG2K','JPEG','GWN','GBLUR','FF');



