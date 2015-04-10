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

#plot on plot2.png file (not default output)
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(power_data_clean$DateTime, power_data_clean$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()