########################################################################################
#
# Exploratory Data Analysis Course Project 1 - Plot 2 
# 
#
########################################################################################


library(data.table)

# plot2.R expects the datafile is in R working directory.  
# filePath stores the directory path.
filePath <- file.path(getwd(),"exdata_data_household_power_consumption",
                      "household_power_consumption.txt")

# Read the datafile
dataPower <- data.table(fread(filePath,na.strings = "?"))

# Change Date column to Date format
dataPower$Date <- as.Date(dataPower$Date, format="%d/%m/%Y")

# Subset data for Date Range between 2007-02-01 and 2007-02-02
dataSubPower <- subset(dataPower, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Remove full dataset
rm(dataPower)

# Create dateTime variabe with Date and Time from Dataset
dateTime <- as.POSIXct(paste(dataSubPower$Date, dataSubPower$Time))
# Create globalActivePower variable to be used in plot function
globalActivePower <- as.numeric(dataSubPower$Global_active_power) 

# Plot the variables as per Project Question

plot(x = dateTime, y = globalActivePower, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

# Generate png file 
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

