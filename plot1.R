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

## Plot 1
hist(x$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file for plot
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

