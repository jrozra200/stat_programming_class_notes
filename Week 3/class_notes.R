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
