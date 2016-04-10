function p = parameters()
	p.dataset = 'house'; % library
	p.outfilename = 'house_matches_harris.mat';
	p.random_seed = 42;
	p.harris.sigma = 1.0;
	p.harris.threshold = 1000;
	p.distance_threshold = 0.06;
	p.maglap.windowsize = 41;
	p.maglap.sigma = 2.0;
	p.maglap.n_bins = 16;
	p.ransac.epsilon = 2.0;
	p.ransac.n_iterations = 200;
end
