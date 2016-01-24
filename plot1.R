library(dplyr)

#read and subset data
p <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
ps <- filter(p, Date == "1/2/2007" | Date== "2/2/2007")

#combine date and time variables and convert to posixlt
ps$dt <- paste(as.character(ps$Date), as.character(ps$Time), sep=" ")
ps$dt <- strptime(ps$dt, format="%d/%m/%Y %H:%M:%S")

#make global active power numeric and rename
ps$glactive <- as.numeric(levels(ps$Global_active_power))[ps$Global_active_power]

#make plot, changing title, x axis label, and fill color
with(ps, hist(glactive, main="Global Active Power", xlab = "Global Active Power (Kilowatts)", col="red"))

#copy plot to png file
dev.copy(png, file="plot1.png")
dev.off()
