#####################
## DATE: 1/30/2017 ##
## TASK 1          ##
#####################

## PROBLEM 1

## ENTER IN THE HEIGHT DATA
height <- c(66, 60, 53, 62, 66, 68, 68, 68, 68, 68, 69, 70, 70, 71, 72, 72, 72, 
            75, 77, 62, 62, 74)

## ENTER IN THE GENDER DATA
gender <- c("Male", "Female", "Male", "Female", "Male", "Male", "Male", "Male", 
            "Female", "Male", "Female", "Male", "Male", "Female", "Male", 
            "Male", "Male", "Female", NA, "Female", "Female", "Female")

## ENTER IN THE AWARD DATA
award <- c("A Nobel Prize", "An Olympic Gold Medal", "An Olympic Gold Medal", 
           "An Academy Award", "An Olympic Gold Medal", "A Nobel Prize", 
           "A Nobel Prize", "A Nobel Prize", "A Nobel Prize", 
           "An Academy Award", "An Olympic Gold Medal", "A Nobel Prize", 
           "A Nobel Prize", "An Olympic Gold Medal", "A Nobel Prize", 
           "An Olympic Gold Medal", "A Nobel Prize", "An Academy Award", 
           "An Olympic Gold Medal", "An Academy Award", "An Olympic Gold Medal", 
           "An Academy Award")


## ENTER IN THE YEARS AT VILLANOVA DATA
yearsNova <- c(4, 4, 6, 1, 1, 3, 2, 1, 5, 4, 4, 3, 1, 4, 2, 7, 1, 1.5, 1, 1, 2, 
               4)

## TEST THE CLASS OF EACH VARIABLE
class(height)
class(gender)
class(award)
class(yearsNova)

## USE CBIND TO CREATE A SINGLE VARIABLE
novaDat <- as.data.frame(cbind(height, gender, award, yearsNova))

## GET THE DIMENSIONS OF THE DATA
dim(novaDat)

## GET THE NAMES OF THE DATA
names(novaDat)

## PROBLEM 2

## READ IN THE DATA
colDat <- read.table("prac2.txt", skip = 1, header = TRUE) ## SKIP THE FIRST LINE
                                                           ## NEXT LINE IS HEADERS
## GET THE DIMENSIONS OF THE DATA
dim(colDat) 

## CALCULATE THE PROPORTION OF MALES
length(colDat$gender[colDat$gender == "M"]) / length(colDat$gender)

## PROBLEM 3 
## IN ORDER TO DO THIS, I SAVED THE FILE AS A UTF-8 CSV FILE FROM EXCEL
classDat <- read.csv("Student Survey - Reduced.csv", header = TRUE)

head(classDat) ## SHOW THE HEAD OF THE DATA
dim(classDat) ## GET THE DIMENSIONS
str(classDat) ## GET THE STRUCTURE

## PROBLEM 3 REVISITED
library(xlsx)

## READ XLSX DATA IN DIRECTLY
xlsx_data <- read.xlsx("Student Survey - Reduced.xlsx", sheetIndex = 2)
head(xlsx_data) ## CHECK OUT A HEAD OF THE DATA
dim(xlsx_data) ## GET THE DIMENSIONS
str(xlsx_data) ## STRUCTURE OF THE DATA

