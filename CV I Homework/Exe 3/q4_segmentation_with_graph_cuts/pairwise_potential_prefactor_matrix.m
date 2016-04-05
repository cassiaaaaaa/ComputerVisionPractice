function pairwise_matrix = pairwise_potential_prefactor_matrix(img, ...
    pairwise_weight)
	[height, width, ~] = size(img);
    all_neighbors = 4 * height * width;
    
    from = zeros(all_neighbors, 1);
    to = zeros(all_neighbors, 1);
    cost = zeros(all_neighbors, 1);
    idx = 0;
    
    for i = 1:height
        for j = 1:width
            if j ~= 1
                % Left
                idx = idx + 1;
                from(idx) = coord_transform(height, j, i);
                to(idx) = coord_transform(height, j - 1, i);
                cost(idx) = pairwise_potential_prefactor(img, ...
                    j, i, j - 1, i, pairwise_weight);
            end
            
            if j ~= width
                % Right
                idx = idx + 1;
                from(idx) = coord_transform(height, j, i);
                to(idx) = coord_transform(height, j + 1, i);
                cost(idx) = pairwise_potential_prefactor(img, ...
                    j, i, j + 1, i, pairwise_weight);
            end
            
            if i ~= 1
                % Top
                idx = idx + 1;
                from(idx) = coord_transform(height, j, i);
                to(idx) = coord_transform(height, j, i - 1);
                cost(idx) = pairwise_potential_prefactor(img, ...
                    j, i, j, i - 1, pairwise_weight);
            end
            
            if i ~= height
                % Bottom
                idx = idx + 1;
                from(idx) = coord_transform(height, j, i);
                to(idx) = coord_transform(height, j, i + 1);
                cost(idx) = pairwise_potential_prefactor(img, ...
                    j, i, j, i + 1, pairwise_weight);
            end
        end
    end
    
    pairwise_matrix = sparse(from(1:idx), to(1:idx), cost(1:idx));
end
