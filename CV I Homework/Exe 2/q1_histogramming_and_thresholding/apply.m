function [] = apply()
close all;clc;

a = answers();

disp('Question: Histogramming and Thresholding');

%---------- Question a ----------
disp('----- a -----');
cells = rgb2gray(imread('cells.png'));
figure;
imshow(cells);
title('cells.png');

% compute grayvalue histogram
h = histogram(cells);
figure;
bar(0:255, h);
title('grayvalue histogram');
disp(a.grayvalue_histogram);

% compute cumulative histogram
cumulative_histogram = cumsum(h);
figure;
bar(cumulative_histogram);
title('cumulative histogram');
disp(a.cumulative_histogram);

%---------- Question b ----------
disp('----- b -----');
figure('Position', [200, 400, 1200, 400]); 

subplot(1, 5, 1);
T = 100;
imshow(thresh(cells, T));
title(['Thresholded at T = ' num2str(T)]);

subplot(1,5,2);
T = 130;
imshow(thresh(cells, T));
title(['Thresholded at T = ' num2str(T)]);

subplot(1,5,3);
T = 150;
imshow(thresh(cells, T));
title(['Thresholded at T = ' num2str(T)]);

subplot(1,5,4);
T = 170;
imshow(thresh(cells, T));
title(['Thresholded at T = ' num2str(T)]);

subplot(1,5,5);
T = 200;
imshow(thresh(cells, T));
title(['Thresholded at T = ' num2str(T)]);
disp(a.threshold);

%---------- Question c ----------
disp('----- c -----');
cells_otsu = thresh_otsu(double(cells));
figure
imshow(cells_otsu);
title('Thresholded with Otsu''s method');

%---------- Question d ----------
disp('----- d -----');
cells_niblack = thresh_niblack(double(cells), 15, -0.2);
tic
figure;
imshow(cells_niblack);
title('Threholded with Niblack''s method');
toc
disp(a.niblack);

end
