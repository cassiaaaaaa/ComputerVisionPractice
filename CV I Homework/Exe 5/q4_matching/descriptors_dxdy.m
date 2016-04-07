function descriptor = descriptors_dxdy(img, px, py, windowsize, ...
    sigma, bins)
	radius = (windowsize - 1) / 2;
    descriptor = zeros(length(px), bins ^ 2);
    
    [height, width] = size(img);
    for idx = 1:length(px)
        lt_x_idx = max(1, px(idx) - radius);
        lt_y_idx = max(1, py(idx) - radius);
        rb_x_idx = min(width, px(idx) + radius);
        rb_y_idx = min(height, py(idx) + radius);
        
        win = img(lt_y_idx:rb_y_idx, lt_x_idx:rb_x_idx);
        descriptor(idx, :) = histdxdy(win, sigma, bins);
    end
end
