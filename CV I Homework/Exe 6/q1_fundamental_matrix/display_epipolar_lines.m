function display_epipolar_lines(x, L, I, e)
    % Input:
    %     x: 3xN matrix of points
    %     L: 3xN matrix of lines
    %     I: an image
    %
    % Display the epipolar lines L and their corresponding points x
    % in the image I

    % find points on epipolar lines L closest to the points in x
    L = L ./ repmat(sqrt(L(1,:).^2 + L(2,:).^2), 3, 1); % rescale the line
    pt_line_dist = sum(L .* x);
    closest_pt = x(1:2, :) - L(1:2,:) .* repmat(pt_line_dist, 2, 1);

    % find endpoints of segment on epipolar line (for display purposes)
    pt1 = closest_pt - [L(2,:); -L(1,:)] * 10; % offset from the closest point is 10 pixels
    pt2 = closest_pt + [L(2,:); -L(1,:)] * 10;

    % display points and segments of corresponding epipolar lines
    imshow(I); hold on;
    plot(x(1,:), x(2,:), '+r');
    line([x(1,:)' closest_pt(1,:)']', [x(2,:)' closest_pt(2,:)']', 'Color', 'r');
    line([pt1(1,:)' pt2(1,:)']', [pt1(2,:)' pt2(2,:)']', 'Color', 'g');
    
    if(nargin>3)
        if(e(1)<size(I,2) && e(2)<size(I,1)) % if inside image display epipolar point
            hold on; plot(e(1),e(2),'b*');
        end
    end
end
