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

#plot on plot3.png file (not default output)
png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(power_data_clean, plot(DateTime, Sub_metering_1, type="n", main = "", ylab="Energy sub metering", xlab=""))
with(power_data_clean, points(DateTime, Sub_metering_1, type="l", col = "black"))
with(power_data_clean, points(DateTime, Sub_metering_2, type="l", col = "red"))
with(power_data_clean, points(DateTime, Sub_metering_3, type="l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"), col = c("black", "blue", "red"), pch="___")
dev.off()
