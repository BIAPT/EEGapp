function [avg_delta, avg_theta, avg_alpha, avg_beta] = plot_spectrogram_power(S)

% Delta (1-4 Hz): Column 1:7
% Theta (4-8 Hz): Column 8:15
% Alpha (8-13 Hz): Column 16:25
% Beta (13:30 Hz): Column 26:60

delta = S(:,1:7);
avg_delta = mean(delta,2);

theta = S(:,8:15);
avg_theta = mean(theta,2);

alpha = S(:,16:25);
avg_alpha = mean(alpha,2);

beta = S(:,26:60);
avg_beta = mean(beta,2);

% figure; 
% subplot(4,1,1); plot(avg_delta, 'r'); 
% subplot(4,1,2); plot(avg_theta, 'b'), 
% subplot(4,1,3); plot(avg_alpha, 'g'); 
% subplot(4,1,4); plot(avg_beta, 'c'); 
