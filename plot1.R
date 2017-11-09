x <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
x$Date <- as.Date(x$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
x <- subset(x,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
x <- x[complete.cases(x),]

## Combine Date and Time column
dateTime <- paste(x$Date, x$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
x <- x[ ,!(names(x) %in% c("Date","Time"))]

## Add DateTime column
x <- cbind(dateTime, x)

## Format dateTime Column
x$dateTime <- as.POSIXct(dateTime)

## Plot 1
hist(x$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file for plot
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
