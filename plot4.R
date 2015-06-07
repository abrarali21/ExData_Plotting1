# Use filter from dplyr
library(dplyr)

# Read the data with the first line as variable names, separated by ';' and 
# setting all '?' to NA in the table
tableDat <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", 
                       header = TRUE, sep = ";", na.strings = "?")

# Filter out only the data from Feb 1, 2007 - Feb 2, 2007
filterDat <- filter(tableDat, Date == "1/2/2007" | Date == "2/2/2007")

# Set png as the graphics device with the file name and aspect ratio in pixels
png(file="plot4.png",width=480,height=480)

# Combine date and time variables into one data/time object
DateTimeDat <- paste(filterDat$Date, filterDat$Time)
DateTimeObj <- strptime(DateTimeDat, "%d/%m/%Y %H:%M:%S")

# Plot the global active power data as a function of time.
# Choose the titles for x and y axes.
par(mfrow = c(2, 2))

with(filterDat, { 
  plot(x = DateTimeObj, y = filterDat$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
  plot(x = DateTimeObj, y = filterDat$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
  plot(x = DateTimeObj, y = Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering", col = "black")
  lines(DateTimeObj, Sub_metering_2, col = "red")
  lines(DateTimeObj, Sub_metering_3, col = "blue")
  legend("topright", pch = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(x = DateTimeObj, y = filterDat$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
})

par(op)

# Close the png graphics device
dev.off()