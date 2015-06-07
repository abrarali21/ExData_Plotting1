# Use filter from dplyr
library(dplyr)

# Read the data with the first line as variable names, separated by ';' and 
# setting all '?' to NA in the table
tableDat <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", 
                       header = TRUE, sep = ";", na.strings = "?")

# Filter out only the data from Feb 1, 2007 - Feb 2, 2007
filterDat <- filter(tableDat, Date == "1/2/2007" | Date == "2/2/2007")

# Set png as the graphics device, specify the file name and the aspect ratio in pixels
png(file="plot3.png",width=480,height=480)

# Combine date and time variables into one data/time object
DateTimeDat <- paste(filterDat$Date, filterDat$Time)
DateTimeObj <- strptime(DateTimeDat, "%d/%m/%Y %H:%M:%S")

# Plot the energy sub_metering_1 data as a function of time.
# Choose the titles for x and y axes. Add sub_metering_2 and
# sub_metering_3 plots and then add the legend.
with(filterDat, plot(x = DateTimeObj, y = Sub_metering_1, type="l", 
     xlab = "", ylab = "Energy sub metering"), col = "black")
with(filterDat, lines(DateTimeObj, Sub_metering_2, col = "red"))
with(filterDat, lines(DateTimeObj, Sub_metering_3, col = "blue"))
legend("topright", pch = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the png graphics device
dev.off()