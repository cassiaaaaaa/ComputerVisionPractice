function [] = apply()
close all;clc;

a = answers();
p = parameters();

disp('Question: Fundamental Matrix Estimation');

% -------------------------------------------------------------------------
fprintf('\n----- Question a - Fundamental Matrix -----\n');

fname{1} = sprintf('%s_matches.mat', p.dataset);
I1 = imread(sprintf('%s1.jpg', p.dataset));
I2 = imread(sprintf('%s2.jpg', p.dataset));
load(fname{1});

[F e1 e2] = fundmatrix(x1, x2);
F
e1
e2

% -------------------------------------------------------------------------
fprintf('\n----- Question b - Normalization -----\n');

testpts = [rand(2,50); rand(1,50) * 50 + 1];
testpts_norm = normalize2dpts(testpts);

m = mean(testpts_norm, 2);
fprintf('New mean: \n %.2f \n %.2f \n %.2f\n', m(1), m(2), m(3));
d = mean(sqrt(sum(testpts_norm(1:2, :).^2, 1)));
fprintf('New mean distance from origin: %.4f \n', d);
if( (sum(abs(m - [0; 0; 1])) > .0001) || (abs(d - sqrt(2)) > .0001) )
	disp('-> The normalization does NOT work correctly!');
else
	disp('-> The normalization works correctly.');
end

% -------------------------------------------------------------------------
fprintf('\n----- Question c - Fundamental Matrix computation with normalization -----\n');

[F e1 e2] = normfundmatrix(x1, x2);
F
e1
e2

% -------------------------------------------------------------------------
fprintf('\n----- Question d - Selecting correspondences -----\n');

% Please input two sets of correspondances:
% The first should be exact
% The second should also contain outliers
% You may change the number of correspondances if you want
% If you want to reset the correspondences, just delete the file and run this script again
fname{2} = sprintf('%s_matches_hand.mat', p.dataset);
fname{3} = sprintf('%s_matches_hand_outliers.mat', p.dataset);
for f_ind = 2:size(fname, 2)
	f_dir = dir(fname{f_ind});
	if size(f_dir, 1) > 0
		load(fname{f_ind});
		fprintf('Loading %s\n', fname{f_ind});
	else
		[x1, x2] = inputcorresp(I1, I2, 12);
		save(fname{f_ind}, 'x1', 'x2');
	end

	% display two images side-by-side with matches
	figure('Position', [200, 200, 800, 600], 'Name', 'Question: Fundamental Matrix - Matches');
	imshow([I1, I2]);
	hold on;
	plot(x1(1, :), x1(2, :), '+r'); % points in left image
	plot(x2(1, :) + size(I1, 2), x2(2, :), '+r'); % points in right image
	line([x1(1, :)', x2(1, :)' + size(I1, 2)]', [x1(2, :)', x2(2, :)']', 'Color', 'r'); % lines between points
end

% -------------------------------------------------------------------------
fprintf('\n----- Question e - Fundamental matrix computation and visualization -----\n');

for f_ind = 1:size(fname,2)
	load(fname{f_ind});

	if f_ind == 1
		figure('Position', [200, 200, 800, 600], 'Name', 'Question e: Fundamental Matrix - given matches');
	elseif f_ind == 2
		figure('Position', [200, 200, 800, 600], 'Name', 'Question e: Fundamental Matrix - matches by hand');
	else
		figure('Position', [200, 200, 800, 600], 'Name', 'Question e: Fundamental Matrix - matches by hand with outliers');
	end
    
	[F, e1, e2] = fundmatrix(x1, x2);
	% compute epipolar lines
	L2 = F * x1;
	L1 = x2' * F;
	
	% display epipolar lines
	subplot(2, 2, 1);
	display_epipolar_lines(x2, L2, I2, e2);
	title('Epipolar Lines (unnormalized 8-Point Algorithm)');
	subplot(2, 2, 2);
	display_epipolar_lines(x1, L1', I1, e1);


	[Fn, e1n, e2n] = normfundmatrix(x1, x2);
	% compute epipolar lines
	L2n = Fn * x1;
	L1n = x2' * Fn;
	
	% display epipolar lines
	subplot(2, 2, 3);
	display_epipolar_lines(x2, L2n, I2, e2n);
	title('Epipolar Lines (normalized 8-Point Algorithm)');
	subplot(2, 2, 4);
	display_epipolar_lines(x1, L1n', I1, e1n);
end

disp(a.estimation);

% -------------------------------------------------------------------------
fprintf('\n----- Question f - Quantitative evaluation -----\n');

for f_ind = 1:size(fname, 2)
	load(fname{f_ind});
	[F, e1, e2] = fundmatrix(x1, x2);
	[Fn, e1n, e2n] = normfundmatrix(x1, x2);

	if f_ind == 1
		disp('Residual error for given matches');
	elseif f_ind == 2
		disp('Residual error for matches by hand');
	else
		disp('Residual error for matches by hand with outliers');
	end

	fprintf('Residual error: %f\n', res_error(F, x1, x2));
	fprintf('Residual error (normalized): %f\n', res_error(Fn, x1, x2));
	fprintf('\n');
end

disp(a.estimation_error);

end
