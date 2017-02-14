##############################################
## DATE: 2/13/2017                          ##
## PURPOSE: THIS IS THE SCRIPT FROM CLASS 4 ##
##############################################

## FUN FACT: ctrl-l CLEARS THE CONSOLE

## FUNCTIONS EXAMPLE
std <- function(x){
        sqrt(var(x))
}

std <- function(x, denom = "unbiased"){
        #
        # This function calculates the Standard Deviation
        # 
        # Required Arguments
        #       x is a vector or matrix
        # Optional Arguments
        #       demon is either "unbiased" (default) or "mle"
        #
        
        if(denom != "unbiased" & denom != "mle"){
                stop("DENOM must be either 'unbiased' or 'mle'")
        }
        
        n <- if(is.matrix(x)){
                dim(x)[1]
        } else {
                length(x)
        }
        
        if(denom == "unbiased"){
                sqrt(var(x))
        } else {
                sqrt((var(x) * (n - 1) / n))
        }
}

mystd <- std(c(1, 2, 3)) ## ASSIGN THE RESULTS OF A FUNCTION TO A VARIABLE
apply(mydataframe, 2, std) ## APPLY THE FUNCTION TO MULTIPLE COLUMNS OF A DATAFRAME

## aggregate 
filename <- paste("~/Desktop/MAT 7500 - Statistical Programming/Week 2/Basebal",
                  "l Salaries - Modified.xlsx", sep = "")
bbsal <- as.data.frame(read_excel(filename))

## GET THE MEAN AND STANDARD DEVIATION SALARY BY YEAR
bbm <- aggregate(as.data.frame(bbsal$Salary), as.data.frame(bbsal$Year), mean)
names(bbm) <- c("Year", "mean_salary")
bbs <- aggregate(as.data.frame(bbsal$Salary), as.data.frame(bbsal$Year), sd)
names(bbs) <- c("Year", "sd_salary")

# Zsal = (sal - meansalary) / sdsalary
bbms <- merge(bbm, bbs)
bbsal <- merge(bbsal, bbms)

bbsal$Zsal <- (bbsal$Salary - bbsal$mean_salary) / bbsal$sd_salary
head(bbsal)

## WHO IS THE HIGHEST BASED ON YEAR
bbsal[bbsal$Zsal == max(bbsal$Zsal), ]
## WHO IS THE LOWEST BASED ON YEAR
bbsal[bbsal$Zsal == min(bbsal$Zsal), ]

## THATS THE MAX AND MIN, BUT WHAT ABOUT THE SECOND HIGHEST?
head(bbsal[order(bbsal$Zsal, decreasing = TRUE), ])


## SIMULATIONS

runif(5) ## GENERATE 5 OBS FROM A UNIFORM DISTRIBUTION
mean(runif(5)) ## NOW GENERATE THE MEAN
replicate(10000, mean(runif(5))) ## REPLICATE IT 10,000 TIMES

## DRAW THE DISTRIBUTION OF THE MEAN FROM THE RANDOM SAMPLES OF 5
meanunif5 <- replicate(10000, mean(runif(5)))
hist(meanunif5, xlab = paste("True Mean = 0.5\nMean Max = ", mean(meanunif5), 
                             sep = "")) 

## DRAW THE DISTRIBUTION OF THE MAX FROM THE RANDOM SAMPLES OF 5
maxunif5 <- replicate(10000, max(runif(5)))
hist(maxunif5, xlab = paste("True Mean = 1\nMean Max = ", mean(maxunif5), 
                             sep = "")) 

## PLOTTING ALL OF THE RESULTS ON ONE PLOT
par(mfrow = c(2, 3))
meanunif5 <- replicate(10000, mean(runif(5)))
hist(meanunif5, xlab = paste("True Mean = 0.5\nMean Max = ", mean(meanunif5), 
                             sep = "")) 
meanunif25 <- replicate(10000, mean(runif(25)))
hist(meanunif25, xlab = paste("True Mean = 0.5\nMean Max = ", mean(meanunif25), 
                             sep = "")) 
meanunif125 <- replicate(10000, mean(runif(125)))
hist(meanunif125, xlab = paste("True Mean = 0.5\nMean Max = ", mean(meanunif125), 
                             sep = "")) 
maxunif5 <- replicate(10000, max(runif(5)))
hist(maxunif5, xlab = paste("True Max = 1\nMean Max = ", mean(maxunif5), 
                            sep = "")) 
maxunif25 <- replicate(10000, max(runif(25)))
hist(maxunif25, xlab = paste("True Max = 1\nMean Max = ", mean(maxunif25), 
                            sep = "")) 
maxunif125 <- replicate(10000, max(runif(125)))
hist(maxunif125, xlab = paste("True Max = 1\nMean Max = ", mean(maxunif125), 
                            sep = "")) 

## CHANGE THE ABOVE INTO A FUNCTION
par(mfrow = c(2, 3))
meanmaxunif <- function(n) {
        meanunif <- replicate(10000, mean(runif(n)))
        hist(meanunif, xlab = paste("True Mean = 0.5\nActual Mean = ", mean(meanunif), 
                                      sep = "")) 
        
        maxunif <- replicate(10000, max(runif(n)))
        hist(maxunif, xlab = paste("True Max = 1\nMean Max = ", mean(maxunif), 
                                    sep = "")) 
}

meanmaxunif(5)
meanmaxunif(25)
meanmaxunif(125)

## BOOTSTRAPPING EXAMPLE
par(mfrow = c(1, 1))
NYY2013 <- bbsal$Salary[bbsal$Year == "2013" & bbsal$Team == "NYA"]
t.test(NYY2013)$conf.int
hist(NYY2013, nclass = 15)

sampY13 <- replicate(10000, sample(NYY2013, replace = TRUE))
sampY13means <- apply(sampY13, 2, mean)
hist(sampY13means)
quantile(sampY13means, c(0.025, 0.975))
