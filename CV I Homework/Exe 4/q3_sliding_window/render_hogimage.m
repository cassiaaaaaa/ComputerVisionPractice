function img = render_hogimage(hog, output_size)
	[n_y, n_x, n_bins] = size(hog);
	img = zeros(n_y * output_size, n_x * output_size);
	
	for x = 1:n_x
		for y = 1:n_y
			idx_x = ((x-1)*output_size+1):(x*output_size);
			idx_y = ((y-1)*output_size+1):(y*output_size);
			img( idx_y, idx_x ) = render_hogcell( ...
				reshape(squeeze(hog(y,x,:)),1,n_bins), output_size);
		end
	end
end