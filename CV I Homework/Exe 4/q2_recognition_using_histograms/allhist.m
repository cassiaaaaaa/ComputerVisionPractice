function histograms = allhist(model, hist_type, bins)
	% files: filename of txt file with list of images
	% hist_type: type of histgram to compute ('RGB','rg','dxdy')
	% bins:	number of bins

	files=textread(model,'%s');
	histograms = 0;
	switch hist_type
		case 'RGB'
			histograms=zeros(size(files,1), bins^3);
		case 'rg'
			histograms=zeros(size(files,1), bins^2);
		case 'dxdy'
			histograms=zeros(size(files,1), bins^2);
		otherwise
	end
	for i=1:size(files,1)
		filename=char(files(i));
		switch hist_type
			case 'RGB'
				h=myhist2(filename, bins);
			case 'rg'
				h=myhist3(filename, bins);
			case 'dxdy'
				h=myhist4(filename, bins);
			otherwise
		end
		histograms(i,:) = h;
	end
end
