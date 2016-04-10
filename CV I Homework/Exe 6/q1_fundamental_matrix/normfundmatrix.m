function [F, e1, e2] = normfundmatrix(x1, x2)
	[norm_x1, T1] = normalize2dpts(x1);
    [norm_x2, T2] = normalize2dpts(x2);
    
    [F, ~, ~] = fundmatrix(norm_x1, norm_x2);
    F = T2' * F * T1;
    
    [U, ~, V] = svd(F);
    e1 = V(:, end)' / V(end);
    e2 = U(:, end)' / U(end);
end
