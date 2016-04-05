function [labels, peaks] = meanshift_opt(data, r)
	[dim, num] = size(data);
    
    labels = zeros(1, num);
    peaks = zeros(dim, num);
    
    label_count = 0;
    for pnt_idx = 1:num
        if labels(pnt_idx) == 0
            % Compute peak and path for this point
            [peak, cpts] = findpeak_opt(data, pnt_idx, r);
            ext_peak = repmat(peak, 1, label_count);
            
            % Compute assignment for this peak
            assign = sqrt(sum((peaks(:, 1:label_count) - ext_peak) .^ 2));
            assign_idx = find(assign < r / 2, 1);
            if size(assign_idx, 2) ~= 0
                assigned_label = assign_idx;
            else
                label_count = label_count + 1;
                assigned_label = label_count;
                peaks(:, label_count) = peak;
            end
            
            % Assign label to this point
            cpts(sqrt(sum((data - repmat(peak, 1, num)) .^ 2)) < r) = 1;
            labels(cpts == 1) = assigned_label;
        else
            continue;
        end
    end
    peaks = peaks(:, 1:label_count);
end
