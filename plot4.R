########################################################################################
#
# Exploratory Data Analysis Course Project 1 - Plot 4 
# 
#
########################################################################################


library(data.table)

# plot4.R expects the datafile is in R working directory.  
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

# Create globalActivePower, subMetering1, subMetering2, subMetering3, 
# globalReactivePower, voltage variables for use in plot function
globalActivePower <- as.numeric(dataSubPower$Global_active_power) 
subMetering1 <- as.numeric(dataSubPower$Sub_metering_1) 
subMetering2 <- as.numeric(dataSubPower$Sub_metering_2) 
subMetering3 <- as.numeric(dataSubPower$Sub_metering_3) 
globalReactivePower <- as.numeric(dataSubPower$Global_reactive_power)
voltage <- as.numeric(dataSubPower$Voltage)

# Plot the variables as per Project Question
par(mfrow=c(2,2))

# Plot 1
plot(x = dateTime, y = globalActivePower, type="l", 
     xlab="", ylab="Global Active Power")

# Plot 2
plot(dateTime, voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(x = dateTime, y = subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(x = dateTime, y = subMetering2, type="l", col="red")
lines(x = dateTime, y = subMetering3, type="l", col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), 
       lty=c(1,1),bty="n", cex=.5) 

# Plot 4
plot(dateTime, globalReactivePower, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

# Generate png file 
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

