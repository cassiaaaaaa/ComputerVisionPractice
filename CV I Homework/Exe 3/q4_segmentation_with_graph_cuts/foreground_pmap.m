function foreground_map = foreground_pmap(img, fg_histogram, bg_histogram)
    [height, width, ~] = size(img);
	foreground_map = zeros(height, width);
    n_bins = size(fg_histogram, 1);
    
    for i = 1:height
        for j = 1:width
            r = floor(img(i, j, 1) / 257 * n_bins) + 1;
            g = floor(img(i, j, 2) / 257 * n_bins) + 1;
            b = floor(img(i, j, 3) / 257 * n_bins) + 1;
            
            fg_score = fg_histogram(r, g, b);
            bg_score = bg_histogram(r, g, b);
            
            foreground_map(i, j) = fg_score / (fg_score + bg_score);
        end
    end
end
