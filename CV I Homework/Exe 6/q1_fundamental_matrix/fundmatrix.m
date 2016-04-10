function [F, e1, e2] = fundmatrix(x1, x2)
	num = size(x1, 2);
    
    u = x1(1, :)';
	v = x1(2, :)';

	u_ = x2(1, :)';
	v_ = x2(2, :)';
    A = [u .* u_, u .* v_, u, v .* u_, v .* v_, v, u_, v_, ones(num, 1)];
    
    [~, ~, V] = svd(A);
    F = reshape(V(:, end), 3, 3);
    
    % Force rank-2
    [U, D, V] = svd(F);
    D(end) = 0;
    F = U * D * V';
    
    [U, ~, V] = svd(F);
    e1 = V(:, end)' / V(end);
    e2 = U(:, end)' / U(end);
end
