function [ akku, h, alpha ] = MyHough( edgeImage )
%MYHOUGH detects straight lines vie Hough transform
%   [ akku, h, alpha ] = MyHough( edgeImage ) calculates the Hough
%   transform of the binary edgeImage. The hough image is contained in
%   akku. h is a vector containing the distance values. With D being the
%   diagonal length of the edgeImage, the values in h range from -D to D.
%   alpha contains the angle values in degree. These range from -90 to 89.

