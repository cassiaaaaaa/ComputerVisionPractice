function [vRho, vTheta] = findhoughpeaks(houghSpace, thresh)
	filtered = nonmaxsup2d(houghSpace);
    result = filtered > thresh;
	[vRho, vTheta] = find(result);
end
