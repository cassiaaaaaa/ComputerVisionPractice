function drawpoints(img, px, py, color)
% can also be used as: drawpoints(img, px, py)

    if nargin<4
        color='y';
    end
    colormap('gray'); imagesc(img); hold on; axis equal; axis off;
    for i=1:length(px)
        plot( px(i),py(i),strcat(color,'+') );
    end
    hold off;
end
