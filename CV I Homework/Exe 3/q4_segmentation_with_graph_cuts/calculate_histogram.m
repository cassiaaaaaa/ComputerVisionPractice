function histogram = calculate_histogram(img, mask, n_bins)
    init_smooth = 0.001;
	histogram = ones(n_bins, n_bins, n_bins) * init_smooth;
    
    bin_width = 257 / n_bins;
    
    % Get selected pixels
    selected_num = sum(mask(:));
    selected = img(repmat(mask, 1, 1, 3) == 1);
    selected = reshape(selected, selected_num, 3)';
    
    for pix = 1:selected_num
        r = floor(selected(1, pix) / bin_width) + 1;
        g = floor(selected(2, pix) / bin_width) + 1;
        b = floor(selected(3, pix) / bin_width) + 1;
        
        histogram(r, g, b) = histogram(r, g, b) + 1;
    end
    
    % Normalization
    histogram = histogram / sum(histogram(:));
end
