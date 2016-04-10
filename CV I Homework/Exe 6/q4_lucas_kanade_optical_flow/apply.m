function [] = apply()
	close all;
	clc;
	format short g;

	a = answers();
	p = parameters();

	disp('Question: Lucas-Kanade Optical Flow');

	% -------------------------------------------------------------------------
	fprintf('\n----- Question a-d - Lucas Kanade -----\n');

	im1 = double(imread(strcat(p.images,'1.png')));
	im2 = double(imread(strcat(p.images,'2.png')));

	disp('Alternatively showing the 1st image and the 2nd image');
	fh1 = figure('Position', [800, 200, 600, 400], 'Name', 'Question 4');
	colormap gray;
	for i=1:5
		imagesc(im1);
		axis equal;
		axis off;
		title('im1');

		pause(.5);
		
		imagesc(im2);
		axis equal;
		axis off;
		title('im2');
		
		pause(.5);
	end
	close(fh1);

	[u, v] = lucas_kanade(im1, im2, p.windowsize.lucas_kanade);
	imflow = flowToColor(u, v);
	fh1 = figure('Position', [200, 200, 600, 400], 'Name', 'Question: Lucas-Kanade');
	image(imflow);
	axis equal;
	axis off;
	title('Flow computed with optical_flow');

	disp('Alternatively showing the warped 1st image and the real 2nd image');
	im1_warped = warp_image(im1, u, v);
	fh2 = figure('Position', [800, 200, 600, 400], 'Name', 'Question: Lucas-Kanade');
	colormap gray;
	for i=1:5
		imagesc(im2);
		axis equal;
		axis off;
		title('im2');
		
		pause(.5);
		
		imagesc(im1_warped);
		axis equal;
		axis off;
		title('im1_{warped}');

		pause(.5);
	end

	close(fh1);
	close(fh2);

	% -------------------------------------------------------------------------
	fprintf('\n----- Question e-f - Iterative Lucas-Kanade -----\n');

	[u, v] = iterative_lucas_kanade(im1, im2, p.windowsize.iterative_lucas_kanade, p.n_iterations);
	fh1 = figure('Position', [200, 200, 600, 400], 'Name', 'Question');
	imflow = flowToColor(u, v);
	image(imflow);
	axis equal;
	axis off;
	title('Flow computed with iterative_lucas_kanade');

	disp('Alternatively showing the warped 1st image and the real 2nd image');
	im1_warped = warp_image(im1, u, v);
	fh2 = figure('Position', [800, 200, 600, 400], 'Name', 'Question');
	colormap gray;
	axis equal;
	for i=1:5
		imagesc(im2);
		axis equal;
		axis off;
		title('im2');
		
		pause(.5);
		
		imagesc(im1_warped);
		axis equal;
		axis off;
		title('im1_warped');
		
		pause(.5);
	end

	close(fh1);
	close(fh2);

	% -------------------------------------------------------------------------
	fprintf('\n----- Question g - Coarse to fine Lucas-Kanade -----\n');

	[u, v, im1, im2] = ctf_lucas_kanade(im1, im2, p.windowsize.ctf_lucas_kanade);
	fh1 = figure('Position', [100, 200, 700, 400], 'Name', 'Question');
	imflow = flowToColor(u, v);
	image(imflow);
	axis equal;
	axis off;
	title('Flow computed with ctf_lucas_kanade');

	disp('Alternatively showing the warped 1st image and the real 2nd image');
	im1_warped = warp_image(im1, u, v);
	fh2 = figure('Position', [800, 200, 700, 400], 'Name', 'Question');
	colormap gray;
	axis equal;

	for i=1:5
		imagesc(im2);
		axis equal;
		axis off;
		title('im2');

		pause(.5);
		
		imagesc(im1_warped);
		axis equal;
		axis off;
		title('im1_warped');

		pause(.5);
	end

	close(fh1);
	close(fh2);
end
