#Libraries used in script
library(dplyr)
library(lubridate)
library(stringr)

#download if it does not exist
if (!file.exists("household_power_consumption.txt")){
    if (!file.exists("exdata_data_household_power_consumption.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "exdata_data_household_power_consumption.zip",
                      mode="wb")
    }
    # unzip the contents of the zip to working folder
    unzip("exdata_data_household_power_consumption.zip", exdir=".")
}

# load data
power_data <- read.csv2("./household_power_consumption.txt", colClasses=c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings="?", dec=".")

# filter for 2007-02-01 and 2007-02-02
power_data_clean <- power_data %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(DateTime = dmy_hms(paste(Date, Time)))

#plot on plot4.png file (not default output)
png(filename = "plot4.png", width = 480, height = 480, units = "px")
with(power_data_clean, {
    #create a 2 by 2 window of plots row filled
    par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
    #1 Global Active Power
    plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    
    #2 Voltage
    plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")
    
    #3 Energy Sub System
    plot(DateTime, Sub_metering_1, type="n", main = "", ylab="Energy sub metering", xlab="")
    points(DateTime, Sub_metering_1, type="l", col = "black")
    points(DateTime, Sub_metering_2, type="l", col = "red")
    points(DateTime, Sub_metering_3, type="l", col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"), col = c("black", "blue", "red"), pch="___")

    #4 Global reactive power
    plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()
