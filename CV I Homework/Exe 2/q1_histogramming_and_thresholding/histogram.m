function hist = histogram(img)
    hist = zeros(1, 256);
    
    [height, width] = size(img);
    
    for i = 1:height
        for j = 1:width
            hist(img(i, j)) = hist(img(i, j)) + 1;
        end
    end
end
