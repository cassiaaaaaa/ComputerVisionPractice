function imgMax = nonmaxsupcanny(imgMag, imgDir)

	[h, w] = size(imgMag);
	imgMax = zeros(h,w);

	offx = [-1 -1  0  1  1  1  0 -1 -1];
	offy = [ 0 -1 -1 -1  0  1  1  1  0];

	for y=2:h-1
		for x=2:w-1
			% look up the orientation at that pixel
			dir = imgDir(y, x);
            if isnan(dir)
                dir = 0.001;
            end

			% look up the neighboring pixels in direction of the gradient
			idx = floor(((dir + pi)/pi) * 4 + 0.5) + 1;

			% suppress all non-maximum points
			if( (imgMag(y, x) > imgMag(y + offy(idx), x + offx(idx))) && ...
				(imgMag(y, x) > imgMag(y - offy(idx), x - offx(idx))) )
				imgMax(y, x) = imgMag(y, x);
			end
		end
	end
  	   
end
