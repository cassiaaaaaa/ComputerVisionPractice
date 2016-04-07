function dist = hist_dist_chi(h1, h2)
	diff = (h1 - h2).^2;
	s = (h1 + h2);
	k = find( s > 0 );	 % prevent division by 0
	t = diff(k) ./ s(k);
	dist = sum( t );
end
