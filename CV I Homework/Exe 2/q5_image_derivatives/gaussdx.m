function derivative = gaussdx(x, sigma)
    derivative = -exp(- (x .^ 2) / (2 * sigma ^ 2)) .* x ...
        / (sqrt(2 * pi) * sigma ^ 3);
end
