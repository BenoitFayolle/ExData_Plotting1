## place script in same folder as dataset file "household_power_consumption.txt"
library(dplyr)

##read data
DF<-read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?")

##subsets the two days of interest
DF<-subset(DF, (as.Date(DF$Date,"%d/%m/%Y") >= as.Date("2007-02-01")) &
               (as.Date(DF$Date,"%d/%m/%Y") <= as.Date("2007-02-02")))
DF2<-cbind(datetime=strptime(paste(DF$Date,DF$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
           ,select(DF,Global_active_power,Global_reactive_power,
                   Sub_metering_1,Sub_metering_2,Sub_metering_3,Voltage))

##plot
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(DF2,plot(Global_active_power ~ datetime,
              ylab="Global Active Power",xlab="",type="s"))
with(DF2,plot(Voltage ~ datetime,
              ylab="Voltage",xlab="datetime",type="s"))
with(DF2,plot(Sub_metering_1 ~ datetime,
              ylab="Energy Sub Metering",xlab="",type="s"))
lines(DF2$datetime,DF2$Sub_metering_2,type="s",col="red")
lines(DF2$datetime,DF2$Sub_metering_3,type="s",col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
       col=c("black","red","blue"),lty=1,bty="n")
with(DF2,plot(Global_reactive_power ~ datetime,type="s"))

dev.off()
