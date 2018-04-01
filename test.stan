functions{
    vector row_sums(matrix X) {
	  vector[rows(X)] s ;	
	  for (i in 1:rows(X)) s[i] = sum(row(X, i)) ;
	  return s ;
    }
}
data {
  int <lower = 0> N;      //number of observations
  row_vector <lower=0, upper=1> [476] pmat[N] ; //presence/absence matrix
	row_vector[N] growth; 				//response
	row_vector[N] sizet; 				//predictor
	//vector[N] comp_index;   //predictor calculated index
	row_vector [476] climmat[N];      //predictor
	row_vector <lower = 0> [476] sizemat[N]; 			// neighbor size matrix
	row_vector <lower = 0> [476] distmat[N]; 			// distnace to neighbors matrix
}
parameters {
	real I; 					// intercept
	real a;						// scaling parameter
	real b;
	real target_sizet;			// focal pl size effect
	real<lower = 0> sigma;					// standard deviation
}
model{
  I ~ normal(1,10);
  a ~ uniform(-5,5);
  b ~ normal(1,2);
  target_sizet ~ normal(1,3);
  sigma ~ normal(5,10);
  comp = row_vector [N];
	//growth ~ normal(I + sizet*target_size + row_sums(sizemat ./ exp(distmat*b)), sigma);
	//growth ~ normal(I + sizet*target_size + b*comp_index, sigma);
	
	for (n in 1:N){
	  for (i in 1:476)
	  if (pmat[n,i] == 1){
	  row_vector[n] comp = (sizemat[n] ./ (distmat[n]*b));// .* pmat[n] ;
	  real c = sum(comp);
	  growth[n] ~ normal(I + sizet[n] * target_sizet + a*c, sigma);
	}
	}
	  //growth ~ normal(I + sizet * target_sizet + a*comp[n], sigma); 
}
