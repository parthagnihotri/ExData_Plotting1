########################################################################################
#
# Exploratory Data Analysis Course Project 1 - Plot 1 
# 
#
########################################################################################


library(data.table)

# plot1.R expects the datafile is in R working directory.  
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

# Call hist function to plot histogram
# Title, X Axis/ Y Axis Lables changed as per the Project Question
hist(dataSubPower$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Generate png file 
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

