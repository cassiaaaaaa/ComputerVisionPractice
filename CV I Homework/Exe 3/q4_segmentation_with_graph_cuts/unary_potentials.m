function potentials = unary_potentials(probability, unary_weight)
	potentials = -unary_weight * log(probability);
end
