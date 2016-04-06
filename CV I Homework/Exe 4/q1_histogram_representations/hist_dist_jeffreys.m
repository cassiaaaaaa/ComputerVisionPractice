function dist = hist_dist_jeffreys(h1, h2)
	dist = hist_dist_kl(h1, h2) + hist_dist_kl(h2, h1);
end
