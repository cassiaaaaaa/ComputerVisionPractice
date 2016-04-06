function [rec_rate, error_rate] = ...
    eval_recognition_performance_thres(model_list, query_list, ...
                                       thres, bins, hist_type)
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
    
    thres_num = length(thres);
    rec_rate = zeros(thres_num, 1);
    error_rate = zeros(thres_num, 1);
    true_mat = diag(ones(1, model_num));
    for th_idx = 1:thres_num
        rec_mat = dist_mat < thres(th_idx);
        
        true_comp = rec_mat .* true_mat;
        true_num = sum(true_comp(:));
        rec_rate(th_idx) = true_num / query_num;
        
        err_num = sum(rec_mat(true_mat == 0));
        error_rate(th_idx) = err_num / sum(sum(dist_mat < thres(th_idx)));
    end
end
