function [imgDx, imgDy] = gaussderiv(img, sigma)
    win_radius = 3 * sigma;
	pad_img = padarray(img, [win_radius, win_radius], 'symmetric');
    
    gdx_filter = gaussdx(-win_radius:win_radius, sigma);
    
    [height, width] = size(img);
    
    imgDx = img;
    imgDy = img;
    
    for i = 1:height
        for j = 1:width
            imgDx(i, j) = gdx_filter ...
                * pad_img(i:(i + 2 * win_radius), j + win_radius);
            imgDy(i, j) = pad_img(i + win_radius, ...
                j:(j + 2 * win_radius)) * gdx_filter';
        end
    end
end
