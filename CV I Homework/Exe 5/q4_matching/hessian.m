function [px, py] = hessian(img, sigma, thresh)
	[img_dxx, img_dxy, img_dyy] = gaussderiv2(img, sigma);
    
    init_result = (img_dxx .* img_dyy - img_dxy .^ 2) * (sigma ^ 4);
    img_pts = nonmaxsup2d(init_result);
    
    [py, px] = find(img_pts > thresh);
end
