install.packages("lubridate")
install.packages("dplyr")
library(lubridate)
library(dplyr)

powerD <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

powerD.Sub <- filter(powerD,Date=="1/2/2007" | Date=="2/2/2007")

#combine Date and Time columns to produce full date & time output
powerD.Sub$DateTime <- paste(powerD.Sub$Date,powerD.Sub$Time, sep=" ")
powerD.Sub$DateTime <- strptime(powerD.Sub$DateTime,"%d/%m/%Y %H:%M:%S")

#plot1
#plot power histogram
with(powerD.Sub,hist(Global_active_power,main="Global Active Power",
                     xlab="Global Active Power (kilowatts",col="#ff3000"))
dev.copy(png, "plot1.png",width=480,height=480)
dev.off()
