library(dplyr)

# Load in the data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data.zip", method = "curl")
unzip(zipfile = "./data.zip")

data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Filter data to the 2-day period of focus
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- filter(data, Date==as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create the Plot 1 figure
png(filename = "plot1.png")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()