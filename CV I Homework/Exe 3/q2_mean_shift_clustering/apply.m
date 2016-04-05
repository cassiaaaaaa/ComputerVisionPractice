function apply()
close all;clc;

a = answers();

disp('Question: Mean-Shift Clustering');

f = load('pts.mat');

% % the datapoints in f are ordered according to their position
% % for debugging purposes it can be helpful to permutate them:
% x = randperm(2000);
% f.data = [f.data(1,x);f.data(2,x);f.data(3,x)];

% -------------------------------------------------------------------------
% disp('----- Question a -----');
% 
% figure('Position', [200, 200, 1200, 500], 'Name','Question a: findpeak'); 
% fprintf('(top view) Black dots: datapoints, blue cross: considered datapoint, red cross: peak.\n');
% idx = [1, 5, 1500];
% r = 2;
% for ind = 1:numel(idx)
% 	peak = findpeak(f.data, idx(ind), r);
% 	subplot(1, numel(idx), ind);
% 	hold on;
% 	plot(f.data(1,:), f.data(2,:), '.', 'Color', 'black'); 
% 	plot(f.data(1, idx(ind)), f.data(2, idx(ind)), 'bx', 'MarkerSize', 12.0, 'LineWidth', 4.0);
% 	plot(peak(1), peak(2), 'rx', 'MarkerSize', 24.0, 'LineWidth', 4.0);
% end
% 
% % -------------------------------------------------------------------------
% disp('----- Question b -----');
% 
% figure('Position', [200, 200, 1200, 500], 'Name', 'Question b: meanshift'); 
% fprintf('Black crosses: cluster centers, each cluster has different (random) color.\n');
% r = [1, 1.25, 2];
% for ind = 1:numel(r)
% 	tstart = tic;
% 	subplot(1, numel(r), ind);
% 	[labels, means] = meanshift(f.data, r(ind));
% 	plot3dclusters(f.data, labels, means);
% 	axis equal;
% 	n_means = size(unique(labels), 2);
% 	title(sprintf('Found %d means using r=%.2f\nComputation took %.4fs\n', n_means, r(ind), toc(tstart)));
% 	drawnow;
% end

% -------------------------------------------------------------------------
disp('----- Question c -----');

figure('Position', [200, 200, 1200, 500], 'Name', 'Question c: meanshift_opt'); 
fprintf('Black crosses: cluster centers, each cluster has different (random) color.\n');
r = [1, 1.25, 2];
for ind = 1:numel(r)
	tstart = tic;
	subplot(1,numel(r),ind);
	[labels, means] = meanshift_opt(f.data, r(ind));
	plot3dclusters(f.data, labels, means);
	axis equal;
	n_means = size(unique(labels), 2);
	title(sprintf('Found %d means using r=%.2f\nComputation took %.4fs\n', n_means, r(ind), toc(tstart)));
end

% -------------------------------------------------------------------------
disp('----- Question d -----');

disp(a.radius);
disp(a.optimized);


