function apply_slide()
	close all;
	clc;
	
	%parameters
	p = parameters();
	if rem(p.cellsize,2)
		error('The parameter cellsize must be divisable by 2');
	end
	a = answers();

	% list images
	positive_images = dir('TrainImages/pos*.pgm');
	negative_images = dir('TrainImages/neg*.pgm');
	
	%look at hoglike descriptor
	figure
    title('hoglike-img example');
	subplot(2,2,1)
	img = positive_images(1);
	img_data = imread(['TrainImages/', img.name]);
	imagesc(img_data);
	colormap('gray');
	axis equal;
	hog = calculate_hoglike(img_data, p.cellsize, p.n_bins, p.sigma, p.offset_lr, p.offset_tb, p.interpolation);
	subplot(2,2,3)
	imagesc(render_hogimage(hog,50));
	colormap('gray');
	axis equal;
	
	subplot(2,2,2)
	img = negative_images(1);
	img_data = imread(['TrainImages/', img.name]);
	imagesc(img_data);
	colormap('gray');
	axis equal;
	hog = calculate_hoglike(img_data, p.cellsize, p.n_bins, p.sigma, p.offset_lr, p.offset_tb, p.interpolation);
	subplot(2,2,4)
	imagesc(render_hogimage(hog,50));
	colormap('gray');
	axis equal;
	disp(a.hoglike_descriptor);
	disp(a.bilinear_interpolation);

	% structures for images
	img = positive_images(1);
	img_data = imread(['TrainImages/', img.name]);
	hog = calculate_hoglike(img_data, p.cellsize, p.n_bins, p.sigma, p.offset_lr, p.offset_tb, p.interpolation);
	[ny_bins, nx_bins, ~] = size(hog);
	vector_dimension = numel(hog);
	disp(['vector dimension is ', int2str(vector_dimension)]);
	
	positive_samples = zeros(size(positive_images,1),vector_dimension);
	negative_samples = zeros(size(negative_images,1),vector_dimension);
	
	% read positive ...
	disp('loading positive samples');
	idx = 0;
	for img = positive_images'
		idx = idx + 1;
		% disp(idx);
		img_data = imread(['TrainImages/', img.name]);
		hog = calculate_hoglike(img_data, p.cellsize, p.n_bins, p.sigma, p.offset_lr, p.offset_tb, p.interpolation);
		positive_samples(idx,:) = double(reshape(hog,1,vector_dimension));
	end
	disp([int2str(size(positive_samples,1)),' positive samples loaded']);
	
	% ... and negative images
	disp('loading negative samples');
	idx = 0;
	for img = negative_images'
		idx = idx + 1;
		% disp(idx);
		img_data = imread(['TrainImages/', img.name]);
		hog = calculate_hoglike(img_data, p.cellsize, p.n_bins, p.sigma, p.offset_lr, p.offset_tb, p.interpolation);
		negative_samples(idx,:) = double(reshape(hog,1,vector_dimension));
	end
	disp([int2str(size(negative_samples,1)),' negative samples loaded']);
	
	%train the SVM
	disp('training SVM');
	samples = [positive_samples; negative_samples];
	targets = [ repmat(p.car,size(positive_samples,1),1) ; repmat(p.no_car, size(negative_samples,1),1)];
	SVMStruct = svmtrain(samples, targets);

	% single testimage
	figure
    title('single test image');
	img_data = imread('TestImages/test-10.pgm');
	hog = calculate_hoglike(img_data, p.cellsize, p.n_bins, p.sigma, p.offset_lr, p.offset_tb, p.interpolation);
	subplot(3,1,1)
	imagesc(render_hogimage(hog, 50));
	colormap('gray');
	axis equal;
	subplot(3,1,2)
	score = object_hypothesis(SVMStruct, hog, ny_bins, nx_bins);
	imagesc(score);
	colormap('gray');
	axis equal;
	subplot(3,1,3)
	[y,x,score] = detect_objects(score, p.thresh);
	imagesc(img_data);
	colormap('gray');
	axis equal;
	for i = 1:size(y,1)
		rectangle('Position', [x(i)*p.cellsize,y(i)*p.cellsize, nx_bins*p.cellsize, ny_bins*p.cellsize], 'EdgeColor', 'r');
		text(x(i)*p.cellsize + 1, y(i)*p.cellsize + 2, num2str(score(i)), 'Color', 'r');
	end
	disp(a.detection);

	%read test images
	test_images = dir('TestImages/*.pgm');
	for idx = p.display_test
		img = test_images(idx);
		img_data = imread(['TestImages/', img.name]);
		disp(['processing image ', img.name]);
	
		figure
        title('on test img');
		hog = calculate_hoglike(img_data, p.cellsize, p.n_bins, p.sigma, p.offset_lr, p.offset_tb, p.interpolation);
		subplot(3,1,1)
		imagesc(render_hogimage(hog, 50));
		colormap('gray');
		axis equal;
		subplot(3,1,2)
		score = object_hypothesis(SVMStruct, hog, ny_bins, nx_bins);
		imagesc(score);
		colormap('gray');
		axis equal;
		subplot(3,1,3)
		[y, x, score] = detect_objects(score, p.thresh);
		imagesc(img_data);
		colormap('gray');
		axis equal;
		for i = 1:size(y, 1)
			rectangle('Position', [(x(i) - 1) * p.cellsize + 1, (y(i) - 1) * p.cellsize + 1, nx_bins * p.cellsize, ny_bins * p.cellsize], 'EdgeColor', 'r');
			text((x(i) - 1) * p.cellsize + 2, (y(i) - 1) * p.cellsize + 5, num2str(score(i)), 'Color', 'r');
		end
	end

end
