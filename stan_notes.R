library(rstan)
library(rstanarm)
library(shinystan)

dat_list33 <- list(growth = dat_list3$growth,
                   sizet = dat_list3$size,
                   sizemat = dat_list3$sizemat,
                   distmat = dat_list3$distmat,
                   climmat = dat_list3$climmat,
                   N = length(dat_list3$growth))
comp_index=rowSums((dat_list33$sizemat)/(dat_list33$distmat^2), na.rm =T)

dat_list33$sizemat <- ifelse(is.na(dat_list33$sizemat) == T, 0,dat_list33$sizemat)
dat_list33$distmat <- ifelse(is.na(dat_list33$distmat) == T, 0,dat_list33$distmat)                             
dat_list33$N <- length(dat_list3$growth)

rt <- stanc(file = "test.stan", model_name = "t")

sm <- stan_model(stanc_ret = rt, verbose = T)

fit <- sampling(sm, data = dat_list33, iter = 2000, chains = 4)
