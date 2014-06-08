file <- "../data/household_power_consumption.txt"
data <- read.delim(file, header = TRUE, sep=";", na.strings = "?")
x <- paste(data$Date, data$Time)

data$DateTime <- strptime(x, format = "%d/%m/%Y %T")

dsub <- subset(data, DateTime >= as.POSIXct('2007-02-01 00:00') & DateTime <=
                as.POSIXct('2007-02-02 23:59'))

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", type = c("cairo", "cairo-png", "Xlib", "quartz"))

par(mfrow = c(2,2))
plot(dsub$DateTime, dsub$Global_active_power, xlab = NA, ylab = "Global Active Power", 
     type = "l")

plot(dsub$DateTime, dsub$Voltage, xlab = "datetime", ylab = "Voltage", 
     type = "l")

plot(dsub$DateTime, dsub$Sub_metering_1, xlab = NA, ylab = "Energy sub metering", 
     type = "l")
points(dsub$DateTime, dsub$Sub_metering_2, type = "l", col = "red")
points(dsub$DateTime, dsub$Sub_metering_3, type = "l", col = "blue")
legend("topright", names(dsub[7:9]), bty = "n",
       lwd = 2 ,col = c("black", "red", "blue"))

plot(dsub$DateTime, dsub$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",
     type = "l")

dev.off()