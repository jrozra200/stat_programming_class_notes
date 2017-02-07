#####################
## DATE: 2/6/2017  ##
## TASK 2          ##
#####################

filename <- paste("~/Desktop/MAT 7500 - Statistical Programming/Week 2/prac2.", 
                  "txt", sep = "")
colDat <- read.table(filename, skip = 1, header = TRUE) ## SKIP THE FIRST LINE
                                                        ## NEXT LINE IS HEADERS

## USING BASIC VECTOR MANIPULATION
colDat$type_of_person[colDat$Verbal.SAT == colDat$Math.SAT] <- "Equal"
colDat$type_of_person[colDat$Verbal.SAT > colDat$Math.SAT] <- "Verbal"
colDat$type_of_person[colDat$Verbal.SAT < colDat$Math.SAT] <- "Math"

## USING VECTOR MANIPULATION WITH IF STATEMENTS
colDat$type_of_person_v2 <- ifelse(is.na(colDat$Verbal.SAT) | is.na(colDat$Math.SAT), 
                                ifelse(is.na(colDat$Verbal.SAT) & is.na(colDat$Math.SAT), 
                                       "Missing Math & Verbal Score", 
                                       ifelse(is.na(colDat$Verbal.SAT) & !is.na(colDat$Math.SAT), 
                                              "Missing Verbal Score", "Missing Math Score")),
                                ifelse(colDat$Verbal.SAT == colDat$Math.SAT, "Equal", 
                                ifelse(colDat$Verbal.SAT > colDat$Math.SAT, 
                                       "Verbal", "Math")))

## USING A FOR LOOP
for(i in 1:dim(colDat)[1]){
        colDat$type_of_person_3[i] <- if(is.na(colDat$Verbal.SAT[i]) | is.na(colDat$Math.SAT[i])){
                if(is.na(colDat$Verbal.SAT[i]) & is.na(colDat$Math.SAT[i])){
                        "Missing Math & Verbal Score"
                } else if (is.na(colDat$Verbal.SAT[i]) & !is.na(colDat$Math.SAT[i])){
                        "Missing Verbal Score"
                } else {
                        "Missing Math Score"
                }
        } else {
                if(colDat$Verbal.SAT[i] == colDat$Math.SAT[i]){
                        "Equal"
                } else if(colDat$Verbal.SAT[i] > colDat$Math.SAT[i]) {
                        "Verbal"
                } else {
                        "Math"
                }
        }
}
