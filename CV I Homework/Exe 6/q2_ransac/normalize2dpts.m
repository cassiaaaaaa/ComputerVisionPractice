function [newpts, T] = normalize2dpts(pts)
    num = size(pts, 2);
    newpts = ones(3, num);
    
    shift_vec = mean(pts(1:2, :), 2);
    newpts(1:2, :) = pts(1:2, :) - repmat(shift_vec, 1, num);
    
    mean_dist = mean(sqrt(sum(newpts(1:2, :) .^ 2)));
    newpts(1:2, :) = newpts(1:2, :) * sqrt(2) / mean_dist;
    
    T = (pts' \ newpts')';
end
