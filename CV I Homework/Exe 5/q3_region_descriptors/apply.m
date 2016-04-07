function [] = apply()
close all;clc;

p = parameters();
a = answers();

disp('Question: Region Descriptors');

% -------------------------------------------------------------------------
fprintf('\n----- Question a -----\n');

imgrgb{1} = imread('graff5/img1.png');
imgrgb{2} = imread('graff5/img2.png');
img{1} = double(rgb2gray(imgrgb{1}));
img{2} = double(rgb2gray(imgrgb{2}));

load('ip_graff.mat');
px{1} = px1;
py{1} = py1;
px{2} = px2;
py{2} = py2; 

figure('Position', [200, 200, 1000, 400], 'Name', 'Question a - descriptors_rg');
plot_ind = 1;
for im_ind = 1:2
	subplot(2, 4, plot_ind);
	im_plot_ind = plot_ind;
	plot_ind = plot_ind + 1;
	drawpoints(img{im_ind}, px1, py1);
	title('Harris points');
	for ip_ind = [100, 200, 300]
		subplot(2, 4, im_plot_ind); 
		hold on;
		plot(px{im_ind}(ip_ind), py{im_ind}(ip_ind), 'r+');

		Drg = descriptors_rg(imgrgb{im_ind}, px{im_ind}(ip_ind), py{im_ind}(ip_ind), p.windowsize, p.bins);
		subplot(2, 4, plot_ind);
		plot_ind = plot_ind + 1;
		bar(Drg);
	end
end

figure('Position', [200, 200, 1000, 400], 'Name', 'Question a - descriptors_dxdy');
plot_ind = 1;
for im_ind = 1:2
	subplot(2, 4, plot_ind);
	im_plot_ind = plot_ind;
	plot_ind = plot_ind + 1;
	drawpoints(img{im_ind}, px1, py1);
	title('Harris points');
	for ip_ind = [100 200 300]
		subplot(2, 4, im_plot_ind); 
		hold on;
		plot(px{im_ind}(ip_ind), py{im_ind}(ip_ind), 'r+');

		Ddxdy1 = descriptors_dxdy(img{im_ind}, px{im_ind}(ip_ind), py{im_ind}(ip_ind), p.windowsize, p.sigma, p.bins);
		subplot(2, 4, plot_ind);
		plot_ind = plot_ind + 1;
		bar(Ddxdy1);
	end
end

disp(a.descriptors);

% -------------------------------------------------------------------------
fprintf('\n----- Question b -----\n');

figure('Position', [200, 200, 1000, 400], 'Name', 'Question b - descriptors_maglap');
plot_ind = 1;
for im_ind = 1:2
	subplot(2, 4, plot_ind);
	im_plot_ind = plot_ind;
	plot_ind = plot_ind + 1;
	drawpoints(img{im_ind}, px1, py1);
	title('Harris points');
	for ip_ind = [100 200 300]
		subplot(2, 4, im_plot_ind); 
		hold on;
		plot(px{im_ind}(ip_ind), py{im_ind}(ip_ind), 'r+');

		Dmaglap = descriptors_maglap(img{im_ind}, px{im_ind}(ip_ind), py{im_ind}(ip_ind), p.windowsize, p.sigma, p.bins);
		subplot(2, 4, plot_ind);
		plot_ind = plot_ind + 1;
		bar(Dmaglap);
	end
end

disp(a.maglap);

% -------------------------------------------------------------------------
fprintf('\n----- Question c -----\n');


Drg1 = descriptors_rg(imgrgb{1}, px{1}, py{1}, p.windowsize, p.bins);
Drg2 = descriptors_rg(imgrgb{2}, px{2}, py{2}, p.windowsize, p.bins);

figure('Position', [200, 200, 1000, 400], 'Name', 'Question c - nearest neighbor');

% display histograms of best matches
tic
disp('Finding nearest neighbor with euclidean distance');
[Idx1, Dist1] = findnn(Drg1, Drg2);
toc

[m1, midx1] = min(Dist1);
subplot(2, 2, 1);
bar(Drg1(midx1, :));
title(sprintf('interest point %d in img1', midx1));

subplot(2, 2, 2);
bar(Drg2(Idx1(midx1), :));
title(sprintf('nearest neighbor: point %d, euclidean distance %.4f', Idx1(midx1), m1));
drawnow;

tic
disp('Finding nearest neighbor with chi^2 distance');
[Idx2, Dist2] = findnn_chi2(Drg1, Drg2);
toc

[m2,midx2] = min(Dist2);
subplot(2, 2, 3);
bar(Drg1(midx2, :));
title(sprintf('interest point %d in img1', midx2));

subplot(2, 2, 4);
bar(Drg2(Idx2(midx2), :));
title(sprintf('nearest neighbor: point %d, chi^2 distance %.4f', Idx2(midx2), m2));
drawnow;

disp(a.histogram_similarity);
