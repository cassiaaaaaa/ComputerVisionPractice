function [mag, dir] = imgradient(img, sigma)
	[imgDx, imgDy] = gaussderiv(img, sigma);
	mag = sqrt((imgDx.^2) + (imgDy.^2));
	dir = atan2(imgDy, imgDx);
end

function [imgDx, imgDy] = gaussderiv(img, sigma)
	img = double(img);
	window = floor(-3.0*sigma+0.5):floor(3.0*sigma+0.5);
	gaussian = double(gauss(window, sigma));
	gaussderiv = double(gaussdx(window, sigma));
	
	temp = conv2(img, gaussderiv, 'same');
	imgDx = conv2(temp, gaussian', 'same');
	
	temp = conv2(img, gaussian, 'same');
	imgDy = conv2(temp, gaussderiv', 'same');
end

function gaussderiv = gaussdx(x, sigma)
	gaussderiv = -(x.*exp(-x.^2/(2*sigma^2)))/(sqrt(2*pi)*sigma^3);
end

function gaussian = gauss(x, sigma)
	gaussian = 1/(sqrt(2*pi)*sigma) * exp(-x.^2/(2*sigma^2));
end