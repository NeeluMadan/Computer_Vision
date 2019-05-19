%% CRV_WS1718_10_MyActiveContour
% name : Neelu Madan

function [ x, y ] = MyActiveContour( I, X0, Y0, N, SIGMA )
%MYACTIVECONTOUR performs simple contour extraction
%   [ x, y ] = MyActiveContour( I, x0, y0, N, sigma ) extracts the boundary
%   of a object. I is a intensity image. x0 and y0 are column vectors
%   containing the coordinates of the initial curves vertices. The last
%   vertex has to equal the first one. N defines the number of iteration. A
%   gaussian blur with variance sigma is applied on the image first.
Iblur = imgaussfilt(I,SIGMA);
[Gmag, Gdir] = imgradient(Iblur,'sobel');
Eima=1./Gmag;
format long;
Eima(isinf(Eima))=10000;
%Eimage = Eima

vertices=size(X0);
noOfVert=vertices(1);
x=X0, y=Y0;

for i=1:(noOfVert-1)
    Dx(i)=X0(i+1)-X0(i);
    Dx(i)=Dx(i)/abs(Dx(i));
    Dy(i)=Y0(i+1)-Y0(i);
    Dy(i)=Dy(i)/abs(Dy(i));
end
       
for j=1:N
    for k=1:(noOfVert-1)      
        if( (~isnan(Dx(k)))  && Eima((x(k)+Dx(k)),y(k)) <= Eima(x(k),y(k)))
            x(k)=x(k)+Dx(k);
        else
            x(k)=x(k);
        end
        if( (~isnan(Dy(k))) && Eima(x(k),y(k)+Dy(k)) <= Eima(x(k),y(k)))
            y(k)=y(k)+Dy(k);
        else
            y(k)=y(k);
        end
    end
end
