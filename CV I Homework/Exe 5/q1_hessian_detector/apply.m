function [] = apply()
close all;clc;

p = parameters();
a = answers();

disp('Question: Hessian Detector');

% -------------------------------------------------------------------------
fprintf('\n----- Question a -----\n');

% load an image
img{1} = double(rgb2gray(imread('gantrycrane.png')));

% apply the hessian detector
[px py] = hessian(img{1}, 1.0, 50);
figure('Position', [200, 200, 600, 400], 'Name', '(a): Hessian detector');
drawpoints(img{1}, px, py);
title('Hessian interest points for simga=1.0 threshold=50');

% -------------------------------------------------------------------------
fprintf('\n----- Question b -----\n');

img{2} = double(rgb2gray(imread('graf.png')));


for im_ind = 1:2 % produce this figures for all images
	figure('Position', [200, 200, 800, 600], 'Name', '(b): Parameter settings for Hessian detector');

	% diplay the result for all given combinations of simga and thresh
	plot_ind = 1; 
	for sigma = p.sigmas 
		for thresh = p.threshs
			[px, py] = hessian(img{im_ind}, sigma, thresh);

			subplot(numel(p.sigmas), numel(p.threshs), plot_ind);
			plot_ind = plot_ind+1;
			drawpoints(img{im_ind}, px, py);
			title(sprintf('sigma = %.2f  thresh = %.2f', sigma, thresh));
			drawnow;
		end
	end
end

disp( a.hessian_detector_parameters );
