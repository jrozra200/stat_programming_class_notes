#####################
## DATE: 2/17/2017 ##
## TASK 3          ##
#####################

## GENERATE THE DATA

## FIRST 9 ARE FROM THE N(10,2) DISTRIBUTION AND THE 10TH FROM N(20,2)
obs <- c(rnorm(9, 10, 2), rnorm(1, 20, 2))

## CALCULATE THE 90% PARAMETRIC CONFIDENCE INTERVAL
## xbar +/- t(9, 0.05) * sqrt(var(obs) / 10)
tupper <- mean(obs) + qt(0.05, 9, lower.tail = FALSE) * sqrt(var(obs) / 10)
tlower <- mean(obs) - qt(0.05, 9, lower.tail = FALSE) * sqrt(var(obs) / 10)

print(paste("Parametric 90% CI: (", tlower, ", ", tupper, ")", sep = ""))

## CALCULATE THE 90% BOOTSTRAP CI FOR THE MEAN
obs_samp <- replicate(10000, sample(obs, replace = TRUE))
obs_samp_means <- apply(obs_samp, 2, mean)
boot_lower <- quantile(obs_samp_means, 0.05)
boot_upper <- quantile(obs_samp_means, 0.95)

print(paste("Bootstrap 90% CI: (", boot_lower, ", ", boot_upper, ")", sep = ""))

## CALCULATE THE 90% BOOTSTRAP CI FOR THE THIRD QUANTILE
obs_samp <- replicate(10000, sample(obs, replace = TRUE))
obs_samp_75 <- apply(obs_samp, 2, quantile, probs = 0.75)
boot_lower_75 <- quantile(obs_samp_75, 0.05)
boot_upper_75 <- quantile(obs_samp_75, 0.95)

print(paste("Bootstrap 90% CI: (", boot_lower_75, ", ", boot_upper_75, ")", sep = ""))
