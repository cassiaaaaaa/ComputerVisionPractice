function [] = apply()
close all;clc;

a = answers();

disp('Question: Gaussian Filtering');

% -------------------------------------------------------------------------
disp('----- Question a -----');

figure; plot( gauss(-100:100, 25) );
title('Gaussian bell curve');

% -------------------------------------------------------------------------
disp('----- Question b -----');
graf = im2double(rgb2gray(imread('graf.png')));

figure('Position', [200, 200, 800, 800]);
subplot(4, 3, 1);
imshow(graf);
title('original image');

disp('--- Own filter ---');
tic
graf_own_2 = gaussianfilter(graf, 2);
graf_own_4 = gaussianfilter(graf, 4);
graf_own_8 = gaussianfilter(graf, 8);
toc

subplot(4, 3, 4);
imshow(graf_own_2);
title('own filter: sigma = 2');

subplot(4, 3, 5);
imshow(graf_own_4);
title('own filter: sigma = 4');

subplot(4, 3, 6);
imshow(graf_own_8);
title('own filter: sigma = 8');

disp('--- Matlab''s filter ---');
tic
sigma = 2.0;
fsize = round(3.0 * sigma) * 2 + 1;
f = fspecial('gaussian', fsize, sigma);
graf_matlab_2 = imfilter(graf, f);

sigma = 4.0;
fsize = round(3.0 * sigma) * 2 + 1;
f = fspecial('gaussian', fsize, sigma);
graf_matlab_4 = imfilter(graf, f);

sigma = 8.0;
fsize = round(3.0 * sigma) * 2 + 1;
f = fspecial('gaussian', fsize, sigma);
graf_matlab_8 = imfilter(graf, f);
toc

subplot(4, 3, 7);
imshow(graf_matlab_2);
title('matlab''s filter: sigma = 2');

subplot(4, 3, 8);
imshow(graf_matlab_4);
title('matlab''s filter: sigma = 4');

subplot(4,3,9);
imshow(graf_matlab_8);
title('matlab''s filter: sigma = 8');

disp('--- Difference images ---');
diff2 = graf_matlab_2-graf_own_2;
diff4 = graf_matlab_4-graf_own_4;
diff8 = graf_matlab_8-graf_own_8;

subplot(4, 3, 10);
imshow(diff2);
title(sprintf('difference image (max is %.2f)', max(diff2(:))));

subplot(4, 3, 11);
imshow(diff4);
title(sprintf('difference image (max is %.2f)',max(diff4(:))));

subplot(4, 3, 12);
imshow(diff8);
title(sprintf('difference image (max is %.2f)',max(diff8(:))));

disp(a.own_implementation);
