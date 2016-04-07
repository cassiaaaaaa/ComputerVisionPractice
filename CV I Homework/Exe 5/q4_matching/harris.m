function [px, py] = harris(img, sigma, thresh, norm_sigma)
    alpha = 0.06;
    if nargin < 4
        norm_sigma = 1;
    end

    [img_dx, img_dy] = gaussderiv(img, sigma);
    
    if norm_sigma == 1
        img_dx2 = gaussianfilter(sigma ^ 2 * img_dx .^ 2, 1.6 * sigma);
        img_dy2 = gaussianfilter(sigma ^ 2 * img_dy .^ 2, 1.6 * sigma);
        img_dxdy = gaussianfilter(sigma ^ 2 * img_dx .* img_dy, ...
                                  1.6 * sigma);
    else
        img_dx2 = gaussianfilter(img_dx .^ 2, 1.6);
        img_dy2 = gaussianfilter(img_dy .^ 2, 1.6);
        img_dxdy = gaussianfilter(img_dx .* img_dy, 1.6);
    end

    img_det = img_dx2 .* img_dy2 - img_dxdy .^ 2;
    img_trace = img_dx2 + img_dy2;
    
    init_result = img_det - alpha * img_trace .^ 2;
    img_pts = nonmaxsup2d(init_result);
    
    [py, px] = find(img_pts > thresh);
end
