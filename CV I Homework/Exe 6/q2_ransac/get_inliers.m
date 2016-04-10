function [x1, x2] = get_inliers(F, x1, x2, eps)
    x1 = x1 ./ repmat(x1(3, :), 3, 1);
    x2 = x2 ./ repmat(x2(3, :), 3, 1);
    
    l1 = F' * x2;
    l2 = F * x1;
    
    l1 = l1 ./ repmat(sqrt(sum(l1(1:2, :) .^ 2)), 3, 1);
    l2 = l2 ./ repmat(sqrt(sum(l2(1:2, :) .^ 2)), 3, 1);
    
    dists1 = abs(sum(l1 .* x1));
    dists2 = abs(sum(l2 .* x2));
    inlier_idx = find((dists1 < eps) & (dists2 < eps));
    x1 = x1(:,inlier_idx);
    x2 = x2(:,inlier_idx);
end
