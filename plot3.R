file <- "../data/household_power_consumption.txt"
data <- read.delim(file, header = TRUE, sep=";", na.strings = "?")
x <- paste(data$Date, data$Time)

data$DateTime <- strptime(x, format = "%d/%m/%Y %T")

dsub <- subset(data, DateTime >= as.POSIXct('2007-02-01 00:00') & DateTime <=
                as.POSIXct('2007-02-02 23:59'))

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", type = c("cairo", "cairo-png", "Xlib", "quartz"))

plot(dsub$DateTime, dsub$Sub_metering_1, xlab = NA, ylab = "Energy sub metering",
     type = "l")
points(dsub$DateTime, dsub$Sub_metering_2, type = "l", col = "red")
points(dsub$DateTime, dsub$Sub_metering_3, type = "l", col = "blue")
legend("topright", names(dsub[7:9]),
       lwd = 2 ,col = c("black", "red", "blue"))

dev.off()