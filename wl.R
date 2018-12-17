library(googlesheets)
library(dplyr)
gs_auth(new_user = FALSE)

comp_data_regi = gs_title("Weight Loss Progress")

comp_data <- gs_read(comp_data_regi, ws ="Sheet1")

comp_data <- comp_data %>% 
  mutate(percent_change_total_w1 = ((Initial - W1)/Initial)*100) %>% 
  mutate(percent_change_total_w2 = ((Initial - W2)/Initial)*100) %>% 
  mutate(percent_change_total_w3 = ((Initial - W3)/Initial)*100) %>% 
  mutate(percent_change_total_w4 = ((Initial - W4)/Initial)*100) %>% 
  mutate(percent_change_total_w5 = ((Initial - W5)/Initial)*100) %>% 
  mutate(percent_change_total_w6 = ((Initial - W6)/Initial)*100) %>% 
  mutate(percent_change_total_w7 = ((Initial - W7)/Initial)*100) %>% 
  mutate(percent_change_total_w8 = ((Initial - W8)/Initial)*100)
comp_data <- comp_data %>% 
  mutate(percent_change_weekly_w1 = ((Initial - W1)/Initial)*100) %>% 
  mutate(percent_change_weekly_w2 = (((Initial - W2)/Initial)*100) - percent_change_total_w1) %>% 
  mutate(percent_change_weekly_w3 = (((Initial - W3)/Initial)*100) - percent_change_total_w2) %>% 
  mutate(percent_change_weekly_w4 = (((Initial - W4)/Initial)*100) - percent_change_total_w3) %>% 
  mutate(percent_change_weekly_w5 = (((Initial - W5)/Initial)*100) - percent_change_total_w4) %>% 
  mutate(percent_change_weekly_w6 = (((Initial - W6)/Initial)*100) - percent_change_total_w5) %>% 
  mutate(percent_change_weekly_w7 = (((Initial - W7)/Initial)*100) - percent_change_total_w6) %>% 
  mutate(percent_change_weekly_w8 = (((Initial - W8)/Initial)*100) - percent_change_total_w7)

bars <- ggplot2::ggplot(data = comp_data)
