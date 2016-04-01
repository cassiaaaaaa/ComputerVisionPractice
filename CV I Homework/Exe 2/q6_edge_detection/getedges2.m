function imgEdge = getedges2(img, sigma, theta)
	[imgMag, imgDir] = gradmag(img, sigma);
    imgEdge = nonmaxsupcanny(imgMag, imgDir) >= theta;
end
