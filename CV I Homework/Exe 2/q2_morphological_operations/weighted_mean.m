function wm = weighted_mean(vec, rmin, rmax)
	wm = vec(rmin:rmax) * (rmin:rmax)' / sum(vec(rmin:rmax));
end
