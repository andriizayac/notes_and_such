set.seed(420)

N <- 100
alpha <- 2.5
beta <- 0.2
sigma <- 6
x <- rnorm(N, 100, 10)
y <- rnorm(N, alpha + beta*x, sigma)


rt <- stanc(file = "8schools.stan", model_name = "lm2")
sm <- stan_model(stanc_ret = rt, verbose = T)

stan_data = list(N=N, x=x,y=y)
fit2 <- sampling(sm, data = stan_data, chains = 4)

posterior <- extract(fit)
str(posterior)


plot(y~x, pch=20)
abline(alpha, beta, col=4, lty=2, lw=2)
abline(lm1, col=2, lty=2, lw=3)
abline( mean(posterior$alpha), mean(posterior$beta), col=6, lw=2) 

for (i in 1:500) {
  abline(posterior$alpha[i], posterior$beta[i], col="gray", lty=1)
} 
abline(alpha, beta, col=4, lty=2, lw=3)

plot(y~x, pch=20)
abline(alpha, beta, col=4, lty=2, lw=2)
abline(lm1, col=2, lty=2, lw=3)
abline( mean(posterior$alpha), mean(posterior$beta), col=6, lw=2) 
for (i in 1:500) {
  abline(posterior$alpha[i], posterior$beta[i], col="gray", lty=1)
} 
abline(alpha, beta, col=4, lty=2, lw=3)




