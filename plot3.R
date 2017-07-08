########################################################################################
#
# Exploratory Data Analysis Course Project 1 - Plot 3 
# 
#
########################################################################################


library(data.table)

# plot3.R expects the datafile is in R working directory.  
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

# Create subMetering1, subMetering2, subMetering3 variables for use in plot function
subMetering1 <- as.numeric(dataSubPower$Sub_metering_1) 
subMetering2 <- as.numeric(dataSubPower$Sub_metering_2) 
subMetering3 <- as.numeric(dataSubPower$Sub_metering_3) 

# Plot the variables as per Project Question

plot(x = dateTime, y = subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(x = dateTime, y = subMetering2, type="l", col="red")
lines(x = dateTime, y = subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))


# Generate png file 
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

