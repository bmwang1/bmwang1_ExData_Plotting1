# Load libraries
library(dplyr)

# Load in the data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data.zip", method = "curl")
unzip(zipfile = "./data.zip")

data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Filter data to the 2-day period of focus
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- filter(data, Date==as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Combine date and time into a single variable
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Create png to hold Plot 2 figure
png(filename = "plot2.png")

# Create Plot 2
plot(data$DateTime, data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n") # Supress default x-axis ticks

# Set weekdays needed for x-axis ticks 
unique_days <- unique(as.Date(data$DateTime))
daily_ticks <- as.POSIXct(paste(unique_days, "00:00:00"))

# Add x-axis tick marks as abbreviated weekdays 
axis.POSIXct(1, at = daily_ticks, format = "%a") 

# Close plot
dev.off()
