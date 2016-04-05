function [labels, peaks] = meanshift(data, r)
    [dim, num] = size(data);
    
    labels = zeros(1, num);
    peaks = ones(dim, num) * Inf;
    
    curr_idx = 0;
    for pnt_idx = 1:num
        % Setting initial label
        pnt_label = curr_idx + 1;
        
        % Compute peak
        peak = findpeak(data, pnt_idx, r);
        
        % Update label according to peak
        for idx = 1:num
            if data(1, idx) == Inf
                break;
            elseif norm(data(:, pnt_idx) - peaks(:, idx)) < r / 2
                pnt_label = idx;
                break;
            else
                continue;
            end
        end
        
        labels(pnt_idx) = pnt_label;
        if pnt_label == curr_idx + 1
            curr_idx = pnt_label;
        end
        
        % Setting peak assignment
        peaks(:, pnt_idx) = peak;
    end
end
