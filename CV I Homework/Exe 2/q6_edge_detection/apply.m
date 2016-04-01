function [] = apply()
close all;clc;

a = answers();

disp('Question: Edge Detection');

% -------------------------------------------------------------------------
disp('----- Question a -----');

gantry = double(rgb2gray(imread('gantrycrane.png')));

sigma = 1.0;
figure('Position', [200, 400, 800, 600]);
ind = 1;
for theta = [1:10 20:10:100]
	subplot(4, 5, ind);
	ind = ind + 1;
	imagesc(getedges(gantry, sigma, theta));
	colormap gray;
	axis off;
	thetaval = sprintf('sigma: %d theta: %d', sigma, theta);
	title(thetaval);
end

sigma = 2.0;
figure('Position', [200, 400, 800, 600]);
ind = 1;
for theta = [1:10 20:10:100]
	subplot(4, 5, ind);
	ind = ind + 1;
	imagesc(getedges(gantry, sigma, theta));
	colormap gray;
	axis off;
	thetaval = sprintf('sigma: %d theta: %d', sigma, theta);
	title(thetaval);
end

disp(a.difficulties_sigma_theta);

% -------------------------------------------------------------------------
disp('----- Question b -----');

sigma = 2;
theta = 10;
edgeimage1 = getedges(gantry, sigma, theta);

sigma = 2;
theta = 0.17; % 0.17 corresponds to an absolute threshold of 10
edgeimage2 = getedges2(gantry, sigma, theta);

figure('Position', [200, 600, 800, 400]);

subplot(1, 2, 1);
imagesc(edgeimage1);
colormap gray;
axis off;
title('getedges');

subplot(1, 2, 2);
imagesc(edgeimage2);
colormap gray;
axis off;
title('getedges2');

disp(a.nms);

% -------------------------------------------------------------------------
disp('----- Question c -----');

figure('Position', [200, 600, 800, 400]);
subplot(1, 2, 1);
sigma = 2.0;
theta_low = 0.1;
theta_high = 0.3;
imagesc(my_canny(gantry, sigma, theta_low, theta_high));
colormap gray;
title('My Canny');

subplot(1, 2, 2);
imagesc(edge(gantry,'canny',[theta_low, theta_high], sigma));
colormap gray;
title('Matlab Canny');

disp(a.hysteresis);
