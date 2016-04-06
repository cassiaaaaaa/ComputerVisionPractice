function best = histogram_query(model, query, bins)
    % Compute histogram for all models
	model_hists = allhist(model, 'RGB', bins);
    model_num = size(model_hists, 1);
    
    % Compute histogram for query
    query_hist = myhist2(query, bins);
    
    % Compute distances
    distances = zeros(model_num, 1);
    for hist_idx = 1:model_num
        distances(hist_idx) = ...
            hist_dist_chi(model_hists(hist_idx, :), query_hist);
    end
    [~, idx] = min(distances);
    
    % Find the name of the best
    model_file = fopen(model, 'r');
    file_list = textscan(model_file, '%s');
    fclose(model_file);
    best = char(file_list{1}(idx));
end
