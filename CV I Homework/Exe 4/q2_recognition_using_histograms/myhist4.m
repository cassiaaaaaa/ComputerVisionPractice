function h = myhist4(filename, bins)
	img = im2double(rgb2gray(imread(filename)));
    
    [height, width, ~] = size(img);
    [img_dx, img_dy] = gaussderiv(img, 1.0);
    
    h = zeros(bins, bins);
    
    dx_idx = round((img_dx + 1) * (bins / 2)) + 1;
    dy_idx = round((img_dy + 1) * (bins / 2)) + 1;
    
    for i = 1:height
        for j = 1:width
            dx = dx_idx(i, j);
            dy = dy_idx(i, j);
            
            h(dx, dy) = h(dx, dy) + 1;
        end
    end
    
    % Normalization and reshape
    h = h / sum(h(:));
    h = reshape(h, 1, bins ^ 2);
end
