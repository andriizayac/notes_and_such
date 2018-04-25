
functions{
  vector row_sums(matrix X) {
    vector[rows(X)] s ;	
    for (i in 1:rows(X)) s[i] = sum(row(X, i)) ;
    return s ;
  }
}
data {
  int <lower = 0> N;      //number of observations
  int COUNT [780] ; 				//response
  //matrix[780,79] sizet; 				//predictor
  vector [79] sizet[N];
  //matrix[780,79] dist;      //predictor
  vector [79] dist[N];
  
  //row_vector <lower = 0> [476] distmat[N]; 			// distnace to neighbors matrix
}
parameters {
  real I; 					// intercept
  real a0;					
  real <lower=0> k;
  real a1;			
}
transformed parameters{
  vector <lower=0> [N] mu;
  for( n in 1:N){
    mu[n] = (I + sum(log(exp(a0)*sizet[n]) ./ (exp(a1)+dist[n])));
  }
}
model{
  I ~ normal(1,5);
  a0 ~ normal(1,1);
  k ~ exponential(1);
  a1 ~ normal(1,1);
  
  //COUNT ~ nbinom(exp(I+row_sums(log(exp(a0)*sizet)./(exp(a1)+dist), size=exp(k));
  
  for (n in 1:N){
        //COUNT[n] ~ neg_binomial(exp(I + sum(log(exp(a0)*sizet[n]) ./ (exp(a1)*dist[n]))),k);
        COUNT[n] ~ neg_binomial(mu[n],k);
      }
}
generated quantities{
  //vector[N] log_lik;
  //for(n in 1:N){
  //   log_lik[n] = neg_binomial(COUNT[n] | exp(I + sum(log(exp(a0)*sizet[n]) ./ (exp(a1)+dist[n]))),k);
  //}
}
