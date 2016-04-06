function h = myhist3(filename, bins)
	img = double(imread(filename));
    
    [height, width, ~] = size(img);
    rgb_sum = sum(img, 3);
    img_r = img(:, :, 1) ./ rgb_sum;
    img_g = img(:, :, 2) ./ rgb_sum;
    
    h = zeros(bins, bins);
    bin_width = 1 / bins;
    
    r_idx = ceil(img_r / bin_width);
    r_idx(r_idx == 0) = 1;
    g_idx = ceil(img_g / bin_width);
    g_idx(g_idx == 0) = 1;
    
    for i = 1:height
        for j = 1:width
            r = r_idx(i, j);
            g = g_idx(i, j);
            
            h(r, g) = h(r, g) + 1;
        end
    end
    
    h(1, 1) = 0;
	h(round((bins - 1) / 3) + 1, round((bins - 1) / 3) + 1) = 0;
    
    % Normalization and reshape
    h = h / sum(h(:));
    h = reshape(h, 1, bins ^ 2);
end
