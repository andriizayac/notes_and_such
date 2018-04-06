library(rstan)
library(rstanarm)
library(shinystan)
library(devtools)
library(StanHeaders)
library(ggplot2)
rstan_options(auto_write = T)
options(mc.cores = parallel::detectCores())

list33 <- list(growth = dat_list3$growth,
                   sizet = dat_list3$size,
                   sizemat = dat_list3$sizemat,
                   distmat = dat_list3$distmat,
                   climmat = dat_list3$climmat,
                   N = length(dat_list3$growth))
#comp_index=rowSums((list33$sizemat)/(list33$distmat^2), na.rm =T)
#list33$comp_index <- comp_index
list33$distmat <- ifelse(is.na(list33$sizemat) == T, NA,list33$distmat)
list33$climmat <- ifelse(is.na(list33$sizemat) == T, NA,list33$climmat)     
#list33$climmat <- ifelse(list33$climmat == 0, NA, list33$climmat)
list33$N <- length(dat_list3$growth)
list33$pmat <- ifelse(is.na(list33$sizemat)==T,0,1)
###################################################
rt <- stanc(file = "test1.stan", model_name = "fit4")
sm <- stan_model(stanc_ret = rt, verbose = T)
fit3 <- sampling(sm, data = list02, iter = 2000, chains = 4)
   #####################################################

list01$sizemat <- ifelse(is.na(list01$sizemat) ==T,0,list01$sizemat)
list01$distmat <- ifelse(is.na(list01$distmat) ==T,0,list01$distmat)
list01$climmat <- ifelse(is.na(list01$climmat) ==T,0,list01$climmat)

