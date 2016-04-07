function [] = apply()
close all;clc;

disp('Question: Matching');

p = parameters();
a = answers();

% -------------------------------------------------------------------------
fprintf('\n----- Question a -----\n');

% load two example images
img1rgb = imread('graff5/img1.png');
img2rgb = imread('graff5/img2.png');
img1 = double(rgb2gray(img1rgb));
img2 = double(rgb2gray(img2rgb));

% compute Harris interest points
[px1, py1] = harris(img1, 2.0, 100000);
fprintf('img1: found %d interest points\n', size(px1, 1));
[px2, py2] = harris(img2, 2.0, 100000);
fprintf('img2: found %d interest points\n', size(px2, 1));

% compute the color descriptors
D1 = descriptors_rg(img1rgb, px1, py1, p.windowsize, p.bins );
D2 = descriptors_rg(img2rgb, px2, py2, p.windowsize, p.bins );

% find the best matches and sort them according to their scores
disp('Matches found with descriptors_rg and euclidean distance:');
figure('Position', [200, 200, 1000, 400], 'Name', 'Question a - Matches found with descriptors_rg and euclidean distance');
[Idx, Dist] = findnn(D1, D2);
displaymatches(img1, px1, py1, img2, px2, py2, Idx, Dist, 10);

disp('Matches found with descriptors_rg and chi^2 distance:');
figure('Position', [200, 200, 1000, 400], 'Name', 'Question a - Matches found with descriptors_rg and chi^2 distance');
[Idx2, Dist2] = findnn_chi2(D1, D2);
displaymatches(img1, px1, py1, img2, px2, py2, Idx2, Dist2, 10);

disp(a.color_descriptors);

% -------------------------------------------------------------------------
fprintf('\n----- Question b -----\n');

% compute the dxdy descriptors
D1 = descriptors_dxdy(img1, px1, py1, p.windowsize, p.sigma, p.bins );
D2 = descriptors_dxdy(img2, px2, py2, p.windowsize, p.sigma, p.bins );

% find the best matches and sort them according to their scores
disp('Matches found with descriptors_dxdy and euclidean distance:');
figure('Position', [200, 200, 1000, 400], 'Name', 'Question a - Matches found with descriptors_dxdy and euclidean distance');
[Idx, Dist] = findnn(D1, D2);
displaymatches(img1, px1, py1, img2, px2, py2, Idx, Dist, 10);

disp('Matches found with descriptors_dxdy and chi^2 distance:');
figure('Position', [200, 200, 1000, 400], 'Name', 'Question a - Matches found with descriptors_dxdy and chi^2 distance');
[Idx2, Dist2] = findnn_chi2(D1, D2);
displaymatches(img1, px1, py1, img2, px2, py2, Idx2, Dist2, 10);

disp(a.hessian_descriptor);

% -------------------------------------------------------------------------
fprintf('\n----- Question c -----\n');

img1 = double(imread('NewYork/im1.png'));
img2 = double(imread('NewYork/im5.png'));
H = load('NewYork/H1to5');

h = hom_gui_H(uint8(img1), uint8(img2), H);

disp(a.homographies);

% -------------------------------------------------------------------------
fprintf('\n----- Question d -----\n');

% load two example images
img1 = double(imread('NewYork/im1.png'));
img2 = double(imread('NewYork/im5.png'));

% compute Hessian interest points
[px1, py1] = hessian(img1, 2.0, 50);
fprintf('img1: found %d interest points\n', size(px1, 1));
[px2, py2] = hessian(img2, 2.0, 50);
fprintf('img2: found %d interest points\n', size(px2, 1));

% compute the dx/dy descriptors
D1 = descriptors_dxdy(img1, px1, py1, 41, 2.0, 16);
D2 = descriptors_dxdy(img2, px2, py2, 41, 2.0, 16);

% find the best matches and sort them according to their scores
[Idx, Dist] = findnn_chi2(D1, D2);

figure('Position', [200, 200, 1000, 400], 'Name', 'Question d - Matches found with descriptors_dxdy and chi^2 distance');
displaymatches(img1, px1, py1, img2, px2, py2, Idx, Dist, 10);


% compute Hessian interest points
[px1, py1] = hessian(img1, 2.0, 50);
fprintf('img1: found %d interest points\n', size(px1, 1));
[px2, py2] = hessian(img2, 2.0, 50);
fprintf('img2: found %d interest points\n', size(px2, 1));

% compute the dx/dy descriptors
D1 = descriptors_maglap(img1, px1, py1, 41, 2.0, 16);
D2 = descriptors_maglap(img2, px2, py2, 41, 2.0, 16);

% find the best matches and sort them according to their scores
[Idx, Dist] = findnn_chi2(D1, D2);

figure('Position', [200, 200, 1000, 400], 'Name', 'Question d - Matches found with descriptors_maglap and chi^2 distance');
displaymatches(img1, px1, py1, img2, px2, py2, Idx, Dist, 10);


disp(a.new_york_matches);


