function skew_sym = skew_symmetric3(v)
	skew_sym = zeros(3, 3);
    skew_sym(1, 2) = -v(3);
    skew_sym(1, 3) = v(2);
    skew_sym(2, 1) = v(3);
    skew_sym(2, 3) = -v(1);
    skew_sym(3, 1) = -v(2);
    skew_sym(3, 2) = v(1);
end
