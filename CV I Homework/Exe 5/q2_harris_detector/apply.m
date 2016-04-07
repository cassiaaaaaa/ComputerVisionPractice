function [] = apply()
close all;clc;

p = parameters();
a = answers();

disp('Question: Harris Detector');

% -------------------------------------------------------------------------
fprintf('\n----- Question a -----\n');

% load an image
img{1} = double(rgb2gray(imread('gantrycrane.png')));

% apply the harris detector
[px, py] = harris(img{1}, 1.6, 1000);
figure('Position', [200, 200, 600, 400], 'Name', 'Question a: Harris detector');
drawpoints(img{1}, px, py);
title('Harris interest points for simga = 1.6 threshold = 1000');

% -------------------------------------------------------------------------
fprintf('\n----- Question b -----\n');

img{2} = double(rgb2gray(imread('graf.png')));

for im_ind = 1:2 % produce this figures for all images
	figure('Position', [200, 200, 800, 600], 'Name', 'Question 1b: Parameter settings for Harris detector');

	% diplay the result for all given combinations of simga and thresh
	plot_ind = 1; 
	for sigma = p.sigmas 
		for thresh = p.thresholds
			[px, py] = harris(img{im_ind}, sigma, thresh);

			subplot(numel(p.sigmas), numel(p.thresholds), plot_ind);
			plot_ind = plot_ind+1;
			drawpoints(img{im_ind}, px, py);
			title(sprintf('sigma = %.2f  thresh = %.2f', sigma, thresh));
			drawnow;
		end
	end
end

disp(a.harris_parameters);

% -------------------------------------------------------------------------
fprintf('\n----- Question c -----\n');

plot_ind = 1;
figure('Position', [200, 200, 800, 600], 'Name', 'Question a: Harris Detector');
for norm = [0 1]
	for scale = p.scales
		subplot(2, numel(p.scales), plot_ind);
		plot_ind = plot_ind + 1;
		fimg = gaussianfilter(img{1}, scale);
		[px, py] = harris(fimg, 1.6, 50, norm);
		drawpoints(fimg, px, py, 'y');
		title(sprintf('Scale %d, scale space normalization: %d\nfound %d points', scale, norm, size(px,1)));
		drawnow;
	end
end

disp( a.harris_scale );
