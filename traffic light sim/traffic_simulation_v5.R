#########################
#########################
## ASSISTANT FUNCTIONS ##
#########################
#########################

can_a_car_be_added <- function(cars){
        if(dim(cars[cars$seconds_in_sim < min_time_between_cars, ])[1] == 0){
                return(TRUE)
        } else {
                return(FALSE)
        }
}

try_to_add_car <- function(cars, cars_per_second){
        ## TAKE A SAMPLE FROM A NORMAL DISTRIBUTION
        samp <- runif(1)
        
        if(samp <= cars_per_second) {
                car_index <- ifelse(dim(cars)[1] == 0, 1, max(cars$index) + 1)
                car_max_speed <- get_max_speed(speed_limit_mph, max_speed_mph)
                car_current_speed <- car_max_speed
                car_seconds_in_sim <- 0
                car_xposition <- 0
                ## ASSUMING MAX DECELERATION OF 15 F/S^2
                car_min_stop_time <- (car_current_speed * 5280 / 3600) / 15 
                
                tmp <- data.frame(index = car_index, max_speed = car_max_speed,
                                  current_speed = car_current_speed, 
                                  seconds_in_sim = car_seconds_in_sim,
                                  xposition = car_xposition,
                                  min_stop_time = car_min_stop_time)
                cars <- rbind(cars, tmp)
        }
        
        return(cars)
}

get_max_speed <- function(speed_limit_mph, max_speed_mph){
        st_dev <- (speed_limit_mph - max_speed_mph) / qnorm(0.005)
        
        return(rnorm(1, speed_limit_mph, st_dev))
}

get_current_speed <- function(cars, light){
        
        ## FOR EACH CAR WHO HAS NOT YET GONE A FULL MILE
        for(car in cars$index[cars$xposition < 5280]){
                
                ## IF THE LIGHT IS GREEN ...
                cars$current_speed[car] <- if(light$color[1] == "green"){
                        if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                
                                cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                        } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                   cars$xposition[car]) > cars$xposition[car - 1]){
                                ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                
                                ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                ((1800 * (cars$xposition[car - 1] - 
                                                  cars$xposition[car])) / 5280)
                        } else {
                                ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                        ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                        cars$max_speed[car]
                                } else{
                                        (cars$current_speed[car] + 6.5)
                                }
                        }
                } 
                ## IF THE LIGHT IS YELLOW ... 
                else if(light$color[1] == "yellow") { 
                        ## ASSUMING AT MOST ONE CAR CAN GET THROUGH A YELLOW LIGHT
                        ## ... AND IF YOU ARE BEYOND THE LIGHT, KEEP ON GOING
                        if(cars$xposition[car] >= light$xposition[1]){
                                if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                        ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                        
                                        cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                                } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                           cars$xposition[car]) > cars$xposition[car - 1]){
                                        ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                        
                                        ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                        ((1800 * (cars$xposition[car - 1] - 
                                                          cars$xposition[car])) / 5280)
                                } else {
                                        ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                        if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                                ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                                cars$max_speed[car]
                                        } else{
                                                (cars$current_speed[car] + 6.5)
                                        }
                                }
                        } 
                        ## ... AND IF YOU ARE NOT BEYOND THE LIGHT ...
                        else if ((cars$xposition[car] + 
                                  (7 * 
                                   (cars$current_speed[car] * 
                                    5280 / 3600))) < light$xposition[1]) { 
                                ## ... AND YOU ARE STILL FAR FROM THE LIGHT, 
                                ## SO YOU DON'T NEED TO SLOW DOWN YET ...
                                if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                        ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                        
                                        cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                                } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                           cars$xposition[car]) > cars$xposition[car - 1]){
                                        ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                        
                                        ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                        ((1800 * (cars$xposition[car - 1] - 
                                                          cars$xposition[car])) / 5280)
                                } else {
                                        ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                        if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                                ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                                cars$max_speed[car]
                                        } else{
                                                (cars$current_speed[car] + 6.5)
                                        }
                                }
                        } 
                        ## ... AND IF YOU ARE NOT BEYOND THE LIGHT BUT ARE CLOSE ...
                        else if(dim(cars[cars$xposition > cars$xposition[car] & 
                                           cars$xposition < light$xposition[1], ])[1] == 0){
                                ## ... AND IF THERE ARE NO CARS BETWEEN YOU AND THE LIGHT ...
                                
                                ## ... AND IF YOU CAN MAKE IT THROUGH THE LIGHT 
                                ## AT YOUR CURRENT SPEED ...
                                if(((cars$current_speed[car] * 5280 / 3600) * 
                                    (light$len_of_yel[1] - light$sec_at_cur_lev[1])) > 
                                   light$xposition[1]){
                                        if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                                ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                                
                                                cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                                        } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                                   cars$xposition[car]) > cars$xposition[car - 1]){
                                                ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                                
                                                ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                                ((1800 * (cars$xposition[car - 1] - 
                                                                  cars$xposition[car])) / 5280)
                                        } else {
                                                ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                                if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                                        ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                                        cars$max_speed[car]
                                                } else{
                                                        (cars$current_speed[car] + 6.5)
                                                }
                                        }
                                } else {
                                        ## IF YOU CAN'T MAKE IT THROUGH AT YOUR CURRENT SPEED, SLOW DOWN EVENLY
                                        (((cars$current_speed[car] * 5280 / 
                                                   3600) - ((light$xposition[1] - 
                                                                     cars$xposition[car]) / 
                                                                    (cars$current_speed[car] * 
                                                                             5280 / 3600))) * 
                                                 3600 / 5280)
                                }
                        } else {
                                if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                        ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                        
                                        cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                                } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                           cars$xposition[car]) > cars$xposition[car - 1]){
                                        ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                        
                                        ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                        ((1800 * (cars$xposition[car - 1] - 
                                                          cars$xposition[car])) / 5280)
                                } else {
                                        ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                        if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                                ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                                cars$max_speed[car]
                                        } else{
                                                (cars$current_speed[car] + 6.5)
                                        }
                                }
                        }
                } else { ## LIGHT IS RED
                        ## IF YOU ARE BEYOND THE LIGHT, KEEP ON GOING
                        if(cars$xposition[car] >= light$xposition[1]){
                                if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                        ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                        
                                        cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                                } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                           cars$xposition[car]) > cars$xposition[car - 1]){
                                        ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                        
                                        ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                        ((1800 * (cars$xposition[car - 1] - 
                                                          cars$xposition[car])) / 5280)
                                } else {
                                        ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                        if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                                ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                                cars$max_speed[car]
                                        } else{
                                                (cars$current_speed[car] + 6.5)
                                        }
                                }
                        } else if ((cars$xposition[car] + (7 * (cars$current_speed[car] * 5280 / 3600))) < light$xposition[1]) { ## YOU ARE STILL FAR FROM THE LIGHT, SO YOU DON'T NEED TO SLOW DOWN YET
                                if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                        ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                        
                                        cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                                } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                           cars$xposition[car]) > cars$xposition[car - 1]){
                                        ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                        
                                        ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                        ((1800 * (cars$xposition[car - 1] - 
                                                          cars$xposition[car])) / 5280)
                                } else {
                                        ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                        if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                                ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                                cars$max_speed[car]
                                        } else{
                                                (cars$current_speed[car] + 6.5)
                                        }
                                }
                        } else if (((cars$current_speed[car] * 5280 / 3600) * 
                                    (light$len_of_yel[1] - light$sec_at_cur_lev[1])) > 
                                   light$xposition[1]) {
                                ## IF THERE ARE NO CARS BETWEEN YOU AND THE LIGHT
                                
                                (((cars$current_speed[car] * 5280 / 
                                           3600) - ((light$xposition[1] - 
                                                             cars$xposition[car]) / 
                                                            (cars$current_speed[car] * 
                                                                     5280 / 3600))) * 
                                         3600 / 5280)
                        } else {
                                if(cars$index[car] == min(cars$index[cars$xposition < 5280])){ 
                                        ## ... AND IF THIS IS THE FIRST CAR IN THE SIMULATION ...
                                        
                                        cars$max_speed[car] ## ... THEN ITS CURRENT SPEED IS ITS MAX SPEED
                                } else if((((cars$current_speed[car] * 5280) / 1800) + 
                                           cars$xposition[car]) > cars$xposition[car - 1]){
                                        ## ... AND THERE IS LESS THAN 2 SECONDS BETWEEN CARS ...
                                        
                                        ## ... CHANGE SPEED TO MAINTAIN A 2 SECOND BUFFER
                                        ((1800 * (cars$xposition[car - 1] - 
                                                          cars$xposition[car])) / 5280)
                                } else {
                                        ## ... AND THE CAR IN FRONT IS GOING FASTER THAN YOU ...
                                        if((cars$current_speed[car] + 6.5) > cars$max_speed[car]) {
                                                ## ASSUME THAT CARS CAN ONLY ACCELERATE UP TO 6.5 F/S^2
                                                cars$max_speed[car]
                                        } else{
                                                (cars$current_speed[car] + 6.5)
                                        }
                                }
                        }
                }
                
                ## FINAL CHECK - IF THE SPEED YOU ARE ASSIGNED IS FASTER THAN 
                ## YOUR MAX SPEED, SLOW DOWN
                cars$current_speed[car] <- ifelse(cars$current_speed[car] > 
                                                          cars$max_speed[car], 
                                                  cars$max_speed[car], 
                                                  cars$current_speed[car])
                
                ## IF THE SPEED YOU ARE ASSIGNED IS LESS THAN ZERO, GO ZERO
                cars$current_speed[car] <- ifelse(cars$current_speed[car] < 0, 
                                                  0, cars$current_speed[car])
        } 
        
        return(cars)
}

update_light <- function(light, lengthOfGreen){
        light$sec_at_cur_lev[1] <- light$sec_at_cur_lev[1] + 1
        
        if((light$color[1] == "green") & 
           (light$sec_at_cur_lev[1] > lengthOfGreen)){
                light$color[1] <- "yellow"
                light$sec_at_cur_lev[1] <- 0
        } else if ((light$color[1] == "yellow") & 
                   (light$sec_at_cur_lev[1] > light$len_of_yel[1])){
                light$color[1] <- "red"
                light$sec_at_cur_lev[1] <- 0
        } else if ((light$color[1] == "red") & 
                   (light$sec_at_cur_lev[1] > lengthOfGreen)){
                light$color[1] <- "green"
                light$sec_at_cur_lev[1] <- 0
        } 
        
        return(light)
}


summary_stats <- data.frame()

for(cps in c(1, 10, 20, 30, 40, 50, 60)){
        
        print(paste("cars per minute: ", cps, sep = ""))
        
        for(log_1 in c(15, 45, 75, 105, 135, 165, 195,
                     225, 255, 285)){
                
                print(paste("seconds per green: ", log_1, sep = ""))
                
                ##########################
                ##########################
                ## SIMULATION VARIABLES ##
                ##########################
                ##########################
                
                length_of_sim_sec <- 3600
                cars_per_second <- cps / 60
                speed_limit_mph <- 35
                max_speed_mph <- 50
                min_time_between_cars <- 2
                cars <- data.frame()
                light <- data.frame(color = "green", sec_at_cur_lev = 0, 
                                    xposition = 4140, len_of_yel = 3)
                light$color <- as.character(light$color)
                len_of_green_sec <- log_1
                
                ###########################
                ## INITIALIZE SIMULATION ##
                ###########################
                
                for(sec in 1:length_of_sim_sec){
                        ## CAN A CAR BE ADDED? IF SO, TRY. IF NOT, DON'T
                        cars <- if(can_a_car_be_added(cars)){
                                try_to_add_car(cars, cars_per_second)
                        } else {
                                cars
                        }
                        
                        ## WHAT SHOULD THE SPEED FOR EVERY CAR BE?
                        if(dim(cars)[1] > 0){
                                cars <- get_current_speed(cars, light)
                        }
                        
                        ## NOW THAT WE HAVE THE SPEED FOR EVERY CAR, LET'S MOVE THEM 
                        ## (IF THEY HAVEN'T ALREADY TRAVELED A MILE)
                        cars$xposition[cars$xposition < 5280] <- (
                                cars$xposition[cars$xposition < 5280] + 
                                        ((cars$current_speed[cars$xposition < 5280] * 
                                                  5280) / 
                                                 3600)
                                )
                        
                        ## AND WE ADD ONE SECOND TO THE TIME IN THE SIMULATION
                        cars$seconds_in_sim[cars$xposition < 5280] <- (
                                cars$seconds_in_sim[cars$xposition < 5280] + 1
                                )
                        
                        ## AND WE UPDATE THE STATUS OF THE LIGHT
                        light <- update_light(light, len_of_green_sec)
                        
                        cars_in_sim <- cars$index[cars$xposition < 5280]
                        if(length(cars_in_sim) > 1){
                                for(i in 2:length(cars_in_sim)){
                                        if(cars$xposition[cars_in_sim[i]] > cars$xposition[cars_in_sim[i - 1]]){
                                                print(paste("SIM BROKE THE RULES IN SECOND: ", 
                                                            sec, " FOR CAR ", 
                                                            cars[cars_in_sim[(i - 1):i], ], 
                                                            sep = ""))
                                        }
                                }
                        }
                }
                                
                tmp <- data.frame(cars_per_minute = cps,
                                  length_of_green = log_1,
                                  cars_finished_sim = max(cars$index[cars$xposition >= 5280]),
                                  total_time_in_sim = sum(cars$seconds_in_sim[cars$xposition >= 5280]),
                                  avg_time_in_sim = mean(cars$seconds_in_sim[cars$xposition >= 5280]))
                summary_stats <- rbind(summary_stats, tmp)
        }
}

write.csv(summary_stats, "~/Desktop/MAT 7500 - Statistical Programming/traffic light sim/summary_stats_v5.csv", row.names = FALSE)
