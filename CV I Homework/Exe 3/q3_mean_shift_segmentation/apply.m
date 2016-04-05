function apply_q3
close all;clc;

a = answers();
p = parameters();

disp('Question: Mean-Shift Image Segmentation');

% -------------------------------------------------------------------------
disp('----- Question a -----');

img = imread('terrain_small.png');

figure('Position', [200, 200, 1200, 400]); 

subplot(1, 4, 1);
imshow(img);
title('Original Image');
drawnow;

r = 15;
seg_img = meanshift_segment(img, r);
subplot(1, 4, 2);
imshow(seg_img);
title('Qa: Segmented in RGB');
drawnow;

% -------------------------------------------------------------------------
disp('----- Question b -----');

seg_img_luv = meanshift_segment_luv(img, r);
subplot(1, 4, 3);
imshow(seg_img_luv);
title('Qb: Segmented in LUV');
drawnow;

seg_img_luv_pos = meanshift_segment_luv_pos(img, r);
subplot(1, 4, 4);
imshow(seg_img_luv_pos);
title('Qb: Segmented in LUV with pos');
drawnow;

% -------------------------------------------------------------------------
disp('----- Question c -----');

figure('Position', [200, 200, 1200, 800], 'Name', 'Question c'); 

r = [5, 10, 20];
for ind = 1:numel(r)
	subplot(3, numel(r), ind);
	seg_img = meanshift_segment(img, r(ind));
	imshow(seg_img);
	title(sprintf('Radius %d RGB', r(ind)));
	drawnow;

	subplot(3, numel(r), numel(r) + ind);
	seg_img = meanshift_segment_luv(img, r(ind));
	imshow(seg_img);
	title(sprintf('Radius %d LUV', r(ind)));
	drawnow;

	subplot(3, numel(r), 2 * numel(r) + ind);
	seg_img = meanshift_segment_luv_pos(img, r(ind));
	imshow(seg_img);
	title(sprintf('Radius %d LUV+pos', r(ind)));
	drawnow;
end

disp(a.meanshift_segmentation);

img = imread('sunset.png');
d = dir(p.own_image);
if size(d, 1) == 0 % my_seg_img.png does not exist
	tic;
	r = 15;
	seg_img = meanshift_segment_luv_pos(img, r);
	imwrite(seg_img, p.own_image);
	toc % computation takes 8.8 minutes
else
	seg_img = imread(p.own_image);
end

figure('Position', [200, 200, 800, 400], 'Name', 'Question c: Own image and parameter choice'); 
subplot(1, 2, 1);
imshow(img);
title('Original image');
subplot(1, 2, 2);
imshow(seg_img);
title(sprintf('Radius: 15, method: LUV+pos \nimage size is %dx%d', size(img, 2), size(img, 1)));

end
