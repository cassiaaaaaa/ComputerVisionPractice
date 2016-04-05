function [] = apply_q4()
close all;clc;

% load image and show boxes
figure(1)
subplot(2,2,1)
hold on
lotus = imread('lotus320.jpg');
[h,w,~] = size(lotus);
d_lotus = 256*im2double(lotus);
imshow(lotus);
title('input image');
foreground_box = [157,99,125,99];
background_box = [1,1,90,111];
rectangle('Position', foreground_box, 'Linewidth', 2, 'EdgeColor', 'r');
rectangle('Position', background_box, 'Linewidth', 2, 'EdgeColor', 'r');
hold off

% reformat boxes to masks
foreground = zeros(h,w);
foreground(foreground_box(2):(foreground_box(2) + foreground_box(4)), ...
	foreground_box(1):(foreground_box(1) + foreground_box(3))) = 1;
background = zeros(h,w);
background(background_box(2):(background_box(2) + background_box(4)), ...
	background_box(1):(background_box(1) + background_box(3))) = 1;

% compute histograms
n_bins = 16;
figure(2)
fg_histogram = calculate_histogram(d_lotus,foreground, n_bins);
subplot(3,2,1)
bar(sum(sum(fg_histogram,3),2));
title('red (foreground)');
subplot(3,2,3)
bar(sum(sum(fg_histogram,3),1));
title('green (foreground)');
subplot(3,2,5)
bar(sum(squeeze(sum(fg_histogram,2)),1));
title('blue (foreground)');

bg_histogram = calculate_histogram(d_lotus,background, n_bins);
subplot(3,2,2)
bar(sum(sum(bg_histogram,3),2));
title('red (background)');
subplot(3,2,4)
bar(sum(sum(bg_histogram,3),1));
title('green (background)');
subplot(3,2,6)
bar(sum(squeeze(sum(bg_histogram,2)),1));
title('blue (background)');

%%%%%%%%
disp('What do you see in these histograms?');
%%%%%%%%

% create foreground map
foreground_probability = foreground_pmap(d_lotus, fg_histogram, bg_histogram);
figure(1)
subplot(2,2,2)
imagesc(foreground_probability);
title('foreground probability');
colormap('gray');
foreground_map = foreground_probability > 0.5;

% unary and pairwise potentials
unary_weight = 1;
pairwise_weight = 1;
unary_fg = unary_potentials(foreground_probability, unary_weight);
unary_bg = unary_potentials(1 - foreground_probability, unary_weight);
subplot(2,2,3)
imagesc(unary_fg);
title('unary potential (foreground)');
colormap('gray');
subplot(2,2,4)
imagesc(unary_bg);
title('unary potential (background)');
colormap('gray');
unary = single(...
	[ reshape(unary_fg, 1, numel(unary_fg));...
	  reshape(unary_bg, 1, numel(unary_bg))] ...
);
pairwise = pairwise_potential_prefactor_matrix(d_lotus, pairwise_weight);

% optimize
[labels, energy, energyafter] = ...
	GCMex( ...
		double(reshape(foreground_map,1,numel(foreground_map))),...
		unary, ...
		pairwise, ...
		single(cost_mat(2)), ...
		0);

%%%%%
disp('Why is the segmentation the way it is?');
%%%%%

% show resulting labeling
final_labeling = reshape(labels,h,w);
figure(3)
subplot(2,2,1)
imagesc(final_labeling);
subplot(2,2,3)
mask = zeros(h,w,3);
mask(:,:,1) = final_labeling;
mask(:,:,2) = final_labeling;
mask(:,:,3) = final_labeling;
disp_lotus = d_lotus/256;
imagesc(mask.*disp_lotus);
subplot(2,2,4)
imagesc((1-mask).*disp_lotus);
colormap('gray');


%%%%%
disp('What does change when using the contrast sensitive Potts model?');
%%%%%

% iterate the segmentation
n_iter = 20;
iterated_labeling = iterate_opt(d_lotus, 1-final_labeling, n_bins, unary_weight, pairwise, n_iter);

figure(4)
subplot(2,2,1)
imagesc(iterated_labeling);
title('image after iterations');
subplot(2,2,3)
mask = zeros(h,w,3);
mask(:,:,1) = iterated_labeling;
mask(:,:,2) = iterated_labeling;
mask(:,:,3) = iterated_labeling;
imagesc(mask.*disp_lotus);
subplot(2,2,4)
imagesc((1-mask).*disp_lotus);
colormap('gray');

%%%%%
disp('Explain how the labeling changes and why.');
%%%%%

end
