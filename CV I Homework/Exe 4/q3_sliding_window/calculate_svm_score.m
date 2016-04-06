function score = calculate_svm_score(svm, vectors)
	sv = svm.SupportVectors;
	alphaHat = svm.Alpha;
	bias = svm.Bias;
	kfun = svm.KernelFunction;
	kfunargs = svm.KernelFunctionArgs;
	
	score = kfun(sv, vectors, kfunargs{:})'*alphaHat(:) + bias;
end
