function imgLap=laplace(img, sigma)

	[imgDxx, ~ , imgDyy ] = gaussderiv2(img, sigma);
	imgLap = imgDxx + imgDyy;
	 			 
end
