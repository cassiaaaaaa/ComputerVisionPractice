function [Idx, Dist] = findnn(D1, D2)
    query_num = size(D1, 1);
	model_num = size(D2, 1);
    
    Idx = zeros(query_num, 1);
    Dist = zeros(query_num, 1);
    
    for q_idx = 1:query_num
        ext_model = repmat(D1(q_idx, :), model_num, 1);
        [val, idx] = min(sqrt(sum((ext_model - D2) .^ 2, 2)));
        Idx(q_idx) = idx;
        Dist(q_idx) = val;
    end
end
