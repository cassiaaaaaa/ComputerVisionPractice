function [] = apply()
	close all;
	clc;
	format short g;

	a = answers();
	p = parameters();

	disp('Question: RANSAC');

	% -------------------------------------------------------------------------
	fprintf('\n----- Question a -----\n');

	disp('How many iterations do we need to perform for an inlier rate of 90% / 50% / 20%');
	disp('to be 99.9% sure that we get the right fundamental matrix?');

	disp(a.iterations);

	% -------------------------------------------------------------------------
	fprintf('\n----- Question b - Inliers -----\n');

	load('house_matches.mat');
	[F, e1, e2] = normfundmatrix(x1, x2);

	eps = 0.01;
	fprintf('Example: Result for dataset "house", eps = %.2f\n', eps);
	fprintf('(hint: for eps = 0.01 i1 and i2 should each contain 7 points)\n');
	[i1, i2] = get_inliers(F, x1, x2, eps);
	i1
	i2

	% -------------------------------------------------------------------------
	fprintf('\n----- Question c - RANSAC -----\n');

	% setting Matlab's random number generator to a specific state, s.t. RANSAC will give the same result for each run
	stream = RandStream('mt19937ar', 'Seed', p.random_seed);
	% RandStream.setDefaultStream(stream); 
	RandStream.setGlobalStream(stream);

	eps = 0.5;
	fprintf('Fundamental matrix computed with RANSAC: (eps = %.2f)\n', eps);
	[F, e1, e2, xi1, xi2] = ransac_fundmatrix(x1, x2, eps, 200);
	F
	fprintf('Epipoles:\n')
	e1
	e2
	fprintf('RANSAC used %d inliers from %d correspondences\n', size(xi1, 2), size(x1, 2))
	% xi1
	% xi2

	% -------------------------------------------------------------------------
	fprintf('\n----- Question d - epsilon -----\n');

	figure('Position', [200, 200, 600, 400], 'Name', 'Question: RANSAC');
	eps = 0.01:0.05:1;
	error = zeros(1, size(eps, 2));
	for i = 1:size(eps,2)
		F = ransac_fundmatrix(x1, x2, eps(i), 200);
		error(i) = res_error(F, x1, x2) + res_error(F', x2, x1);
	end
	plot(eps, error);
	xlabel('eps');
	ylabel('error rate');

	disp('Which epsilon gives the best result? Can you think of an explanation?');
	disp(a.epsilon);

% -------------------------------------------------------------------------
	fprintf('\n----- Question e - Harris points -----\n');

	% compute machtes with Harris interest points and maglap descriptor
	I1 = double(rgb2gray(imread('house1.jpg')));
	I2 = double(rgb2gray(imread('house2.jpg')));
	% compute Harris interest points
	[px1, py1] = harris(I1, p.harris.sigma, p.harris.threshold);
	[px2, py2] = harris(I2, p.harris.sigma, p.harris.threshold);

	% compute the descriptors
	D1 = descriptors_maglap(I1, px1, py1, p.maglap.windowsize, p.maglap.sigma, p.maglap.n_bins);
	D2 = descriptors_maglap(I2, px2, py2, p.maglap.windowsize, p.maglap.sigma, p.maglap.n_bins);

	% find the best matches and sort them according to their scores
	[Idx, Dist] = findnn_chi2(D1,D2);

	figure;
	hist(Dist, 100);
	title('Distribution of matching distances');

	good_idx = find(Dist < p.distance_threshold);

	x1 = px1(good_idx);
	y1 = py1(good_idx);
	x2 = px2(Idx(good_idx));
	y2 = py2(Idx(good_idx));

	x1 = [x1, y1, ones(size(x1, 1), 1)]';
	x2 = [x2, y2, ones(size(x2, 1), 1)]';

	save(p.outfilename,'x1','x2');

	fprintf('Found %d matches with Harris and maglap\n', size(x1, 2));
	% display two images side-by-side with matches
	figure('Position', [200, 200, 800, 600], 'Name', 'Question: RANSAC - Harris points, matched with maglap');
	I1 = imread('house1.jpg');
	I2 = imread('house2.jpg');
	imshow([I1, I2]);
	hold on;
	plot(x1(1, :), x1(2, :), '+r'); % points in left image
	plot(x2(1, :) + size(I1, 2), x2(2, :), '+r'); % points in right image
	line([x1(1, :)', x2(1, :)' + size(I1, 2)]', [x1(2, :)', x2(2, :)']', 'Color', 'r'); % lines between points

	[F, e1, e2, xi1, xi2] = ransac_fundmatrix(x1, x2, p.ransac.epsilon, p.ransac.n_iterations);
	error = res_error(F, xi1, xi2);

	disp('Fundamental Matrix');
	F
	fprintf('Residual error: %f\n', error);
	fprintf('%d inliers\n\n', size(xi1, 2));

	disp('Correct matrix:');
	load('F_house.mat')
	F_house

	disp('Does your implementation find a good solution?');
	disp(a.solution);

	disp('Which effect does changing the threshold have?');
	disp(a.threshold);
end
