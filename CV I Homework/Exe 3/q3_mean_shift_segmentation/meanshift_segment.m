function seg_img = meanshift_segment(img, r)
    img = im2double(img);
    % Transform image into RGB vectors
    [height, width, depth] = size(img);
    rgb_img = reshape(img, height * width, depth)';
    
    % Segmentation
    [labels, peaks] = meanshift_opt(rgb_img, r);
    peak_num = size(peaks, 2);
    label_map = repmat(labels, depth, 1);
    seg_img = label_map;
    
    % Coloring the segmented image
    for label = 1:peak_num
        label_num = sum(label_map(1, :) == label);
        tar_color = repmat(peaks(:, label), label_num, 1);
        seg_img(label_map == label) = tar_color;
    end
    
    seg_img = reshape(seg_img', height, width, depth);
end
