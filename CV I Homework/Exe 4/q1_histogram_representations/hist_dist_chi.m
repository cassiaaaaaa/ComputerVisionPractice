function dist = hist_dist_chi(h1, h2)
	dist = sum(((h1 - h2) .^ 2) ./ (h1 + h2), 2);
end
