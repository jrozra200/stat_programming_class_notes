#####################
## DATE: 1/23/2017 ##
## TASK 3 & 4      ##
#####################

############
## TASK 3 ##
############

## CHANGE HEIGHT FROM INCHES TO CENTIMETERS
height_cm <- round(height * 2.54)
height_cm

## NEXT YEAR HOW MANY YEARS WILL IT BE FOR STUDENTS
## NOTE: CHANGING IT NOW TO INTEGERS FROM BEFORE WHEN I ALLOWED A 1.5
next_yearsNova <- round(yearsNova + 1)
next_yearsNova

## CALCLUATING AGE OF STUDENT
## NOTE: ASSUMING THAT EVERYONE'S BIRTHDAY IS EFFECTIVELY 1/1, SINCE WE DON'T 
## KNOW BIRTH MONTH/DAY
this_year <- 2017
age <- this_year - birthYear
age

## PERCENT OF LIFE AT VILLANOVA
percAtNova <- yearsNova / age
percAtNova

############
## TASK 4 ##
############

## GETTING THE SUMMARY DATA (NOT SEPARATED BY GENDER)
summary(age)
summary(as.factor(award))
summary(birthYear)
summary(as.factor(gender))
summary(height)
summary(height_cm)
summary(next_yearsNova)
summary(percAtNova)
summary(yearsNova)

## GETTING THE SUMMARY DATA FOR MALES
summary(age[gender == "Male"])
summary(as.factor(award[gender == "Male"]))
summary(birthYear[gender == "Male"])
summary(as.factor(gender[gender == "Male"]))
summary(height[gender == "Male"])
summary(height_cm[gender == "Male"])
summary(next_yearsNova[gender == "Male"])
summary(percAtNova[gender == "Male"])
summary(yearsNova[gender == "Male"])

## GETTING THE SUMMARY DATA FOR MALES
summary(age[gender == "Female"])
summary(as.factor(award[gender == "Female"]))
summary(birthYear[gender == "Female"])
summary(as.factor(gender[gender == "Female"]))
summary(height[gender == "Female"])
summary(height_cm[gender == "Female"])
summary(next_yearsNova[gender == "Female"])
summary(percAtNova[gender == "Female"])
summary(yearsNova[gender == "Female"])