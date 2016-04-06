function [rec_rate, error_rate] = ...
    eval_recognition_performance(model_list, query_list, bins, hist_type)
	model_hists = allhist(model_list, hist_type, bins);
    model_num = size(model_hists, 1);
    
    query_hists = allhist(query_list, hist_type, bins);
    query_num = size(query_hists, 1);
    
    dist_mat = zeros(model_num, query_num);
    for m_idx = 1:model_num
        for q_idx = 1:query_num
            dist_mat(m_idx, q_idx) = ...
                hist_dist_chi(model_hists(m_idx, :), ...
                              query_hists(q_idx, :));
        end
    end
    
    [~, min_idx] = min(dist_mat);
    comp = min_idx - 1:model_num;
    error_rate = sum(comp ~= 0) / model_num;
    rec_rate = 1 - error_rate;
end
