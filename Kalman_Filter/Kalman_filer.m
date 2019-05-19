%% CRV_KalmanFilterParabola
% name : Neelu Madan

%% clean up
clear all;
close all;
clc;

%% estimation with aplha = -0.34
alpha1 = -0.34;
kalman_filter(alpha1)

%% estimation with aplha = -0.05
alpha2 = -0.05;
kalman_filter(alpha2)

function kalman_filter(alpha)
a = alpha;
b = 22;
c = 150;
x = linspace(1,40,400);
y = a*(x - b).^2 + c;
figure;
plot(x,y);
A = [x;y];

phi = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
H = [1 0 0 0; 0 1 0 0];
Q = 10.^-6 * [100 1 1 1; 1 100 1 1; 1 1 100 1; 1 1 1 100];
R = 10.^-3 * [500 1; 1 500];
Ck_predicted_prev = 10.^-9 * [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
Sk_predicted_prev = [0;0;0;0];

for i = 1:length(x) 
chol_m = chol(R)'*randn(2,1);
x_noisy(i) = x(i) + chol_m(1);
y_noisy(i) = y(i) + chol_m(2);
end
hold on;
plot(x_noisy,y_noisy,'r.');
hold off;

y_recovered=zeros(1,length(x_noisy));
x_recovered=zeros(1,length(x_noisy));
for i = 1:length(x_noisy)
Ck_Estimated = phi*Ck_predicted_prev*phi' + Q;
gain = Ck_Estimated*H'*pinv(H*Ck_Estimated*H'+R);
Ck_predicted = (eye(4,4)-gain*H)*Ck_Estimated*(eye(4,4)-gain*H)' + gain*R*gain';
Ck_predicted_prev=Ck_predicted;
Sk_Estimated = phi*Sk_predicted_prev;
Sk_predicted = Sk_Estimated + gain*([x_noisy(i);y_noisy(i)]-H*phi*Sk_predicted_prev);
Sk_predicted_prev = Sk_predicted;
x_recovered(i)=Sk_predicted(1);
y_recovered(i)=Sk_predicted(2);
end
hold on;
plot(x_recovered,y_recovered,'g.');
hold off;
title(['Kalman approximation with Alpha: ', num2str(alpha)]);
legend('true position','measured position','estimated position');

end