function dist = hist_dist_intersection(h1, h2)
	dist = sum(min(h1, h2), 2);
end
