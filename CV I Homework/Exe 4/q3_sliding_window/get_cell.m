function [cell_x, cell_y, weight] = get_cell(image_height, image_width, cellsize, x, y)
	cell_x = zeros(4,1);
	cell_y = zeros(4,1);
	weight = zeros(4,1);
	n_cells = 0;

	n_cells_x = floor(image_width/cellsize);
	n_cells_y = floor(image_height/cellsize);

	%simple assignment
	selected_cell_x = floor((x-1)/cellsize) + 1;
	selected_cell_y = floor((y-1)/cellsize) + 1;

	%out of bounds check
	if ~(selected_cell_x > n_cells_x || selected_cell_y > n_cells_y)
		n_cells = n_cells + 1;
		cell_x(n_cells) = selected_cell_x;
		cell_y(n_cells) = selected_cell_y;
		weight(n_cells) = 1;
	end

	cell_x = cell_x(1:n_cells);
	cell_y = cell_y(1:n_cells);
	weight = weight(1:n_cells);

end
