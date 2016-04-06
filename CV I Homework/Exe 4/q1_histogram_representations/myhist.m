function h = myhist(filename, bins)
    bin_width = 256 / bins;
    h = zeros(bins, 1);
    
    img = rgb2gray(imread(filename));
    for bin_idx = 1:bins
        down = img >= ceil((bin_idx - 1) * bin_width);
        up = img < bin_idx * bin_width;
        in_bin = up .* down;
        h(bin_idx) = sum(in_bin(:));
    end
    
    % Normalization
    h = h / sum(h);
end
