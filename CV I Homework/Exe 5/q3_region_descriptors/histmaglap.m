function histogram = histmaglap(img, sigma, bins)
    [img_mag, ~] = gradmag(img, sigma);
    img_lap = laplace(img, sigma);
    
    img_mag(img_mag > 100) = 100;
    mag_map = floor(img_mag / 101 * bins) + 1;
    
    img_lap = img_lap + 60;
    img_lap(img_lap > 120) = 120;
    img_lap(img_lap < 0) = 0;
    lap_map = floor(img_lap / 121 * bins) + 1;
    
    histogram = zeros(bins, bins);
    
    for i = 1:bins
        for j = 1:bins
            mag_idx = (mag_map == i);
            lap_idx = (lap_map == j);
            histogram(i, j) = sum(sum(mag_idx .* lap_idx));
        end
    end
    
    histogram = histogram / sum(histogram(:));
    histogram = reshape(histogram, 1, bins ^ 2);
end
