function plot_color_histogram(h_vec)

	bins = nthroot(size(h_vec,2), 3);
	h = reshape(h_vec, [bins, bins, bins]);

	axis([0, bins, 0, bins, 0, bins]);
	axis vis3d;

	vertices = [0 0 0;1 0 0;1 1 0;0 1 0;0 0 1;1 0 1;1 1 1;0 1 1];
	faces = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];

	max_size = max(max(max(h)));

	for r=0:bins-1
		for g=0:bins-1
			for b=0:bins-1
				cubesize = h(r+1, g+1, b+1) / max_size;
				if cubesize > 0
					vert = vertices * cubesize;
					vert = [vert(:, 1) + r vert(:, 2) + g vert(:, 3) + b];
					patch('vertices', vert, 'faces', faces, 'FaceColor', [r, g, b]/bins);
				end
			end
		end
	end
end
