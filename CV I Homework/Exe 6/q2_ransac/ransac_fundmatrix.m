function [F, e1, e2, xi1, xi2] = ransac_fundmatrix(x1, x2, eps, k)
    num = size(x1,2);
    seeds_num = 8;
    
    nbr_inliers = seeds_num-1;
    bxi1 = [];
    bxi2 = [];
    
    for idx = 1:k
        perm = randperm(num);
        x1_seeds = x1(:, perm(1:seeds_num));
        x2_seeds = x2(:, perm(1:seeds_num));
        
        [Fp, e1, e2] = normfundmatrix(x1_seeds, x2_seeds);
        
        [xi1, xi2] = get_inliers(Fp, x1, x2, eps);
        
        if size(xi1, 2) > nbr_inliers
            nbr_inliers = size(xi1, 2);
            bxi1 = xi1;
            bxi2 = xi2;
        end
    end
    
    if isempty(bxi1)
        fprintf('ERROR: RANSAC was not able to find a sufficient number of inliers!\n');
    else
        [F, ~, ~] = normfundmatrix(bxi1, bxi2);
        [xi1, xi2] = get_inliers(F, x1, x2, eps);
    end
end
