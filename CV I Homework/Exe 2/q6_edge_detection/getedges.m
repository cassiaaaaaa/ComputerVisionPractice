function imgEdge = getedges(img, sigma, theta)
	[imgMag, ~] = gradmag(img, sigma);
    imgEdge = imgMag >= theta;
end
