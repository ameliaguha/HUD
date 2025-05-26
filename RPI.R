
setwd("/Users/amelia/Desktop/Amelia") # setting the working directory
data_hud<-read.csv("RPI_TA.csv") # reading the data
View(data_hud)

library(dplyr)
library(scales)

#Changing the variables into date format
data_hud$X12.months.ago <- as.Date(paste0("01-", data_hud$X12.months.ago), format = "%d-%b-%y")
data_hud$Day.of.Date <- as.Date(data_hud$Day.of.Date, format = "%d-%b-%y")

#Sorting by TA and Date
data_hud_2 <- data_hud %>%
  group_by(TA) %>%
  arrange(TA, Day.of.Date) 

#Converting Ann,Change into numeric
data_hud_2$Ann.Change <- as.numeric(gsub("%", "", data_hud_2$Ann.Change)) / 100

#Plotting the graph for RPI
ggplot(data_hud_2, aes(x = Day.of.Date, y = Ann.Change, color = TA, group = TA)) +
  geom_line(size = 1) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(-0.05, 0.1)) +
  labs(
    title = "Annual % Change in Rent Price Index",
    subtitle = "Christchurch, Wellington, and Auckland",
    x = "Year",
    y = "Annual % Change",
    color = "Region"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text.x = element_text(angle = 45, hjust = 1)
  )