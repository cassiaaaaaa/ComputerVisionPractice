function seg_img = meanshift_segment_luv_pos(img, r)
    img = im2double(img);
    % Transform image into RGB vectors
    [height, width, depth] = size(img);
    rgb_img = reshape(img, height * width, depth)';
    
    % Convert RGB vectors into LUV vectors
    luv_img = rgb2luv(rgb_img);
    
    % Add position information to luve image
    luv_pos_img = zeros(depth + 2, height * width);
    x_coor = repmat(1:width, height, 1);
    luv_pos_img(1, :) = x_coor(:);
    luv_pos_img(2, :) = repmat(1:height, 1, width);
    luv_pos_img(3:end, :) = luv_img;
    
    % Segmentation
    [labels, peaks] = meanshift_opt(luv_pos_img, r);
    peak_num = size(peaks, 2);
    label_map = repmat(labels, depth, 1);
    seg_img = label_map;
    
    % Delete position information from peaks
    peaks = peaks(3:end, :);
    
    % Convert peaks from LUV space back into RGB space
    peaks = luv2rgb(peaks);
    
    % Coloring the segmented image
    for label = 1:peak_num
        label_num = sum(label_map(1, :) == label);
        tar_color = repmat(peaks(:, label), label_num, 1);
        seg_img(label_map == label) = tar_color;
    end
    
    seg_img = reshape(seg_img', height, width, depth);
end
