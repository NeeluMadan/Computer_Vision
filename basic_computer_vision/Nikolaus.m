%% CRV_EdgeDetection
%% clean up
clear all;
close all;
clc;

%% Gray-scale image
a = imread('cameraman.tif');
image = im2single(a);
figure()
subplot(321);imshow(image)
title('Original');

%% SimpleDerivation
fopx = [-1 0 1]
fopy = fopx'
eHGrad = imfilter(image,fopx);
eVGrad = imfilter(image,fopy);
MoG = sqrt(eHGrad.^2 + eVGrad.^2);
subplot(322);imshow(eHGrad)
title('X-grad');
subplot(323);imshow(eVGrad)
title('y-grad');

threshold(MoG,0.5)
subplot(324);imshow(MoG)
title('threshold : 0.5');

threshold(MoG,1.5)
subplot(325);imshow(MoG)
title('threshold : 1.5');

%% Prewitt Operator
Gx = [1 +1 +1; 0 0 0; -1 -1 -1]; Gy = Gx';
eHGradP = imfilter(image,Gx);
eVGradP = imfilter(image,Gy);
imgPrewitt = sqrt(eHGradP.^2 + eVGradP.^2);
threshold(imgPrewitt,0.5)
figure()
subplot(321);imshow(image)
title('Original');
subplot(322);imshow(eHGradP)
title('X-grad');
subplot(323);imshow(eVGradP)
title('y-grad');
subplot(324);imshow(imgPrewitt)
title('(Prewitt) threshold : 0.5');

threshold(imgPrewitt,1.5)
subplot(325);imshow(imgPrewitt)
title('(Prewitt) threshold : 1.5');


%% Sobel Operator
Gx = [1 +2 +1; 0 0 0; -1 -2 -1]; Gy = Gx';
eHGradS = imfilter(image,Gx);
eVGradS = imfilter(image,Gy);
imgSobel = sqrt(eHGradS.^2 + eVGradS.^2);
threshold(imgSobel,0.5)
figure()
subplot(321);imshow(image)
title('Original');
subplot(322);imshow(eHGradS)
title('X-grad');
subplot(323);imshow(eVGradS)
title('y-grad');
subplot(324);imshow(imgSobel)
title('(Sobel) threshold : 0.5');

threshold(imgSobel,1.2)
subplot(325);imshow(imgSobel)
title('(Sobel) threshold : 1.2');

%% Edge
edgeSobel = edge(image,'Sobel');
edgePrewitt = edge(image,'Prewitt');
edgeCanny = edge(image,'Canny');
figure()
subplot(221);imshow(image)
title('Original');
subplot(222);imshow(edgeSobel)
title('Sobel: edge detection');
subplot(223);imshow(edgePrewitt)
title('Prewitt: edge detection');
subplot(224);imshow(edgeCanny)
title('Canny: edge detection');

function threshold( MoG,value )
for row = 1 : 256
  for column = 1 : 256  
      if(MoG(row,column) > value)
          MoG(row,column)=1;
      else
           MoG(row,column)=0;
      end
end
end
end
