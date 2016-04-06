function dist = hist_dist_chi(h1, h2)
    hist_sum = h1 + h2;
    down = hist_sum(hist_sum ~= 0);
    up1 = h1(hist_sum ~= 0);
    up2 = h2(hist_sum ~= 0);
	dist = sum(((up1 - up2) .^ 2) ./ down, 2);
end
