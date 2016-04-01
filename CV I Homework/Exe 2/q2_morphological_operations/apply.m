function [] = apply()
close all;clc;
a=answers();
disp('Question: Morphological Operations');
cells = rgb2gray(imread('cells.png'));

cells_niblack = thresh_niblack(double(cells), 15, -0.2);
figure;
imshow(cells_niblack);
title('Threholded with Niblack''s method');

% Try out different morphological operations and structuring elements
structure_square = strel('square', 5); % 5-by-5 square
structure_line = strel('line', 10, 45); % line, length 10, angle 45
structure_disk = strel('disk', 1); % disk, radius 1

cells_dilated1 = imdilate(cells_niblack, structure_square);
cells_eroded1 = imerode(cells_niblack, structure_square);
cells_opened1 = imopen(cells_niblack, structure_square);
cells_closed1 = imclose(cells_niblack, structure_square);

cells_dilated2 = imdilate(cells_niblack, structure_line);
cells_eroded2 = imerode(cells_niblack, structure_line);
cells_opened2 = imopen(cells_niblack, structure_line);
cells_closed2 = imclose(cells_niblack, structure_line);

cells_dilated3 = imdilate(cells_niblack, structure_disk);
cells_eroded3 = imerode(cells_niblack, structure_disk);
cells_opened3 = imopen(cells_niblack, structure_disk);
cells_closed3 = imclose(cells_niblack, structure_disk);

figure('Position', [200, 400, 800, 600]); 
subplot(3, 4, 1);
imshow(cells_dilated1);
title('dilated with square');

subplot(3, 4, 2);
imshow(cells_eroded1);
title('eroded with square');

subplot(3, 4, 3);
imshow(cells_opened1);
title('opened with square');

subplot(3, 4, 4);
imshow(cells_closed1);
title('closed with square');

subplot(3, 4, 5);
imshow(cells_dilated2);
title('dilated with line');

subplot(3, 4, 6);
imshow(cells_eroded2);
title('eroded with line');

subplot(3, 4, 7);
imshow(cells_opened2);
title('opened with line');

subplot(3, 4, 8);
imshow(cells_closed2);
title('closed with line');

subplot(3, 4, 9);
imshow(cells_dilated3);
title('dilated with disk');

subplot(3, 4, 10);
imshow(cells_eroded3);
title('eroded with disk');

subplot(3, 4, 11);
imshow(cells_opened3);
title('opened with disk');

subplot(3, 4, 12);
imshow(cells_closed3);
title('closed with disk');

% Find a good combination
combination_disk = strel('disk',2);
cells_complete = imopen(imclose(cells_niblack, combination_disk), combination_disk); % just an example, there might be better combinations
figure;
imshow(cells_complete); 
disp(a.combination);

end
