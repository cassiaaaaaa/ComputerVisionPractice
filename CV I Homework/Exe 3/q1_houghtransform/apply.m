function [] = apply()
close all;clc;

a = answers();

disp('Question: 2D Structure Extraction');

% -------------------------------------------------------------------------
disp('----- Question a -----');

gantry = double(rgb2gray(imread('gantrycrane.png')));

% Apply Canny detector
sigma = 2.0;
theta_low = 0.1;
theta_high = 0.3;
imgEdgeGantry = edge(gantry, 'canny', [theta_low, theta_high], sigma);

% Apply hough transform
nBinsRho = 300;
nBinsTheta = 300;
houghSpace = houghtransform(imgEdgeGantry, nBinsRho, nBinsTheta);
D = norm(size(imgEdgeGantry)); % Image diagonal
T = -pi/2:(pi/(nBinsTheta - 1)):pi/2;
R = -D:(2*D/(nBinsRho - 1)):D;

figure('Position', [200, 400, 400, 400]);
imagesc(gantry);
colormap(gray);
axis off;
axis equal;
title('input image');

figure('Position', [200, 400, 400, 400]);
imagesc(T, R, houghSpace);
colormap(hot);
axis off;
title('Hough space');

% -------------------------------------------------------------------------
disp('----- Question b -----');
circuit = double(imread('circuit.png'));
imgEdgeCircuit = edge(circuit, 'canny', [theta_low, theta_high], sigma);

houghSpaceGantry = houghtransform(imgEdgeGantry, 300, 300);
[vRhoGantry, vThetaGantry] = findhoughpeaks(houghSpaceGantry, 220);

houghSpaceCircuit = houghtransform(imgEdgeCircuit, 300, 300);
[vRhoCircuit, vThetaCircuit] = findhoughpeaks(houghSpaceCircuit, 120);

fprintf('gantry.png: %d lines\n', size(vRhoGantry, 1));
fprintf('circuit.png: %d lines\n', size(vRhoCircuit, 1));

figure('Position', [200, 400, 800, 400]);
subplot(1, 2, 1);
show_hough_lines(circuit, vRhoCircuit, vThetaCircuit, nBinsRho, nBinsTheta);

subplot(1, 2, 2);
show_hough_lines(gantry, vRhoGantry, vThetaGantry, nBinsRho, nBinsTheta);

disp('Are all the lines found?');
disp(a.all_lines);

% -------------------------------------------------------------------------
disp('----- Question c (Bonus) houghcircle -----');

disp(a.houghcircle);

% -------------------------------------------------------------------------
disp('----- Question d (Bonus) coin classification system -----');

disp(a.classification);
