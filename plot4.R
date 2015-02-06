library(data.table)
# Setting working directory
setwd("~/Data_Science_Class/Exploratory_Data_Analysis/")
# Downloading file with data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip")
# Extracting .txt file from archive
unzip("household_power_consumption.zip")
# Reading data into R
table <- read.table("household_power_consumption.txt", header = TRUE, sep= ";", na.strings = "?", stringsAsFactors = FALSE)
# Joining date and time into 1 column 
table$DateTime <- paste(table$Date, table$Time)
# Removing columns, containing date and time
table <- table[, -(1:2)]
# Converting joined date and time from character class to POSIXct class
table$DateTime <- strptime(table$DateTime, "%d/%m/%Y %H:%M:%S")
# Subsetting data by date between 2007-02-01 and 2007-02-02
subsetData <- subset(table, DateTime >= as.POSIXct("2007-02-01 00:00:00")&DateTime < as.POSIXct("2007-02-03 00:00:00"))
# Saving plot in .png file
png("./plot4.png")
par(mfrow = c(2,2))
plot(subsetData$DateTime, subsetData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(subsetData$DateTime, subsetData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(subsetData$DateTime, subsetData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(subsetData$DateTime, subsetData$Sub_metering_2, col = "red")
lines(subsetData$DateTime, subsetData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, bty = "n", col = c("black", "red", "blue"))
plot(subsetData$DateTime, subsetData$Global_reactive_power, type ="l", xlab ="datetime", ylab = "Global reactive power")
dev.off()
print("Done!")