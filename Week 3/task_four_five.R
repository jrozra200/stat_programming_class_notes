#####################
## DATE: 2/6/2017  ##
## TASK 4          ##
#####################

## PROBLEM 1

HHStudy <- read_excel("HHSTUDY2.xls")
head(HHStudy)
tail(HHStudy)
dim(HHStudy)

## PROBLEM 3

plot(HHStudy$CHOL ~ HHStudy$`AGE `, main = "Cholesterol Level BY Age", 
     xlab = "Age", ylab = "Cholesterol Level")


#####################
## DATE: 2/6/2017  ##
## TASK 5          ##
#####################

## PROBLEM 1

par(mfrow = c(1, 2))
plot(HHStudy$CHOL[HHStudy$SMOKE == 0] ~ HHStudy$`AGE `[HHStudy$SMOKE == 0], 
     main = "Cholesterol Level BY Age (Non-Smokers)", 
     xlab = "Age", ylab = "Cholesterol Level")
plot(HHStudy$CHOL[HHStudy$SMOKE == 1] ~ HHStudy$`AGE `[HHStudy$SMOKE == 1], 
     main = "Cholesterol Level BY Age (Smokers)", 
     xlab = "Age", ylab = "Cholesterol Level")

## PROBLEM 2

par(mfrow = c(1, 1))
plot(HHStudy$CHOL ~ HHStudy$`AGE `, type = "n", main = "Cholesterol Level BY Age", 
     xlab = "Age", ylab = "Cholesterol Level")
points(HHStudy$CHOL[HHStudy$SMOKE == 0] ~ HHStudy$`AGE `[HHStudy$SMOKE == 0], 
     pch = "N", col = "pink")
abline(lm(HHStudy$CHOL[HHStudy$SMOKE == 0] ~ HHStudy$`AGE `[HHStudy$SMOKE == 0]), 
       col = "pink")
points(HHStudy$CHOL[HHStudy$SMOKE == 1] ~ HHStudy$`AGE `[HHStudy$SMOKE == 1], 
     pch = "S", col = "black")
abline(lm(HHStudy$CHOL[HHStudy$SMOKE == 1] ~ HHStudy$`AGE `[HHStudy$SMOKE == 1]), 
       col = "black")
legend("topleft", pch = "NS", col = c("pink", "black"), 
       legend = c("NON-SMOKER", "SMOKER"), cex = 0.8)
