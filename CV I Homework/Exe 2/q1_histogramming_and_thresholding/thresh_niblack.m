function res = thresh_niblack(img, r, k)
    % Edge handling
	pad = padarray(img, [r, r], 'symmetric');
    
    [height, width] = size(img);
    res = zeros(size(img));
    
    for i = 1:height
        for j = 1:width
            [m, v] = get_window_mean_var(pad, i + r, j + r, r);
            local_th = m + k * sqrt(v);
            res(i, j) = img(i, j) < local_th;
        end
    end
end
