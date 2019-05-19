%% CRV_Smoothing , noise and denoising
% name : Neelu Madan

%% clean up
clear all;
close all;
clc;

%% Gray-scale image
origPic = imread('cameraman.tif');
figure();
subplot(131);imshow(origPic)
title('original')

A = pascalsTriangle(3);
V = A(3,:);
V = V/norm(V);
gaussFiltFromPT = V.*V'
filteredImgFromPT = imfilter(origPic,gaussFiltFromPT);
subplot(132);imshow(filteredImgFromPT)
title('GFFromPascal')

gauss = fspecial('gaussian',3,1)
filteredImg = imfilter(origPic,gauss);
subplot(133);imshow(filteredImg)
title('GFUsingFspecial')

%% Gaussian noise
noisePic = imnoise(origPic,'gaussian',0.01);
figure();
subplot(221);imshow(origPic)
title('Original Picture')
subplot(222);imshow(noisePic)
title('Noisy Picture')
smoothenedOrigImg = imgaussfilt(origPic);
subplot(223);imshow(smoothenedOrigImg)
title('Smoothened Original Image')
smoothenedNoisyImg = imgaussfilt(noisePic);
subplot(224);imshow(smoothenedNoisyImg)
title('Smoothened Noisy Image')


%% Impulse Noise
impulseNoise = imnoise(origPic,'salt & pepper',0.01);
figure();
subplot(321);imshow(origPic)
title('Original Picture')
subplot(323);imshow(impulseNoise)
title('Impluse Noise')
smoothenedOrigImg = imgaussfilt(origPic);
subplot(322);imshow(smoothenedOrigImg)
title('Smoothened Original Image')
impulseNoise = imgaussfilt(noisePic);
subplot(324);imshow(impulseNoise)
title('Smoothened Impulse Noise')

remNoise = medfilt2(impulseNoise);
subplot(326);imshow(impulseNoise)
title('Smooth with Median Filter')

%% function to create pascal triangle
function P = pascalsTriangle(N)
  % generate a matrix having ones in its diagonal and first column
  P = eye(N);
  P(:, 1) = 1;
  
  % loop through the items and summarize the elements above them
  for j = 3 : N
    for i = 2 : N - 1
      P(j, i) = P(j - 1, i - 1) + P(j - 1, i);
    end
  end
end