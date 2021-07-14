install.packages("lubridate")
install.packages("dplyr")
library(lubridate)
library(dplyr)

powerD <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

powerD.Sub <- filter(powerD,Date=="1/2/2007" | Date=="2/2/2007")

#combine Date and Time columns to produce full date & time output
powerD.Sub$DateTime <- paste(powerD.Sub$Date,powerD.Sub$Time, sep=" ")
powerD.Sub$DateTime <- strptime(powerD.Sub$DateTime,"%d/%m/%Y %H:%M:%S")


#plot3
#plot meter usage
with(powerD.Sub,plot(DateTime,Sub_metering_1,type="n",xlab="",
                     ylab="Energy sub metering"))
points(powerD.Sub$DateTime,powerD.Sub$Sub_metering_1,type="l")
points(powerD.Sub$DateTime,powerD.Sub$Sub_metering_2,type="l",col="#ff3000")
points(powerD.Sub$DateTime,powerD.Sub$Sub_metering_3,type="l",col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.5)
dev.copy(png,"plot3.png",width=480,height=480)
dev.off()