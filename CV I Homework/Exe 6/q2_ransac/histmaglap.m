function histogram = histmaglap(img, sigma, bins)
	% this function assumes that the image is double and in the range 0..1

	% compute the first derivatives
	[imgMag, imgDir] = gradmag(img, sigma);
	imgLap = laplace(img, sigma);
 	 			

	% quantize the images to "bins" number of values
	if 0
		imgMag = floor(imgMag/255*bins) + 1;
		imgLap = floor((imgLap + 256) / 511*bins) + 1;
	else
		% Hint: if you assume a range of -1..1 the histogram will be quite
		% sparse and probably not useful. Instead assume that
		% the magnitude will be in the range 0 .. 100 and
		% the laplacian in the range -60 .. 60
		imgMag( imgMag > 100 ) = 100;
		imgMag = floor(imgMag/100*bins) + 1;
 	   	
		imgLap = imgLap + 60;
		imgLap( imgLap < 0 )   = 0;
		imgLap( imgLap > 120 ) = 120;
		imgLap = floor(imgLap/120*bins) + 1;
	end

	% define a 2D histogram  with "bins^2" number of entries
	histogram=zeros(bins,bins);

	% execute the loop for each pixel in the image,
	for i=1:size(img, 1)
		for j=1:size(img, 2)

			% increment a histogram bin which corresponds to the value
			% of pixel i,j;
			mag = imgMag(i, j);
			lap = imgLap(i, j);

			histogram(mag, lap) = histogram(mag, lap) + 1;
		end
	end

	% normalize the histogram such that its integral (sum) is equal 1
	histogram = histogram / sum(histogram(:));
	histogram = reshape(histogram, bins^2, 1);
end
