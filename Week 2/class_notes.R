##############################################
## DATE: 1/30/2017                          ##
## PURPOSE: THIS IS THE SCRIPT FROM CLASS 2 ##
##############################################

## ONE OPTION IS TO SPECIFY THE PATH COMPLETELY FOR THE FILE WITHOUT SETTING
## THE WORKING DIRECTORY

## SKIP THE FIRST TWO LINES AND SPECIFY THE HEADER NAMES
read.table("~/Desktop/MAT 7500 - Statistical Programming/Week 2/HIVforR.txt", 
           skip = 2, col.names = c("height", "age", "HIV"))
## SKIP THE FIRST LINE AND TELL THE FUNCTION THAT THERE IS A HEADER (PREFERRED)
read.table("~/Desktop/MAT 7500 - Statistical Programming/Week 2/HIVforR.txt", 
           skip = 2, header = TRUE)

## ANOTHER OPTION TO FIND THE FILE IS TO FIRST SET WORKING DIRECTORY
setwd("~/Desktop/MAT 7500 - Statistical Programming/Week 2/")

## THEN READ IN DOWNLOADED FILE FROM THE SOURCE
## SKIP THE FIRST LINE AND SPECIFY THE HEADER LINE
read.table("HIVforR.txt", skip = 1, header = TRUE) 

## ANOTHER MENTION FOR CLASS: USING THE FUNCTION file.choose(); COOL BUT NOT 
## RECOMMENDED

## ASSIGN THE TABLE TO A VARIABLE
HIVdata <- read.table("HIVforR.txt", skip = 1, header = TRUE) 

## CALCULATE THE AGE OF A VARIABLE WITHIN A DATA FRAME 
## (TO BE REVISITED LATER IN CLASS)
mean(HIVdata$age)

## HEAD/TAIL FUNCTION TO SEE A SAMPLE OF THE DATA
head(HIVdata)
tail(HIVdata)

## SEE THE DIMENSIONS OF THE DATA
dim(HIVdata)

## CHECK OUT THE NAMES OF THE VARIABLE
names(HIVdata)
names(HIVdata) <- c("ht", "age", "HIVStatus") ## REASSIGN THE NAMES OF THE VAR

## CREATING A 3 COLUMN MATRIX 
matrix(c(1, 2, 3, 2, 3, 4), ncol = 3) ## BY DEFAULT IT IS READ BY COLUMN
matrix(c(1, 2, 3, 2, 3, 4), ncol = 3, byrow = TRUE) ## CHANGING IT TO BY ROW INSTEAD

## A MATRIX MUST HAVE ALL THE SAME OBJECT (ALL CHARACTER OR ALL NUMERIC)
## A DATA FRAME WILL ALLOW FOR DIFFERENT OBJECTS IN THE SAME VARIABLE
## DATA FRAMES ARE PREFERRED TO MATRICES

## COERCE THE MATRIX TO A DATA FRAME
as.data.frame(matrix(c(1, 2, 3, 2, 3, 4), ncol = 3, byrow = TRUE))

## WHAT CLASS IS THE OBJECT?
class(HIVdata$height)
class(HIVdata$HIV)

## FORCE HIV OBJECT TO BE A FACTOR
HIVdata$HIV <- as.factor(HIVdata$HIV)

## GET A SUMMARY OF THE VARIABLES (THEY LOOK DIFFERENT DEPENDING ON THE CLASS)
summary(HIVdata$height)
summary(HIVdata$HIV)
summary(HIVdata)

## WHAT CLASS IS HIVdata?
class(HIVdata) ## ANSWER "data.frame"

## PRINTING INDIVIDUAL OBJECTS WITHIN THE VARIABLE
HIVdata$HIV ## PRINTS THE HIV COLUMN
HIVdata[, 3] ## PRINTS THE 3RD (HIV) COLUMN 
HIVdata[3, ] ## PRINTS THE 3RD ROW
HIVdata[3, 3] ## PRINTS THE CELL 3, 3
HIVdata[, 2:3] ## PRINTS THE 2ND & 3RD COLUMNS (CAN BE USED TO SUBSET THE DATA)

HIVdata$height[HIVdata$HIV == 1] ## REMINDER FOR SUBSETTING TO GET THE HEIGHTS 
                                 ## WHERE INDIVIDUALS HAVE HIV == 1
HIVdata$HIV == 1 ## SHOWS THE BOOLEAN VALUE OF WHETHER OR NOT THE EXAMPLE EQUALS 1

## THERE IS AN EXAMPLE IN THE NOTES ON PAGE 25 IN WHICH YOU CAN SUBSET A TABLE
## AND GET PROPORTIONS

## GET THE STRUCTURE OF THE VARIABLE
str(HIVdata)
## I LIKE TO DO THE SUMMARY BETTER; IT GIVES SLIGHTLY DIFFERENT DATA THOUGH
summary(HIVdata)

## INSTALLING PACKAGES
install.packages("xlsx")

## READ XLSX DATA IN DIRECTLY
xlsx_data <- read.xlsx("Student Survey - Reduced.xlsx", sheetIndex = 1)
head(xlsx_data) ## CHECK OUT A HEAD OF THE DATA
dim(xlsx_data) ## GET THE DIMENSIONS
str(xlsx_data) ## STRUCTURE OF THE DATA

as.numeric(as.character(xlsx_data$Height)) ## FIRST MAKES IT A CHARACTER THEN NUMERIC

## EXCLUDE MISSING VALUES
na.omit(classDat$Degree)

is.na(classDat$Degree) ## IS IT NA/MISSING?
!is.na(classDat$Degree) ## IS IT NOT MISSING?

any(is.na(classDat$Degree)) ## ARE THERE ANY MISSING VALUES?

## UNADVISABLE - ATTACH
attach(classDat, pos = 2) ## ALLOWS YOU TO OMIT THE classDat PREFIX
detach(classDat) ## DETACHES WHAT WAS ATTACHED

## CUT COMMAND
## SET THE CUT POINTS (4 FOR 3 GROUPS)
## ANYTHING THAT IS OUTSIDE THE CUT POINTS WILL GET "MISSING"
HIVdata$htgrp <- cut(HIVdata$height, breaks = c(0, 60, 65, 100), 
                     labels = c("Very Short", "Short", "Tall"))
cbind.data.frame(HIVdata$height, HIVdata$htgrp)

## CLEANING UP THE GENDER DATA
table(classDat$Gender) ## OMITS NAs BY DEFAULT
print(classDat$Gender) ## BUT THERE IS ONE (#19)
table(classDat$Gender2, useNA = "ifany") ## DO NOT OMIT NAs

## NORMALIZE THE DATA USING THE %in% COMMAND
classDat$Gender2 <- as.character(classDat$Gender)
classDat$Gender2[classDat$Gender2 %in% c("Female", "female", "female ", "Female ")] <- "F"
classDat$Gender2[classDat$Gender2 == "Male"] <- "M"

## CHECK THAT THE CHANGES WENT WELL
table(classDat$Gender, classDat$Gender2, useNA = "ifany") ## DO NOT OMIT NAs
