functions{
    vector row_sums(matrix X) {
	vector[rows(X)] s ;	
	for (i in 1:rows(X)) s[i] = sum(row(X, i)) ;
	return s ;
  }
}
data {
  int N;
	vector[N] growth; 				//response
	vector[N] sizet; 				//predictor
	matrix <lower = 0.01> [N,476] sizemat; 			// neighbor size matrix
	matrix <lower = 0.01> [N,476] distmat; 			// distnace to neighbors matrix
}
parameters {
	real I; 					// intercept
	real b;						// scaling parameter
	real a;
	real target_size;			// focal pl size effect
	real<lower = 0> sigma;					// standard deviation
}
model{
  I ~ normal(1,10);
  target_size ~ normal(1,10);
  a ~ normal(1,10);
  b ~ normal(1,10)
	growth ~ normal(I + sizet*target_size + row_sums(sizemat ./ exp(distmat*b)), sigma);
	//growth ~ normal(I + a*sizet ./ exp(target_size*sizet), sigma);
}
