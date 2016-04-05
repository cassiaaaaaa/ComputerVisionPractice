function peak = findpeak(data, idx, r)
	[dim, num] = size(data);
    curr_center = data(:, idx);
    while true
        % Find all the points within the window
        pnt_sum = zeros(dim, 1);
        pnt_count = 0;
        for pnt_idx = 1:num
            if norm(data(:, pnt_idx) - curr_center) <= r
                pnt_sum = pnt_sum + data(:, pnt_idx);
                pnt_count = pnt_count + 1;
            end
        end
        
        % Update center
        if pnt_count == 0
            peak = data(:, idx);
            return
        end

        new_center = pnt_sum / pnt_count;
        if norm(new_center - curr_center) < 0.1
            peak = new_center;
            break;
        else
            curr_center = new_center;
        end
    end
end
