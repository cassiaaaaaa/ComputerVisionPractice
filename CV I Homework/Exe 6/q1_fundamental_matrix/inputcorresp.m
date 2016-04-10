function [x1, x2] = inputcorresp(img1, img2, N)
	img = horzcat(img1, img2);
    figure;
    imshow(img);

    fprintf('Please input %d points correspondences by alternatingly clicking on a point in the\nleft image and the corresponding point in the right image.\n', N);

    [x, y] = ginput(2 * N);

    j = (x > size(img1, 2));
    i = (x <= size(img1, 2));
    x1 = [x(i), y(i)]';
    x2 = [x(j) - size(img1, 2), y(j)]';

    x1(3, :) = 1;
    x2(3, :) = 1;
end
