function show_hough_lines(image, vRho, vTheta, nBinsRho, nBinsTheta)

imagesc(image); colormap gray; axis off
n_lines = size(vRho,1);
D       = norm(size(image));   % Image diagonal
img_width = size(image,2);

for l=1:n_lines
    n = vTheta(l);
    m = vRho(l);
    theta = -pi/2 + pi * (n-1)/(nBinsTheta-1);
    rho = (m-1)*2*D/(nBinsRho-1)-D;
    X = [1 img_width];
    Y = [(rho - cos(theta)) / sin(theta), (rho - img_width * cos(theta)) / sin(theta)];
    line(X, Y, 'color', 'r');
end
