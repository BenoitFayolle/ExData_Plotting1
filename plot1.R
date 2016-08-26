
## place script in same folder as dataset file "household_power_consumption.txt"
library(dplyr)

##read data
DF<-read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?")

##let's subset the two days of interest
DF<-subset(DF, (as.Date(DF$Date,"%d/%m/%Y") >= as.Date("2007-02-01")) &
                (as.Date(DF$Date,"%d/%m/%Y") <= as.Date("2007-02-02")))
DF2<-cbind(datetime=strptime(paste(DF$Date,DF$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
           ,select(DF,Global_active_power,Global_reactive_power,
                   Sub_metering_1,Sub_metering_2,Sub_metering_3,Voltage))

## plot
png("plot1.png",width=480,height=480)
with(DF2,hist(Global_active_power,
              xlab="Global Active Power (kilowatts)",
              main="Global Active Power",
              col="red"))
dev.off()





