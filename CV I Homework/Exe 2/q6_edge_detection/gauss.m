function gaussian = gauss(x, sigma)
	gaussian = exp(- (x .^ 2) / (2 * sigma ^ 2)) / (sqrt(2 * pi) * sigma);
end
