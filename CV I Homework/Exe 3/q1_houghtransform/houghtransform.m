function houghSpace = houghtransform(imgEdge, nBinsRho, nBinsTheta)
	houghSpace = zeros(nBinsRho, nBinsTheta);
    [height, width] = size(imgEdge);
    
    diagonal = sqrt(height ^ 2 + width ^ 2);
    rhoStep = 2 * diagonal / nBinsRho;
    thetaStep = pi / nBinsTheta;
    
    for i = 1:height
        for j = 1:width
            if imgEdge(i, j)
                for n = 0:(nBinsTheta - 1)
                    theta = n * thetaStep - pi / 2;
                    rho = j * cos(theta) + i * sin(theta) + diagonal;
                    rho = floor(rho / rhoStep) + 1;
                    houghSpace(rho, n + 1) = houghSpace(rho, n + 1) + 1;
                end
            end
        end
    end
end
