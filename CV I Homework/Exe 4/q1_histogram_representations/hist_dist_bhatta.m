function dist = hist_dist_bhatta(h1, h2)
	dist = sum(sqrt(h1 .* h2), 2);
end
