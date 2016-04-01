function outimg = gaussianfilter(inimg, sigma)
    win_radius = floor(3 * sigma);
    gauss_filter = gauss(-win_radius:win_radius, sigma);
	pad_img = padarray(inimg, [win_radius, win_radius], 'symmetric');
    
    outimg = inimg;
    
    [height, width] = size(inimg);
    
    for i = 1:height
        for j = 1:width
            outimg(i, j) = gauss_filter ...
                * pad_img(i:(i + 2 * win_radius), j + win_radius);
        end
    end
    
    pad_out = padarray(outimg, [win_radius, win_radius], 'symmetric');
    
    for i = 1:height
        for j = 1:width
            outimg(i, j) = gauss_filter ...
                * pad_out(i + win_radius, j:(j + 2 * win_radius))';
        end
    end
end
