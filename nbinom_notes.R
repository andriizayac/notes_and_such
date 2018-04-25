byr <- BYRSCR
byr$sizet = ifelse(is.na(byr$SIZE)==T, 0,byr$SIZE)
byr$dist = ifelse(is.na(byr$DIST)==T, 1,byr$DIST)
byr$N=780

model1=stan(file="Dispersal.stan",
            model_name="model1",
            data = byr,
            pars=c("I","a0","a1","k"),
            chains = 4, iter = 20)
