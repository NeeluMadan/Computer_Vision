%% CRV_ImagesReadShowWrite
% name : Neelu Madan

%% clean up
clear all;
close all;
clc;

%% Gray Scale Image
a = imread('cameraman.tif');
figure()
imshow(a)

%% RGB Image
rgbImage = imread('peppers.png');
figure()
imshow(rgbImage)
figure()
subplot(221);imshow(rgbImage)
title('original');
redImage = rgbImage(:,:,1);
subplot(222);imshow(redImage)
title('red');
greenImage = rgbImage(:,:,2);
subplot(224);imshow(greenImage)
title('green');
blueImage = rgbImage(:,:,3);
subplot(223);imshow(blueImage)
title('blue');

%% RGB2intensity
figure()
subplot(221);imshow(rgbImage)
title('original');

rbg2Gray = rgb2gray(rgbImage);
subplot(224);imshow(rbg2Gray)
title('rgb2gray');

a_mean = fspecial('average',21);
mean = imfilter(rbg2Gray,a_mean);
subplot(222);imshow(uint8(mean))
title('mean');

median = medfilt2(rbg2Gray);
subplot(223);imshow(uint8(median))
title('median');

%% Saving
imwrite(rbg2Gray,'rbg2gray.png');
imwrite(mean,'mean.png');
imwrite(median,'median.png');



