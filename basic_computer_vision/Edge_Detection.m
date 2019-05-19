%% CRV_Child'sPlay
% name : Neelu Madan

%% clean up
clear all;
close all;
clc;

%% Gray Scale Image
I = imread('cameraman.tif');

%% Octagon
x = [224 196 128 60 32 60 128 196 224];
y = [128 196 224 196 128 60 32 60 128];
imshow(I);
hold on;
plot(x,y,'rx:','LineWidth',2);
hold off; 

%% Haus vom Nikolaus
figure();
imshow(I);
hold on;
s = [50 200 200 50 125 200 50 50 200];
t = [0 0 150 150 250 150 0 150 0 ];
h = plot(s,t,'r-',s,t,'go')
hold off; 

