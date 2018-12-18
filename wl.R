library(ggplot2)
library(googlesheets)
library(dplyr)
library(reshape2)

gs_auth(new_user = FALSE)

comp_data_regi = gs_title("Weight Loss Progress")

data <- gs_read(comp_data_regi, ws ="Sheet1")

# seperate into frames of weekly change, total change and weight

weight <- data %>% 
	select(Name, W0, W1, W2, W3, W4, W5, W6, W7, W8)

perc_change <- data %>% 
	select(-W0, -W1, -W2, -W3, -W4, -W5, -W6, -W7, -W8, W0=W0_perc_change, W1=W1_perc_change, W2=W2_perc_change, W3=W3_perc_change, W4=W4_perc_change,
				 W5=W5_perc_change, W6=W6_perc_change, W7=W7_perc_change, W8=W8_perc_change)

t_change <- data %>% 
	select(Name, "Total Percent Change" = total_change)

# melt data for plots

perc_change_melted <- melt(perc_change,
													 id.vars = c("Name"),
													 measure.vars = c("W0","W1","W2","W3","W4","W5","W6","W7","W8"),
													 variable.name="Week",
													 value.name="Weight")

weight_melted <- melt(weight,
											id.vars = c("Name"),
											measure.vars = c("W0","W1","W2","W3","W4","W5","W6","W7","W8"),
											variable.name="Week",
											value.name="Weight")

# create plots

pcm <- ggplot(perc_change_melted, aes(x = Week, y = Weight, group = Name, colour = Name))
pcm + geom_line(size=2)

wm <- ggplot(weight_melted, aes(x = Week, y = Weight, group = Name, colour = Name, size = 2))
wm + geom_line()

tc <- ggplot(t_change, aes(x=Name, y=`Total Percent Change`, fill = Name))
tc + geom_bar(stat="identity")
