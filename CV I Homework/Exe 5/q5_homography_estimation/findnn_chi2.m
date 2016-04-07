function [Idx, Dist] = findnn_chi2(D1, D2)
    query_num = size(D1, 1);
	model_num = size(D2, 1);
    
    Idx = zeros(query_num, 1);
    Dist = zeros(query_num, 1);
    
    for q_idx = 1:query_num
        result_table = zeros(model_num, 1);
        for m_idx = 1:model_num
            result_table(m_idx) = hist_dist_chi(D1(q_idx, :), ...
                D2(m_idx, :));
        end
        [Dist(q_idx), Idx(q_idx)] = min(result_table);
    end
end
