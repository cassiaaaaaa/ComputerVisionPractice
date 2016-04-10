function [px, py] = harris(img, sigma, thresh, norm_sigma)

	if nargin<4
		norm_sigma = 1;
	end

	[imgDx imgDy] = gaussderiv(img, sigma);
	if norm_sigma==1
		imgDx2 = gaussianfilter(sigma^2 * imgDx.^2,     1.6*sigma);
		imgDy2 = gaussianfilter(sigma^2  * imgDy.^2,     1.6*sigma);
		imgDxy = gaussianfilter(sigma^2 * imgDx.*imgDy, 1.6*sigma);
	else
		imgDx2 = gaussianfilter(imgDx.^2,     1.6);
		imgDy2 = gaussianfilter(imgDy.^2,     1.6);
		imgDxy = gaussianfilter(imgDx.*imgDy, 1.6);
	end

	imgDet   = imgDx2.*imgDy2 - imgDxy.^2;
	imgTrace = imgDx2 + imgDy2;

	% Corner response function
	alpha = 0.06;
	imgPts = imgDet - alpha*imgTrace.^2;
	imgPts = nonmaxsup2d( imgPts );
	  	 	
	[py, px] = find(imgPts > thresh);

end
