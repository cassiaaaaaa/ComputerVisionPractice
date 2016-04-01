function res = thresh_otsu(img)
	img_hist = histogram(img);
    img_cum = cumsum(img_hist);
    
    max_var = -1;
    th = 1;
    
    for pt = 1:254
        wm_1 = weighted_mean(img_hist, 1, pt);
        wm_2 = weighted_mean(img_hist, pt + 1, 255);
        local_var = img_cum(pt) * (img_cum(255) - img_cum(pt)) ...
            * (wm_1 - wm_2) ^ 2;
        
        if local_var > max_var
            max_var = local_var;
            th = pt;
        end
    end
    
    res = img < th;
end