functions{
  vector row_sums(matrix X) {
    vector[rows(X)] s ;	
    for (i in 1:rows(X)) s[i] = sum(row(X, i)) ;
    return s ;
  }
}
data {
  int <lower = 0> N;      //number of observations
  matrix <lower=0, upper=1> [N,476] pmat; //presence/absence matrix
  real growth[N]; 				//response
  real sizet[N]; 				//predictor
  //vector[N] comp_index;   //predictor calculated index
  matrix [N,476] climmat;      //predictor
  matrix <lower = 0> [N,476] sizemat; 			// neighbor size matrix
  matrix <lower = 0> [N,476] distmat; 			// distnace to neighbors matrix
}
parameters {
  real I; 					// intercept
  real a;						// scaling parameter
  real b;
  real target_sizet;			// focal pl size effect
  real<lower = 0> sigma;					// standard deviation
}
model{
  matrix [N,476] comp;
  I ~ normal(1,10);
  a ~ uniform(-5,5);
  b ~ normal(1,2);
  target_sizet ~ normal(1,3);
  sigma ~ normal(5,10);
  
  //growth ~ normal(I + sizet*target_size + row_sums(sizemat ./ exp(distmat*b)), sigma);
  //growth ~ normal(I + sizet*target_size + b*comp_index, sigma);
  comp = (sizemat ./ exp(distmat*b)) .* pmat ;
  for (n in 1:N){
    //for (i in 1:476){
      //if(pmat[n,i] == 1){
        
        growth[n] ~ normal(I + sizet[n] * target_sizet + a*sum(comp[n]), sigma);
      //}
    //}
  }
}
generated quantities{
 
}
