library(scatterplot3d)
library(plyr)

summary_stats <- read.csv("~/Desktop/MAT 7500 - Statistical Programming/traffic light sim/summary_stats.csv")

av_per_light_length <- ddply(summary_stats, .(length_of_green), summarize,
                             avg_time_in_sim = mean(avg_time_in_sim))

boxplot(summary_stats$avg_time_in_sim ~ summary_stats$length_of_green, 
        main = "Average Time to Travel One Mile \n Based on Length of Green Light",
        xlab = "Length of Green Light (seconds)")

scat_plot <- scatterplot3d(summary_stats$length_of_green,
                           summary_stats$cars_per_minute, 
                           summary_stats$avg_time_in_sim, pch = 16, 
                           highlight.3d = TRUE, 
                           main = "Average Time to Travel One Mile \n Based on Cars per Second & Length of Green Light",
                           xlab = "Length of Green Light (seconds)",
                           ylab = "Cars per Minute",
                           zlab = "Average Time (seconds)")

fit <- lm(avg_time_in_sim ~ length_of_green + cars_per_minute, 
          data = summary_stats)

scat_plot$plane3d(fit)

scat_plot <- scatterplot3d(summary_stats$length_of_green,
                           summary_stats$cars_per_minute, 
                           summary_stats$cars_finished_sim, pch = 16, 
                           highlight.3d = TRUE)

fit <- lm(cars_finished_sim ~ length_of_green + cars_per_minute, 
          data = summary_stats)

summary(fit)

scat_plot$plane3d(fit)

nova_test <- aov(avg_time_in_sim ~ length_of_green + cars_per_minute, 
                 data = summary_stats)

summary(nova_test)

nova_test <- aov(cars_finished_sim ~ length_of_green + cars_per_minute, 
                 data = summary_stats)

summary(nova_test)
