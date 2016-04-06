function apply_q4
close all;clc;

disp('Question 4: Histogram Representations');

% -------------------------------------------------------------------------
disp('----- Question 4a -----');

filename = 'model/obj100__0.png';
img = double(rgb2gray(imread(filename)));
img1D = reshape(img,size(img,1)*size(img,2),1);

bins = [10 20 40];
figure('Position', [200 200 1200 800],'Name','Question 4a'); 
for ind = 1:numel(bins)
    subplot(2,numel(bins),ind);
    h = hist(img1D,bins(ind));
    bar(h);
    title(sprintf('Matlab hist with %d bins',bins(ind)));
end
for ind = 1:numel(bins)
    subplot(2,numel(bins),numel(bins)+ind);
    h = myhist(filename,bins(ind));
    bar(h);
    title(sprintf('myhist with %d bins',bins(ind)));
end

disp('Compare the histograms for different numbers of bins. Explain your observations.');
disp('### insert your answer here ###');

disp('Do the results look the same? What is the difference?');
disp('### insert your answer here ###');

% -------------------------------------------------------------------------
disp('----- Question 4b -----');

bins = 20;
h1 = myhist2('sunset.png',bins);
h2 = myhist2('terrain.png',bins);

figure('Position', [200 200 1200 800],'Name','Question 4b');

subplot(2,2,1);
imshow(imread('sunset.png'));
subplot(2,2,2);
imshow(imread('terrain.png'));
subplot(2,2,3);
plot_color_histogram(h1);
subplot(2,2,4)
plot_color_histogram(h2);

disp('Which number of bins gives the best impression of the color distribution?');
disp('### insert your answer here ###');

% -------------------------------------------------------------------------
disp('----- Question 4c -----');

fprintf('Euclidean histogram distance\n');

h1 = myhist('model/obj1__0.png',5);
h2 = myhist('model/obj91__0.png',5);
dist1 = hist_dist_euclidean(h1, h2);
fprintf('Distance between %s and %s: %f\n','model/obj1__0.png','model/obj91__0.png',dist1);

h3 = myhist('model/obj94__0.png',5);
dist2 = hist_dist_euclidean(h1, h3);
fprintf('Distance between %s and %s: %f\n','model/obj1__0.png','model/obj94__0.png',dist2);

figure('Position', [200 200 800 600],'Name','Question 4c');
subplot(2,2,1);
imshow(imread('model/obj1__0.png'));
title(sprintf('Euclidean distance: %f\n',dist1));
subplot(2,2,2);
imshow(imread('model/obj91__0.png'));

subplot(2,2,3);
imshow(imread('model/obj1__0.png'));
title(sprintf('Euclidean distance: %f\n',dist2));
subplot(2,2,4);
imshow(imread('model/obj94__0.png'));

disp('Which distance is smaller and why?');
disp('### insert your answer here ###');


% -------------------------------------------------------------------------
disp('----- Question 4d -----');
% other histogram distance functions

fprintf('Image 1: %s, image 2: %s\n', 'model/obj1__0.png', 'model/obj91__0.png');

fprintf('Chi square distance: %f\n', hist_dist_chi(h1, h2));
fprintf('Bhattacharyya distance: %f\n', hist_dist_bhatta(h1, h2));
fprintf('Kullback-Leibler divergence: 1->2: %f\n', hist_dist_kl(h1, h2));
fprintf('Kullback-Leibler divergence: 2->1: %f\n', hist_dist_kl(h2, h1));
fprintf('Jeffreys divergence: %f\n', hist_dist_jeffreys(h1, h2));
fprintf('Histogram intersection (similarity): %f\n', hist_dist_intersection(h1, h2));

fprintf('\nImage 1: %s, image 2: %s\n', 'model/obj1__0.png', 'model/obj94__0.png');

fprintf('Chi square distance: %f\n', hist_dist_chi(h1, h3));
fprintf('Bhattacharyya distance: %f\n', hist_dist_bhatta(h1, h3));
fprintf('Kullback-Leibler divergence: 1->2: %f\n', hist_dist_kl(h1, h3));
fprintf('Kullback-Leibler divergence: 2->1: %f\n', hist_dist_kl(h2, h3));
fprintf('Jeffreys divergence: %f\n', hist_dist_jeffreys(h1, h3));
fprintf('Histogram intersection (similarity): %f\n', hist_dist_intersection(h1, h3));

% -------------------------------------------------------------------------
disp('----- Question 4e -----');

h1_vec = myhist3('model/obj4__0.png',20);
h2_vec = myhist3('model/obj28__0.png',20);
h3_vec = myhist3('model/obj42__0.png',20);

h1 = reshape(h1_vec, 20, 20);
h2 = reshape(h2_vec, 20, 20);
h3 = reshape(h3_vec, 20, 20);

figure( 'Position', [200 200 800 600],'Name','Q4e: Chromatic histogram representation');
subplot(2,3,1);
imagesc(imread('model/obj4__0.png'));
subplot(2,3,2);
imagesc(imread('model/obj28__0.png'));
subplot(2,3,3);
imagesc(imread('model/obj42__0.png'));
subplot(2,3,4);
imagesc(h1); colormap gray; title('obj4');
subplot(2,3,5);
imagesc(h2); colormap gray; title('obj28');
subplot(2,3,6);
imagesc(h3); colormap gray; title('obj42');

disp('Do the histograms look correct? What do they show?');
disp('### insert your answer here ###');


% -------------------------------------------------------------------------
disp('----- Question 4f -----');

h1_vec = myhist4('model/obj4__0.png',20);
h2_vec = myhist4('model/obj28__0.png',20);
h3_vec = myhist4('model/obj42__0.png',20);

h1 = reshape(h1_vec, 20, 20);
h2 = reshape(h2_vec, 20, 20);
h3 = reshape(h3_vec, 20, 20);

figure( 'Position', [200 200 800 600],'Name','Q4f: Histogram of derivatives');
subplot(2,3,1);
imagesc(imread('model/obj4__0.png'));
subplot(2,3,2);
imagesc(imread('model/obj28__0.png'));
subplot(2,3,3);
imagesc(imread('model/obj42__0.png'));
subplot(2,3,4);
imagesc(log(h1)); colormap gray; title('obj4');
subplot(2,3,5);
imagesc(log(h2)); colormap gray; title('obj28');
subplot(2,3,6);
imagesc(log(h3)); colormap gray; title('obj42');

disp('Do the histograms look correct? What do they show?');
disp('### insert your answer here ###');
