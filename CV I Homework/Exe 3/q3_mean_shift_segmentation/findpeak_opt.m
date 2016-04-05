function [peak, cpts] = findpeak_opt(data, idx, r)
	[~, num] = size(data);
    
    % Initialize necessary variables
    peak = data(:, idx);
    cpts = zeros(1, num);
    r2 = r ^ 2;
    
    curr_center = data(:, idx);
    while true
        % Extend center point's size to the size of data matrix
        ext_pnt = repmat(curr_center, 1, num);
        
        % Compute the distances between center points and all data points
        distances2 = sum((ext_pnt - data) .^ 2);
        
        % Locate points along the path
        cpts(distances2 <= (r2 / 16)) = 1;
        
        % Compute offset between current center and new center
        new_center = mean(data(:, distances2 <= r2), 2);
        if norm(new_center - curr_center) < 0.1
            peak = new_center;
            break;
        else
            curr_center = new_center;
        end
    end
end
