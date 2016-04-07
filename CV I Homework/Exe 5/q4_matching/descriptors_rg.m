function descriptor = descriptors_rg(img, px, py, windowsize, bins)
	rad = round((windowsize - 1)/2);
	[h, w, c] = size(img);
	descriptor = zeros(length(px), bins^2);

	for i = 1:length(px)
		minx = max(px(i) - rad, 1);
		maxx = min(px(i) + rad, w);
		miny = max(py(i) - rad, 1);
		maxy = min(py(i) + rad, h);

		imgWin = img(miny:maxy, minx:maxx, :);
		hist = histrg(imgWin, bins);
		descriptor(i, :) = hist';
	end
end
