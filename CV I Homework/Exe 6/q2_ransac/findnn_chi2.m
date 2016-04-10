function [Idx, Dist] = findnn_chi2(D1, D2)
	% D1 D2: one histogram per line
	dists = zeros(size(D1, 1), size(D2, 1));
	for i = 1:size(D1, 1)
		for j = 1:size(D2,1)
			dists(i, j) = hist_dist_chi(D1(i, :), D2(j, :));
		end
	end
	[Dist, mind] = min(dists, [], 2);
	[Idx, ~] = ind2sub(size(dists), mind);
end
