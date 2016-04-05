function edge_image = my_canny(img, sigma, theta_low, theta_high)
    global visited;
    global img_res;

    [img_mag, img_dir] = gradmag(img, sigma);
    img_max = nonmaxsupcanny(img_mag, img_dir);

    max_pix = max(img_max(:));
    theta_low = theta_low * max_pix;
    theta_high = theta_high * max_pix;

    visited = img_max < theta_low;
    high = img_max >= theta_high;

    visited(:, 1) = true;
    visited(:, end) = true;
    visited(1, :) = true;
    visited(end, :) = true;
    
    [height, width] = size(high);
    for i = 1:height
        for j = 1:width
            if (high(i, j) && ~visited(i, j))
                follow_edge(i, j);
            end
        end
    end
    
    edge_image = img_res;
end
