function [] = follow_edge(x, y)
    global visited;
    global img_res;
    
    visited(x, y) = true;
    img_res(x, y) = 1;
    
	offx = [1 1 0 -1 -1 -1 0 1];
	offy = [0 1 1 1 0 -1 -1 -1];
	for i=1:8
		idx_x = x+offx(i);
		idx_y = y+offy(i);
		if visited(idx_x,idx_y) == false
			follow_edge(idx_x,idx_y);
        end
    end
    
end
