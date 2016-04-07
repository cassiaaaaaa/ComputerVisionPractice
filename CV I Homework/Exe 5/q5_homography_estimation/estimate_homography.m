function H = estimate_homography(px1, py1, px2, py2)
	% Compute Matrix A
    pnt_num = size(px1, 1);
    A = zeros(pnt_num * 2, 9);
    for idx = 1:pnt_num
        A(2 * idx - 1, :) = [px1(idx), py1(idx), 1, 0, 0, 0, ...
            -px1(idx) * px2(idx), -px2(idx) * py1(idx), -px2(idx)];
        A(2 * idx, :) = [0, 0, 0, px1(idx), py1(idx), 1, ...
            -py2(idx) * px1(idx), -py1(idx) * py2(idx), -py2(idx)];
    end
    
    % Perform SVD
    [~, ~, V] = svd(A);
    
    % Compute h
    h = V(end, :) / V(end);
    
    % Transform h
    H = reshape(h, 3, 3);
end
