clc;clear;close all;
tic
load('stereoParams.mat');
I1 = imread('left\10img_0156.jpg');
I2 = imread('right\10img_0156.jpg');
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);
disparityMap=disparity(rgb2gray(J1),rgb2gray(J2), 'BlockSize', 15,... 
'DisparityRange', [0 128], 'Method','SemiGlobal'); 
figure; 
imshow(disparityMap,[0 128]);
colormap('jet');
colorbar;
title('Disparity Map');
points3D=reconstructScene(disparityMap,stereoParams);
ptCloud_O=pointCloud(points3D,'Color',J1);
ptCloud=removeInvalidPoints(ptCloud_O);
ptCloudOut=pcdownsample(ptCloud, 'nonuniformGridSample',100);
gauss = gmdistribution.fit(ptCloudOut.Location,10,'CovType','Diagonal','Regularize', 1e-3);
[cidx, ctrs] = cluster(gauss,ptCloudOut.Location);
toc
% figure; imshow(disparityMap, [0 128]);colormap('jet');
player3D1 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D1, ptCloudOut.Location(cidx==1,1:3));

player3D2 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D2, ptCloudOut.Location(cidx==2,1:3));

player3D3 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D3, ptCloudOut.Location(cidx==3,1:3));

player3D4 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D4, ptCloudOut.Location(cidx==4,1:3));

player3D5 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D5, ptCloudOut.Location(cidx==5,1:3));

player3D6 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D6, ptCloudOut.Location(cidx==6,1:3));

player3D7 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D7, ptCloudOut.Location(cidx==7,1:3));

player3D8 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D8, ptCloudOut.Location(cidx==8,1:3));

player3D9 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D9, ptCloudOut.Location(cidx==9,1:3));

player3D10 = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D10, ptCloudOut.Location(cidx==10,1:3));

player3D = pcplayer([-400, 400], [-300, 300], [200, 800]);
view(player3D,ptCloud_O);

% ptCloudOutA= pointCloud(ptCloudOut.Location(cidx==1,1:3));
% ptCloudOutB=pcdenoise(ptCloudOutA,'Threshold',0.01);
% pcshow(ptCloudOutB);