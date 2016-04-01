function [imgMag, imgDir]=gradmag(img, sigma)
	[imgDx, imgDy] = gaussderiv(img, sigma);
    imgMag = sqrt(imgDx .^ 2 + imgDy .^ 2);
    imgDir = atan(imgDy ./ imgDx);
end
