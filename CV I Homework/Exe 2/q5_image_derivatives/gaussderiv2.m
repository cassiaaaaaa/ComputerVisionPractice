function [imgDxx, imgDxy, imgDyy] = gaussderiv2(img, sigma)
    [imgDx, imgDy] = gaussderiv(img, sigma);
    [imgDxx, imgDxy] = gaussderiv(imgDx, sigma);
    [~, imgDyy] = gaussderiv(imgDy, sigma);
end
