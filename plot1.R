library(dplyr)
library(lubridate)

if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile = "household_power_consumption.zip", method = "curl")
    unzip("household_power_consumption.zip")
}

data <- as_tibble(read.csv2("household_power_consumption.txt", nrows = 2075259))
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(Date = dmy(Date),
           Time = hms(Time),
           Global_active_power = as.numeric(Global_active_power),
           Global_reactive_power = as.numeric(Global_reactive_power),
           Voltage = as.numeric(Voltage),
           Global_intensity = as.numeric(Global_intensity),
           Sub_metering_1 = as.numeric(Sub_metering_1),
           Sub_metering_2 = as.numeric(Sub_metering_2),
           Sub_metering_3 = as.numeric(Sub_metering_3))

png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()