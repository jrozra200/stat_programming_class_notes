##############################################
## DATE: 2/6/2017                           ##
## PURPOSE: THIS IS THE SCRIPT FROM CLASS 3 ##
##############################################

##############################
## NOTES ON THE HOMEWORK #2 ##
##############################
library(readxl) ## INSTEAD OF xlsx

filename <- paste("~/Desktop/MAT 7500 - Statistical Programming/Week 2/Basebal",
                  "l Salaries - Modified.xlsx", sep = "")
bbsal <- read_excel(filename) ## read_excel IS MUCH FASTER THAN read_xlsx

filename <- paste("~/Desktop/MAT 7500 - Statistical Programming/Week 2/inflati",
                  "on_rates.csv", sep = "")
inflation_data <- read.csv(filename) ## READ IN DATA
inflation_data <- inflation_data[, c(1, 14)] ## JUST TAKE THE YEAR AND AVERAGE
inflation_data$Ave <- gsub("%", "", inflation_data$Ave) ## REMOVE THE PERCENT SIGN
inflation_data$Ave <- as.numeric(inflation_data$Ave) / 100 ## CHANGE IT TO A PROPER VALUE
inflation_data$Ave <- 1 + inflation_data$Ave

inflation_data$Year <- as.numeric(inflation_data$Year)

## OPTIMIZE CALCULATION TO NOT NEED THE SECOND LOOP
for(i in 1:dim(bbsal)[1]){
        bbsal$Salary_2013dollars_real[i] <- bbsal$Salary[i]
        
        if(bbsal$Year[i] < 2013){
                        bbsal$Salary_2013dollars_real[i] <- (
                                bbsal$Salary_2013dollars_real[i] * 
                                        prod(inflation_data$Ave[
                                                inflation_data$Year >= 
                                                        bbsal$Year[i] & 
                                                        inflation_data$Year <= 
                                                                        2012]))
                }
} 

#################
## CLASS NOTES ##
#################

## CONDITIONAL ASSIGNMENT
if(condition) iftrue else iffalse ## DR. POSNER'S PREFERENCE
ifelse(condition, iftrue, iffalse) ## DR. ZHANG (AND MY) PREFERENCE

## FOR LOOP EXAMPLES
## DOES NOT DEAL WITH NA VALUES AND ERRORS
for(i in 1:7){
        if(HIVdata$height[i] > 65){
                cat("A TALL ONE\n")
        } else {
                cat("A SHORT ONE\n")
        }
}

## DEALS WITH THE NA BUT MISLABELS IT
for(i in 1:length(HIVdata$height)){
        if(HIVdata$height[i] > 65 & !is.na(HIVdata$height[i])){
                cat("A TALL ONE\n")
        } else {
                cat("A SHORT ONE\n")
        }
}

## ADDRESSES THE NA APPROPRIATELY
for(i in 1:length(HIVdata$height)){
        if(!is.na(HIVdata$height[i])){
                if(HIVdata$height[i] > 65) {
                        cat("A TALL ONE\n")
                } else {
                cat("A SHORT ONE\n")
                }
        } else {
                cat("Missing Data\n")
        }
}


## WHILE LOOP EXAMPLE
i <- 1
while(i <= length(HIVdata$height)){
        if(HIVdata$height[i] > 65 & !is.na(HIVdata$height[i])){
                cat("A TALL ONE\n")
        } else {
                cat("A SHORT ONE\n")
        }
        i <- i + 1
}

## GRAPHICS

hist(colDat$age) ## BASIC HISTOGRAM 
hist(colDat$age, main = "My First Histogram", xlab = "Age of SAT Students") ## BASIC HISTOGRAM WITH LABELS
hist(colDat$age, main = "My First Histogram", xlab = "Age of SAT Students", breaks = 14:27) ## HISTOGRAM WITH BREAKS
hist(colDat$age, main = "My First Histogram", xlab = "Age of SAT Students", nclass = 10) ## HISTOGRAM WITH BINS
hist(bbsal$Salary, nclass = 40) ## ANOTHER EXAMPLE OF SPECIFYING THE NUMBER OF BINS

boxplot(bbsal$Salary_2013dollars_real) ## BOXPLOT
boxplot(log(bbsal$Salary_2013dollars_real + 1), ## BOXPLOT WITH TITLES
        main = "Log xform of Baseball Salaries \nInflation Adjusted to 2013 dollars") 
boxplot(log(bbsal$Salary_2013dollars_real + 1), ## BOXPLOT WITH TITLES
        main = "Log xform of Baseball Salaries \nInflation Adjusted to 2013 dollars",
        ylab = "Log xform Salary in 2013 $") 
boxplot(log(bbsal$Salary_2013dollars_real + 1) ~ bbsal$League, ## BOXPLOT WITH TITLES BY LEAGUE
        main = "Log xform of Baseball Salaries \nInflation Adjusted to 2013 dollars",
        ylab = "Log xform Salary in 2013 $") 

plot(colDat$Math.SAT, colDat$Verbal.SAT) ## SCATTER PLOT
plot(colDat$Verbal.SAT ~ colDat$Math.SAT) ## ANOTHER WAY TO DO THE SAME THING
plot(colDat$Verbal.SAT ~ colDat$Math.SAT, main = "Verbal SAT by Math SAT", 
     xlab = "Math SAT", ylab = "Verbal SAT") ## WITH TITLES
plot(colDat$Verbal.SAT[colDat$gender == "M"] ~ colDat$Math.SAT[colDat$gender == "M"], 
     main = "Verbal SAT by Math SAT", 
     xlab = "Math SAT", ylab = "Verbal SAT") ## WITH TITLES MALE ONLY
plot(colDat$Verbal.SAT[colDat$gender == "M"] ~ colDat$Math.SAT[colDat$gender == "M"], 
     main = "Verbal SAT by Math SAT", 
     xlab = "Math SAT", ylab = "Verbal SAT", pch = "M", col = "pink") ## MALE WITH SPECIAL CHARACTER
plot(colDat$Verbal.SAT[colDat$gender == "F"] ~ colDat$Math.SAT[colDat$gender == "F"], 
     main = "Verbal SAT by Math SAT", 
     xlab = "Math SAT", ylab = "Verbal SAT", pch = "F", col = "blue") ## FEMALE WITH SPECIAL CHARACTER

plot(colDat$Verbal.SAT[colDat$gender == "M"] ~ colDat$Math.SAT[colDat$gender == "M"], 
     main = "Verbal SAT by Math SAT", xlab = "Math SAT", ylab = "Verbal SAT", 
     pch = "M", col = "pink") ## MALE WITH SPECIAL CHARACTER
points(colDat$Verbal.SAT[colDat$gender == "F"] ~ colDat$Math.SAT[colDat$gender == "F"], 
     pch = "F", col = "blue") ## FEMALE WITH SPECIAL CHARACTER

## GETTING THE PLOT LOOKING BETTER
plot(colDat$Verbal.SAT ~ colDat$Math.SAT, type = "n", xlab = "Math SAT Score", 
     ylab = "Verbal SAT Score")
points(colDat$Verbal.SAT[colDat$gender == "M"] ~ colDat$Math.SAT[colDat$gender == "M"], 
     main = "Verbal SAT by Math SAT", xlab = "Math SAT", ylab = "Verbal SAT", 
     pch = "M", col = "pink") ## MALE WITH SPECIAL CHARACTER
points(colDat$Verbal.SAT[colDat$gender == "F"] ~ colDat$Math.SAT[colDat$gender == "F"], 
       pch = "F", col = "blue") ## FEMALE WITH SPECIAL CHARACTER
abline(lm(colDat$Verbal.SAT[colDat$gender == "M"] ~ colDat$Math.SAT[colDat$gender == "M"]), 
       col = "pink", lty = 1)
abline(lm(colDat$Verbal.SAT[colDat$gender == "F"] ~ colDat$Math.SAT[colDat$gender == "F"]), 
       col = "blue", lty = 2)
legend("topleft", pch = "MF", col = c("pink", "blue"), lty = c(1:2), 
       legend = c("MALES", "FEMALES"), cex = 0.8)
text(600, 750, "R is cool", col = "red")

## PLOTTING SIDE BY SIDE
par(mfrow = c(1, 2))
plot(colDat$Verbal.SAT[colDat$gender == "M"] ~ colDat$Math.SAT[colDat$gender == "M"], 
       main = "Verbal SAT by Math SAT", xlab = "Math SAT", ylab = "Verbal SAT", 
       pch = "M", col = "pink") ## MALE WITH SPECIAL CHARACTER
plot(colDat$Verbal.SAT[colDat$gender == "F"] ~ colDat$Math.SAT[colDat$gender == "F"], 
     main = "Verbal SAT by Math SAT", xlab = "Math SAT", ylab = "Verbal SAT", 
     pch = "F", col = "blue") ## FEMALE WITH SPECIAL CHARACTER

## CHECKING THE ASSUMPTIONS OF LINEAR REGRESSION
par(mfrow = c(2, 2))
plot(lm(Verbal.SAT ~ Math.SAT, data = colDat))

