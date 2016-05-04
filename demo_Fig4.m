%% STEP 0: Here we provide the relevant parameters values that will
clc; clear; close all;

%% Fig. 2.
load Nomax_ImgGoodFeatures_LIVE_ImgGoodQuality_s4_d6;
GoodMSCA = TrainImg;
GoodMSCA = mean(GoodMSCA');
GoodMSCA = GoodMSCA;%/max(GoodMSCA);
load Nomax_TrainFeatures_LIVE_JPG2K_s4_d6.mat;
JPG2KMSCA = TrainImg;
JPG2KMSCA = mean(JPG2KMSCA');
JPG2KMSCA = JPG2KMSCA;%/max(JPG2KMSCA);
load Nomax_TrainFeatures_LIVE_JPG_s4_d6.mat;
JPGMSCA = TrainImg;
JPGMSCA = mean(JPGMSCA');
JPGMSCA = JPGMSCA;%/max(JPGMSCA);
load Nomax_TrainFeatures_LIVE_GWN_s4_d6.mat;
GWNMSCA = TrainImg;
GWNMSCA = mean(GWNMSCA');
GWNMSCA = GWNMSCA;%/max(GWNMSCA);
load Nomax_TrainFeatures_LIVE_GB_s4_d6.mat;
GBMSCA = TrainImg;
GBMSCA = mean(GBMSCA');
GBMSCA = GBMSCA;%/max(GBMSCA);
load Nomax_TrainFeatures_LIVE_FF_s4_d6.mat;
FFMSCA = TrainImg;
FFMSCA = mean(FFMSCA');
FFMSCA = FFMSCA;%/max(FFMSCA);
MSCA_all = [GoodMSCA' JPG2KMSCA' JPGMSCA' GWNMSCA' GBMSCA' FFMSCA'];
MSCA_all = log2(MSCA_all+eps);
maxval = ceil(max(max(MSCA_all)));
minval = floor(min(min(MSCA_all)));
plot1 = plot(MSCA_all);
set(plot1(2),'Marker','square');
set(plot1(3),'Marker','o');
set(plot1(4),'Marker','v', 'Color',[0.313725501298904 0.0831373 0.313725501298904]);
set(plot1(5),'MarkerSize',8,'Marker','*');
set(plot1(6),'MarkerSize',10,'Marker','x');
line([6 6],[minval+0.5 maxval-0.5],'LineStyle','--','Color',[0.313725501298904 0.313725501298904 0.313725501298904]);
line([12 12],[minval+0.5 maxval-0.5],'LineStyle','--','Color',[0.313725501298904 0.313725501298904 0.313725501298904]);
line([18 18],[minval+0.5 maxval-0.5],'LineStyle','--','Color',[0.313725501298904 0.313725501298904 0.313725501298904]);
% Create xlabel
xlabel('Number of subbands','FontSize',14,'FontName','times new roman');
% Create ylabel
ylabel('log_2(SSCA)','FontSize',14,'FontName','times new roman');
% Create legend
legend1 = legend('ORI','JPEG2K','JPEG','GWN','GBLUR','FF');
set(legend1,'Location','SouthWest');

