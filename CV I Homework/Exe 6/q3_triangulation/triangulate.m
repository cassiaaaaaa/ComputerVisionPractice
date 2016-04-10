function X = triangulate(P1, x1, P2, x2)
	A1 = skew_symmetric3(x1) * P1;
	A2 = skew_symmetric3(x2) * P2;

	A = [A1(1:2, :); ...
	     A2(1:2, :)];

	[~, ~, V] = svd(A);
	X = V(:, end);
	X = X ./ X(4);
end
