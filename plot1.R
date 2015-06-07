# Use filter from dplyr
library(dplyr)

# Read the data with the first line as variable names, separated by ';' and 
# setting all '?' to NA in the table
tableDat <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", 
                       header = TRUE, sep = ";", na.strings = "?")

# Filter out only the data from Feb 1, 2007 - Feb 2, 2007
filterDat <- filter(tableDat, Date == "1/2/2007" | Date == "2/2/2007")

# Set png as the graphics device, specify the file name and the aspect ratio in pixels
png(file="plot1.png", width=480, height=480)

# Plot the frequency histogram for the global active power data, choosing the color, 
# the title for x axis and the annoating the title of the plot
hist(filterDat$Global_active_power, col = "red", main = paste("Global Active Power"), 
     xlab = "Global Active Power (kilowatts)")

# Close the png graphics device
dev.off()