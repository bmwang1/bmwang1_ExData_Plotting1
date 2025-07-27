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

# Create png to hold Plot 4 figure
png(filename = "plot4.png")

# Set up 2x2 grid of plots
par(mfrow = c(2, 2))

# Set weekdays needed for x-axis ticks 
unique_days <- unique(as.Date(data$DateTime))
daily_ticks <- as.POSIXct(paste(unique_days, "00:00:00"))

# Create 1st plot 
plot(data$DateTime, data$Global_active_power, 
    type = "l", 
    xlab = "", 
    ylab = "Global Active Power (kilowatts)",
    xaxt = "n") # Supress default x-axis ticks

# Add x-axis tick marks as abbreviated weekdays 
axis.POSIXct(1, at = daily_ticks, format = "%a") 

# Create 2nd plot
plot(data$DateTime, data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n") # Supress default x-axis ticks

# Add x-axis tick marks as abbreviated weekdays 
axis.POSIXct(1, at = daily_ticks, format = "%a") 

# Create 3rd plot
plot(data$DateTime, data$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering",
     xaxt = "n") # Supress default x-axis ticks

# Add sub_metering_2 and sub_metering_3
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

# Add a legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1,1,1), 
       bty = "n")

# Add x-axis tick marks as abbreviated weekdays 
axis.POSIXct(1, at = daily_ticks, format = "%a") 

# Create 4th plot
plot(data$DateTime, data$Global_reactive_power, 
     type = "h", 
     xlab = "datetime", 
     ylab = "Global_reactive_power",
     xaxt = "n") # Supress default x-axis ticks

# Add x-axis tick marks as abbreviated weekdays 
axis.POSIXct(1, at = daily_ticks, format = "%a") 

# Close plot
dev.off()
