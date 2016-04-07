function [] = apply()
close all;clc;

disp('Question: Homography estimation');

a = answers();
p = parameters();

% -------------------------------------------------------------------------
fprintf('\n----- Question a -----\n');

% load two example images
img1 = double(imread('NewYork/im1.png'));
img2 = double(imread('NewYork/im5.png'));

% compute Hessian interest points
[px1, py1] = hessian(img1, p.sigma, 25);
fprintf('img1: found %d interest points\n', size(px1, 1));
[px2, py2] = hessian(img2, p.sigma, 25);
fprintf('img2: found %d interest points\n', size(px2, 1));

% compute the dx/dy descriptors
D1 = descriptors_maglap(img1, px1, py1, 41, p.sigma, p.n_bins);
D2 = descriptors_maglap(img2, px2, py2, 41, p.sigma, p.n_bins);

% find the best matches and sort them according to their scores
[Idx, Dist] = findnn_chi2(D1, D2);

figure('Position', [200, 200, 1000, 400], 'Name', 'Question a - Matches used to find homography');
displaymatches(img1, px1, py1, img2, px2, py2, Idx, Dist, 20);

% --- best 10 ---
[~, SIdx] = sort(Dist, 'ascend');
k = p.topk;
x1 = px1(SIdx(1:k));
y1 = py1(SIdx(1:k));
x2 = px2(Idx(SIdx(1:k)));
y2 = py2(Idx(SIdx(1:k)));
H = estimate_homography(x1, y1, x2, y2);
disp('My homography');
H
disp('Ground truth homography');
load NewYork/H1to5
H1to5

% -------------------------------------------------------------------------
fprintf('\n----- Question b -----\n');

diff = norm(reshape(H, 1, []) - reshape(H1to5, 1, []));
fprintf('Difference using %d correspondences: %f\n', k, diff);

% --- best 20 ---
k = 20;
x1 = px1(SIdx(1:k));
y1 = py1(SIdx(1:k));
x2 = px2(Idx(SIdx(1:k)));
y2 = py2(Idx(SIdx(1:k)));
H20 = estimate_homography(x1, y1, x2, y2);
diff = norm(reshape(H20, 1, []) - reshape(H1to5, 1, []));
fprintf('Difference using %d correspondences: %f\n', k, diff);

% --- best 50 ---
k = 50;
x1 = px1(SIdx(1:k));
y1 = py1(SIdx(1:k));
x2 = px2(Idx(SIdx(1:k)));
y2 = py2(Idx(SIdx(1:k)));
H20 = estimate_homography(x1, y1, x2, y2);
diff = norm(reshape(H20, 1, []) - reshape(H1to5, 1, []));
fprintf('Difference using %d correspondences: %f\n', k, diff);


disp(a.homography_estimation);

% -------------------------------------------------------------------------
fprintf('\n----- Question c - Testing the homography -----\n');

hom_gui_H(uint8(img1), uint8(img2), H);

disp(a.homography_accuracy);
