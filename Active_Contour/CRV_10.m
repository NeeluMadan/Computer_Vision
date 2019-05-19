%% CRV_WS1718_10_MyActiveContour
% name : Neelu Madan

%% Init
clear all;
close all;
clc;

%% Test1
I1=imread('TestImages/Test1.png');
x1 = [116 46 89 211 509 713 741 696 519 298 116]';
y1 = [193 464 728 909 936 726 500 244 140 82 193];
[ x, y ] = MyActiveContour( I1, x1, y1, 50, 0.7 )
figure();
subplot(121);imshow(I1)
title('Initial Curve')
hold on;
h1 = plot(y1,x1,'r-',y1,x1,'go');
hold off;
subplot(122);imshow(I1)
title('Final Curve')
hold on;
h1 = plot(y,x,'r-',y,x,'go');
hold off;

%% Test2
I2=imread('TestImages/Test2.png');
x2 = [119 100 816 851 119];
y2 = [248 918 923 74 248]';
[ x_2, y_2 ] = MyActiveContour( I2, x2, y2, 100, 0.9 )
figure();
subplot(121);imshow(I2)
title('Initial Curve')
hold on;
h2 = plot(y2,x2,'r-',y2,x2,'go');
hold off;
subplot(122);imshow(I2)
title('Final Curve')
hold on;
h2 = plot(y_2,x_2,'r-',y_2,x_2,'go');
hold off;

%% Test3
I3=imread('TestImages/Test3.png');
% imshow(I3);
% [x, y, BW, r, c] = roipoly(I3);
x3 = [388 169 143 374 666 704 388];
y3 = [130 310 708 975 735 307 130]';
[ x, y] = MyActiveContour( I3, x3, y3, 50, 0.1 )
figure();
subplot(121);imshow(I3)
title('Initial Curve')
hold on;
h3 = plot(y3,x3,'r-',y3,x3,'go');
hold off;
subplot(122);imshow(I3)
title('Final Curve')
hold on;
h3 = plot(y,x,'r-',y,x,'go');
hold off;

%% Coins
I4=imread('coins.png');
x4 = [74 97 117 147 171 165 145 116 103 86 70 74];
y4 = [154 148 134 143 148 171 202 216 208 181 174 154]';
[ x_4, y_4] = MyActiveContour( I4, x4, y4, 50, 0.1 )
figure();
subplot(121);imshow(I4)
title('Initial Curve')
hold on;
h4 = plot(y4,x4,'r-',y4,x4,'go');
hold off;
subplot(122);imshow(I4)
title('Final Curve')
hold on;
h4 = plot(y_4,x_4,'r-',y_4,x_4,'go');
hold off;
