function h = myhist2(filename, bins)
	img = double(imread(filename));
    
    [height, width, ~] = size(img);
    
    h = zeros(bins, bins, bins);
    bin_width = 256 / bins;
    
    rgb_idx = floor(img ./ bin_width) + 1;
    
    for i = 1:height
        for j = 1:width
            r = rgb_idx(i, j, 1);
            g = rgb_idx(i, j, 2);
            b = rgb_idx(i, j, 3);
            
            h(r, g, b) = h(r, g, b) + 1;
        end
    end
    
    h(1, 1, 1) = 0;
    
    % Normalization and reshape
    h = h / sum(h(:));
    h = reshape(h, 1, bins ^ 3);
end
