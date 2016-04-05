function imgResult = nonmaxsup2d(imgHough)
	imgResult = zeros(size(imgHough));
    
    padHough = padarray(imgHough, [1, 1], 'symmetric');
    
    [height, width] = size(imgHough);
    for i = 1:height
        for j = 1:width
            comp = padHough(i:(i + 2), j:(j + 2)) > imgHough(i, j);
            if ~sum(comp(:))
                imgResult(i, j) = imgHough(i, j);
            end
        end
    end
end
