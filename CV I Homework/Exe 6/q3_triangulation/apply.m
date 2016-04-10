function [] = apply()
	close all;
	clc;
	format short g;

	a = answers(); 
	p = parameters();

	disp('Question: Triangulation');

	% -------------------------------------------------------------------------
	fprintf('\n----- Question a - Metric reconstruction -----\n');

	disp(a.metric);

	% -------------------------------------------------------------------------
	fprintf('\n----- Question b - Camera centers -----\n');

	if strcmp(p.dataset, 'house')
		P1 = load('house1_camera.txt');
		P2 = load('house2_camera.txt');
	elseif strcmp(p.dataset, 'library')
		P1 = load('library1_camera.txt');
		P2 = load('library2_camera.txt');
	else
		error('dataset not found!');
	end
	P1
	P2

	C1 = camera_center(P1);
	C2 = camera_center(P2);

	% -------------------------------------------------------------------------
	fprintf('\n----- Question c -----\n');

	if strcmp(p.dataset, 'house')
		load('house_matches.mat');
		img = imread('house1.jpg');
	elseif strcmp(p.dataset, 'library')
		load('library_matches.mat');
		img = imread('library1.jpg');
	else
		error('dataset not found!');
	end

	figure('Position', [200, 200, 600, 400], 'Name', 'Question c');
	image(img);
	axis equal;
	axis off;
	hold on;

	plot(x1(1, :), x1(2, :), '+r'); % points in left image

	Xs = zeros(4, size(x1, 2));
	for i = 1:size(x1, 2)
		Xs(:, i) = triangulate(P1, x1(:, i), P2, x2(:, i))';
	end

	Xs(:, 1:3)

	% -------------------------------------------------------------------------
	fprintf('\n----- Question d -----\n');

	figure('Position', [800, 200, 600, 400], 'Name', 'Question d');
	axis equal;
	hold on;
	plot3(C1(1), C1(3), C1(2), 'mx', 'MarkerSize', 8);
	plot3(C2(1), C2(3), C2(2), 'gx', 'MarkerSize', 8);

	plot3(Xs(1, :), Xs(3, :), Xs(2, :), 'r.', 'MarkerSize', 8);
	view(-27,40);
	xlabel('x');
	ylabel('z');
	zlabel('y');
	title('Use the button ''Rotate 3D'' to view the scene from different sides');

	% Compute residual error of reprojected 3D points
	xr1h = P1 * Xs;
	xr2h = P2 * Xs;
	xr1 = xr1h(1:2, :) ./ repmat(xr1h(3, :), 2, 1);
	xr2 = xr2h(1:2, :) ./ repmat(xr2h(3, :), 2, 1);

	disp('Residual errors (mean distance in pixels):');
	error1 = mean(sqrt(sum((x1(1:2, :) - xr1).^2)))
	error2 = mean(sqrt(sum((x2(1:2, :) - xr2).^2)))

	disp(a.result);
end
