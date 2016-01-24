library(dplyr)

#read and subset data
p <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
ps <- filter(p, Date == "1/2/2007" | Date== "2/2/2007")

#combine date and time variables and convert to posixlt
ps$dt <- paste(as.character(ps$Date), as.character(ps$Time), sep=" ")
ps$dt <- strptime(ps$dt, format="%d/%m/%Y %H:%M:%S")

#convert submetering variables to numeric
ps$submet1 <- as.numeric(levels(ps$Sub_metering_1))[ps$Sub_metering_1]
ps$submet2 <- as.numeric(levels(ps$Sub_metering_2))[ps$Sub_metering_2]

#open png device
png(file="plot3.png")
#initiate plot
with(ps, plot(dt, submet1, type="l", ylab="Energy sub metering", xlab = ""))
#add other variables
with(ps, points(dt, submet2, col="red", type="l"))
with(ps, points(dt, Sub_metering_3, col="blue", type="l"))
#add legend
legend("topright", col=c("black", "blue", "red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1)
#save file
dev.off()


