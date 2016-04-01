function [m, v] = get_window_mean_var(img, x, y, r)
	len = (2 * r + 1) ^ 2;
    block = reshape(img((x - r):(x + r), (y - r):(y + r)), 1, len);
    
    m = mean(block);
    v = var(block);
end
