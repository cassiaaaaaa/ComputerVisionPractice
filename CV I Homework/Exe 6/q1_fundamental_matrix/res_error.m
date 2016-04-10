function error = res_error(F, x1, x2)
    x1 = x1 ./ repmat(x1(3, :), 3, 1);
    x2 = x2 ./ repmat(x2(3, :), 3, 1);
    
    % calculate the distance to the projection
    L = (F * x1)';
    L = L ./ repmat(sqrt(sum(L(:, 1:2) .^ 2, 2)) ,1, 3);
    
    error = mean(sum((L .* x2'), 2) .^ 2);
end
