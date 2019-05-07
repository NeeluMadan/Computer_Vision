%% MyHoughTesting

%% Init
clear all;
close all;
clc;

%% Create edge image
edgeImage = zeros(100); 
edgeImage(30,:) = round(rand(100,1)); 
edgeImage(60,:) = round(rand(100,1)); 

%% Hough transform
[akku, h, alpha] = MyHough(edgeImage);

%% Visualization
figure();
subplot(121);
imshow(edgeImage);
title('edge image');
subplot(122);
imshow(akku,[]); % ,[] enables automatic scaling
axis square;
title('hough image');