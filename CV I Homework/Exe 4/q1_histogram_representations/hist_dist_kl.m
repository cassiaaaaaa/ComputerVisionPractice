function dist = hist_dist_kl(h1, h2)
	dist = sum(h1 .* log(h1 ./ h2), 2);
end
