function [imgDxx, imgDxy, imgDyy] = gaussderiv2(img, sigma)

	x = [floor(-3.0*sigma+0.5):floor(3.0*sigma+0.5)];
	gaussian = gauss(x, sigma);
	derivative = gaussdx(x, sigma);

	[imgDx, imgDy] = gaussderiv(img, sigma);

	temp   = conv2(imgDx, derivative,'same');
	imgDxx = conv2(temp,gaussian','same');
	temp   = conv2(imgDx,gaussian,'same');
	imgDxy = conv2(temp,derivative','same');
	temp   = conv2(imgDy,gaussian,'same');
	imgDyy = conv2(temp,derivative','same');
 		 		
end
