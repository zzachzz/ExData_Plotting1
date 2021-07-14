install.packages("lubridate")
install.packages("dplyr")
library(lubridate)
library(dplyr)

powerD <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

powerD.Sub <- filter(powerD,Date=="1/2/2007" | Date=="2/2/2007")

#combine Date and Time columns to produce full date & time output
powerD.Sub$DateTime <- paste(powerD.Sub$Date,powerD.Sub$Time, sep=" ")
powerD.Sub$DateTime <- strptime(powerD.Sub$DateTime,"%d/%m/%Y %H:%M:%S")

#plot4
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
#GAP ~ date
with(powerD.Sub,plot(DateTime, Global_active_power,type="l",
                     ylab="Global Active Power (kilowatts)",xlab=""))
#voltage ~ date
with(powerD.Sub,plot(DateTime,Voltage,type="l"))

#ESM ~ date
with(powerD.Sub,plot(DateTime,Sub_metering_1,type="l",xlab="",
                     ylab="Energy sub metering"))
lines(powerD.Sub$DateTime,powerD.Sub$Sub_metering_2,type="l",col="#ff3000")
lines(powerD.Sub$DateTime,powerD.Sub$Sub_metering_3,type="l",col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(1,1))

#GRP ~ date
with(powerD.Sub,plot(DateTime,Global_reactive_power,type="l"))

dev.off()