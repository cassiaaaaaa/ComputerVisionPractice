function center = camera_center(P)
	[~, ~, V] = svd(P);
	center = V(:, end);
	center = center ./ center(4);
end
