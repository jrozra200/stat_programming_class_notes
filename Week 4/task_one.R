#####################
## DATE: 2/13/2017 ##
## TASK 1          ##
#####################

## READ IN BATTING DATA
batting <- read.csv("Batting.csv")

## EXCLUDE THOSE WHO HAVE LESS THAN 100 AT BATS
batting <- batting[batting$AB >= 100 & is.na(batting$AB) == FALSE, ]

## CALCULATE THE BATTING AVERAGE
batting$batting_average <- batting$H / batting$AB

## DETERMINE THE MEAN AND STANDARD DEVIATION BY YEAR
ba_mean <- aggregate(as.data.frame(batting$batting_average), 
                     as.data.frame(batting$yearID), mean)
names(ba_mean) <- c("yearID", "average_batting_average")

ba_sd <- aggregate(as.data.frame(batting$batting_average), 
                   as.data.frame(batting$yearID), sd)
names(ba_sd) <- c("yearID", "batting_st_dev")

## PLOT THE MEAN BATTING AVERAGE OVER TIME
with(ba_mean, plot(x = yearID, y = average_batting_average, 
                   main = "Batting Average over Time", xlab = "Year", 
                   ylab = "Batting Average"))

## PLOT THE SD OF BATTING AVERAGE OVER TIME
with(ba_sd, plot(x = yearID, y = batting_st_dev, 
                 main = "Standard Deviation of Batting Average over Time", 
                 xlab = "Year", ylab = "Standard Deviation"))

## MERGE THESE RESULTS WITH ORIGINAL DATASET
batting <- merge(batting, ba_mean, by = "yearID")
batting <- merge(batting, ba_sd, by = "yearID")

## CALCULATE THE Z-SCORE FOR EACH PLAYER
batting$z_val <- ((batting$batting_average - batting$average_batting_average) 
                  / batting$batting_st_dev)

## PRINT OUT THE TOP 5 Z-SCORES OF BATTING AVERAGES
head(batting[order(batting$z_val, decreasing = TRUE), ], n = 5)
