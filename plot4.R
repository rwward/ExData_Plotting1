library(dplyr)

#read and subset data
p <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
ps <- filter(p, Date == "1/2/2007" | Date== "2/2/2007")

#combine date and time variables and convert to posixlt
ps$dt <- paste(as.character(ps$Date), as.character(ps$Time), sep=" ")
ps$dt <- strptime(ps$dt, format="%d/%m/%Y %H:%M:%S")

#convert voltage and global reactive power from factors
ps$glreactive <- as.numeric(levels(ps$Global_reactive_power))[ps$Global_reactive_power]
ps$voltnum <- as.numeric(levels(ps$Voltage))[ps$Voltage]

#open png device
png(file="plot4.png")

#set up multiple plot layout
par(mfcol=c(2,2))

#make plots
with(ps, {
  plot(dt, glactive, ylab="Global Active Power", xlab="", type="l")
  plot(dt, submet1, type="l", ylab="Energy sub metering", xlab = "")
  points(dt, submet2, col="red", type="l")
  points(dt, Sub_metering_3, col="blue", type="l")
  legend("topright", bty="n", col=c("black", "blue", "red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1)
  plot(dt, voltnum, type="l", xlab="datetime", ylab="Voltage")
  plot(dt, glreactive, type="l", ylab="Global_reactive_power", xlab="datetime")
})
#save file
dev.off()
