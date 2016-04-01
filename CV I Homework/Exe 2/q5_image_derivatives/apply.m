function [] = apply()
close all;clc;

a = answers();


disp('Question: Image Derivatives');

% -------------------------------------------------------------------------
disp('----- Question a -----');

figure('Position', [200, 400, 800, 600]);
plot( gaussdx(-100:100, 25) );
title('Gaussian derivative');

% Create impulse image
imgImp = zeros(25, 25);
imgImp(13, 13) = 255;

% Create filter kernels
sigma = 6.0;
x = round(-3.0*sigma):round(3.0*sigma);
G = gauss(x, sigma);
D = gaussdx(x, sigma);

% Apply and display filter combinations
figure('Position', [200, 400, 800, 600]);
subplot(2,3,1);
imagesc(imgImp);
title('Impulse');
axis equal;

comb1 = conv2(imgImp, G, 'same');
comb1 = conv2(comb1, G', 'same');
subplot(2, 3, 2);
imagesc(comb1);
colormap('gray');
title('first G, then G^T');
axis equal;

comb2 = conv2(imgImp, G, 'same');
comb2 = conv2(comb2, D', 'same');
subplot(2, 3, 3);
imagesc(comb2);
colormap('gray');
title('first G, then D^T');
axis equal;

comb3 = conv2(imgImp, D, 'same');
comb3 = conv2(comb3, G', 'same');
subplot(2, 3, 4);
imagesc(comb3);
colormap('gray');
title('first D, then G^T');
axis equal;

comb4 = conv2(imgImp, G', 'same');
comb4 = conv2(comb4, D, 'same');
subplot(2, 3, 5);
imagesc(comb4);
colormap('gray');
title('first G^T, then D');
axis equal;

comb5 = conv2(imgImp, D', 'same');
comb5 = conv2(comb5,G, 'same');
subplot(2, 3, 6);
imagesc(comb5);
colormap('gray');
title('first D^T, then G');
axis equal;

% -------------------------------------------------------------------------
disp('----- Question b -----');

% Gaussian derivatives
tom = double(imread('tomatoes.png'));
[imgDx, imgDy] = gaussderiv(tom, 5);

figure('Position', [200, 600, 800, 400]);
subplot(1, 2, 1);
imagesc(imgDx);
colormap gray;
title('Derivative in x-direction');
axis off;
axis equal;

subplot(1, 2, 2);
imagesc(imgDy);
colormap gray;
title('Derivative in y-direction');
axis off;
axis equal;

% Second Gaussian derivatives
coins1 = double(imread('coins1.jpg'));
circuit = double(imread('circuit.png'));
sigma = 2;

[coinsDxx, coinsDxy, coinsDyy] = gaussderiv2(coins1, sigma);
[circuitDxx, circuitDxy, circuitDyy] = gaussderiv2(circuit, sigma);

figure('Position', [200, 400, 1000, 600]);
subplot(2, 4, 1);
imagesc(coins1);
colormap gray;
title('Original');
axis off;
axis equal;

subplot(2, 4, 2);
imagesc(coinsDxx);
colormap gray;
title('Dxx');
axis off;
axis equal;

subplot(2, 4, 3);
imagesc(coinsDxy);
colormap gray;
title('Dxy');
axis off;
axis equal;

subplot(2, 4, 4);
imagesc(coinsDyy);
colormap gray;
title('Dyy');
axis off;
axis equal;

subplot(2, 4, 5);
imagesc(circuit);
colormap gray;
title('Original');
axis off;
axis equal;

subplot(2, 4, 6);
imagesc(circuitDxx);
colormap gray;
title('Dxx');
axis off;
axis equal;

subplot(2, 4, 7);
imagesc(circuitDxy);
colormap gray;
title('Dxy');
axis off;
axis equal;

subplot(2, 4, 8);
imagesc(circuitDyy);
colormap gray;
title('Dyy');
axis off;
axis equal;

disp(a.impulse_image);

% -------------------------------------------------------------------------
disp('----- Question c -----');

sigma = 2;
[coinsMag, coinsDir] = gradmag(coins1, sigma);
[circuitMag, circuitDir] = gradmag(circuit, sigma);

figure('Position', [200, 200, 800, 800]);
subplot(2, 3, 1);
imagesc(coins1);
colormap gray;
title('Original');
axis off;
axis equal;

subplot(2, 3, 2);
imagesc(coinsMag);
colormap gray;
title('Magnitude');
axis off;
axis equal;

subplot(2, 3, 3);
imagesc(coinsDir);
colormap gray;
title('Direction');
axis off;
axis equal;

subplot(2,3,4);
imagesc(circuit);
colormap gray;
title('Original');
axis off;
axis equal;

subplot(2, 3, 5);
imagesc(circuitMag);
colormap gray;
title('Magnitude');
axis off;
axis equal;

subplot(2, 3, 6);
imagesc(circuitDir);
colormap gray;
title('Direction');
axis off;
axis equal;

disp(a.gradmag);

% -------------------------------------------------------------------------
disp('----- Question d -----');

sigma = 2;
coinsLap = laplace(coins1, sigma);
circuitLap = laplace(circuit, sigma);

figure('Position', [200, 600, 800, 400]);
subplot(1, 2, 1);
imagesc(coinsLap);
colormap gray;
axis off;
axis equal;
title('Laplace');

subplot(1, 2, 2);
imagesc(circuitLap);
colormap gray;
axis off;
axis equal;
title('Laplace');

disp(a.laplace);

end
