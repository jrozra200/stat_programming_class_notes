#####################
## DATE: 1/23/2017 ##
## TASK 1          ##
#####################

## ENTER IN THE HEIGHT DATA
## NOTE: I DECIDED TO CHANGE EVERTHING TO INCHES - ASSUMING THAT NUMBERS THAT 
## WERE NOT IN THE 60's or 70's FOLLOWED A FEET-INCHES FORMAT OF SOME SORT
height <- c(66, 60, 53, 62, 66, 68, 68, 68, 68, 68, 69, 70, 70, 71, 72, 72, 72, 
            75, 77, 62, 62, 74)
height 


## ENTER IN THE GENDER DATA
## NOTE: I DECIDED TO CHANGE EVERTHING TO "Male" OR "Female" IF IT WAS NOT IN 
## THAT FORMAT ALREADY. THERE WAS ALSO A MISSING VALUE THAT I'VE CODED WITH AN 
## "NA"
gender <- c("Male", "Female", "Male", "Female", "Male", "Male", "Male", "Male", 
            "Female", "Male", "Female", "Male", "Male", "Female", "Male", 
            "Male", "Male", "Female", NA, "Female", "Female", "Female")
gender 


## ENTER IN THE GENDER DATA
## NOTE: HERE THERE WERE NO IRREGULAR DATA POINTS - I PUT IT IN AS-IS
award <- c("A Nobel Prize", "An Olympic Gold Medal", "An Olympic Gold Medal", 
           "An Academy Award", "An Olympic Gold Medal", "A Nobel Prize", 
           "A Nobel Prize", "A Nobel Prize", "A Nobel Prize", 
           "An Academy Award", "An Olympic Gold Medal", "A Nobel Prize", 
           "A Nobel Prize", "An Olympic Gold Medal", "A Nobel Prize", 
           "An Olympic Gold Medal", "A Nobel Prize", "An Academy Award", 
           "An Olympic Gold Medal", "An Academy Award", "An Olympic Gold Medal", 
           "An Academy Award")
award

## ENTER IN THE YEARS AT VILLANOVA DATA
## NOTE: MIGHT SHOULD CHANGE THE 1.5 VALUE TO A 1, AS IT WAS SUPPOSED TO BE AN
## INTEGER PER THE INSTRUCTIONS - I'LL LEAVE IT AS-IS FOR NOW
yearsNova <- c(4, 4, 6, 1, 1, 3, 2, 1, 5, 4, 4, 3, 1, 4, 2, 7, 1, 1.5, 1, 1, 2, 
               4)
yearsNova

## ENTER IN THE YEAR OF BIRTH DATA
## NOTE: THERE WERE NO IRREGULAR DATA POINTS - I'VE NOT CHANGED ANYTHING HERE
birthYear <- c(1995, 1995, 1988, 1986, 1986, 1986, 1986, 1995, 1994, 1995, 1995, 
               1990, 1985, 1994, 1990, 1990, 1992, 1991, 1994, 1990, 1992, 1995)
birthYear

## ALL OF THE DATA IS ENTERED IN CORRECTLY - I'VE CHECKED THAT THE LENGTH IS 
## THE SAME (22) FOR EACH VARIABLE