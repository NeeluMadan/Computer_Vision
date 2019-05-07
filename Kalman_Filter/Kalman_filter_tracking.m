%% CRV_WS1718_27_ImageSequenceAnalysisKalman
% name : Neelu Madan
% student number : 3063085

%% clean up
clear all;
close all;
clc;

%% Select sequence
imgSeqDir = ['5', filesep];
imgSeqN = length(dir(imgSeqDir))-2;

%% Create matrix for measurements
m = zeros(2,imgSeqN);

%% Load pattern
pattern = imread('pattern.png');
[mPattern,nPattern] = size(pattern);

%% matrices
phi = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
H = [1 0 0 0; 0 1 0 0];
Q = 10.^-6 * [100 1 1 1; 1 100 1 1; 1 1 100 1; 1 1 1 100];
%R = 10.^-3 * [500 1; 1 500];
Ck_predicted_prev = 10.^-6 * [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
Sk_predicted_prev = [1470;700;0;0];

%% Compute final curves for further images

f = figure();

state_est_x=zeros(1,length(imgSeqN));
state_est_y=zeros(1,length(imgSeqN));
for k= 1:imgSeqN
    % Load image
    I = rgb2gray(imread([imgSeqDir,'image_',int2str(k),'.png']));
    
    % Pattern matching and measurements
    c = normxcorr2(pattern,I);
    [ypeak, xpeak] = find(c==max(c(:)));
    m(:,k) = ([xpeak, ypeak] - [mPattern,nPattern]/2)';
    
    if c(ypeak, xpeak) < 0.6000
        R = 10.^-3 * [50000 1; 1 50000];
    else 
        R = 10.^-3 * [500 1; 1 500];
    end

    % Visualization
    figure(f);
    imshow(I);
    hold on;
    plot(m(1,1:k),m(2,1:k),'rx','MarkerSize',15,'LineWidth',3);
    hold off;
    
    if k>1
        % prediction of state (by name of variables are been in interchanged by mistake)
        Ck_Estimated = phi*Ck_predicted_prev*phi' + Q;
        Sk_Estimated = phi*Sk_predicted_prev;
        
        % Correction of predicted state
        gain = Ck_Estimated*H'*pinv(H*Ck_Estimated*H'+R);
        Ck_predicted = (eye(4,4)-gain*H)*Ck_Estimated*(eye(4,4)-gain*H)' + gain*R*gain';
        Ck_predicted_prev = Ck_predicted;
        Sk_predicted = Sk_Estimated + gain*(m(:,k)-H*phi*Sk_predicted_prev);
        Sk_predicted_prev = Sk_predicted;
        state_est_x(k)=Sk_predicted(1);
        state_est_y(k)=Sk_predicted(2);
        % Visualization
        hold on;
        plot(state_est_x(1:k),state_est_y(1:k),'b.','MarkerSize',15);
        hold off;
    end
    
    title(['Max. correlation: ',num2str(c(ypeak, xpeak))]);
    drawnow;
    pause(0.001);
end

%% Observations
% kalman filter works well even with the partian occlusion wheareas the
% pattern matchin fails
% effect of chosing initial state: more clore we are to the initial point
% more accurate is the prediction of Kalman filter
