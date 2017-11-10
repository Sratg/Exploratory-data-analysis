##Reading and cleaning data
x <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
x$Date <- as.Date(x$Date, "%d/%m/%Y")
x <- subset(x,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
x <- x[complete.cases(x),]
dateTime <- paste(x$Date, x$Time)
dateTime <- setNames(dateTime, "DateTime")
x <- x[ ,!(names(x) %in% c("Date","Time"))]
x <- cbind(dateTime, x)
x$dateTime <- as.POSIXct(dateTime)


## Plot 3
with(x, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save file for plot 
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

