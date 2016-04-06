function img = render_hogcell(cell, output_size)

	img = zeros(output_size);
	
	n_bins = size(cell,2);
	% rescale for nice display
	cell = log(cell + 1);
	radius = (0.6 * output_size/2);
	angle = linspace(pi/(2 * n_bins), pi-pi/(2*n_bins), n_bins) + pi/2;
	
	[x_coordinates, y_coordinates] = pol2cart(angle, radius);
	
	for i = 1:size(cell,2)
		center = output_size/2;
		x = linspace(center - x_coordinates(i), center + x_coordinates(i), 10 * output_size);
		y = linspace(center - y_coordinates(i), center + y_coordinates(i), 10 * output_size);
		indices = sub2ind(size(img), round(y), round(x));
		img(indices) = cell(i);
	end
	
end
