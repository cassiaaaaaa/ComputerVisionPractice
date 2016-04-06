function result = nms(score)

	%standard nms
	[height, width] = size(score);
	
	result = score;
	for y = 1:height
		for x = 1:width
			minx = max(1,x-1);
			maxx = min(width,x+1);
			miny = max(1,y-1);
			maxy = min(height,y+1);

			window = score(miny:maxy, minx:maxx);
			if score(y,x) < max(window(:))
				result(y,x) = 0;
			end
		end
	end

end
