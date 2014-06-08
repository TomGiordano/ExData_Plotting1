file <- "../data/household_power_consumption.txt"
data <- read.delim(file, header = TRUE, sep=";", na.strings = "?")
x <- paste(data$Date, data$Time)

data$DateTime <- strptime(x, format = "%d/%m/%Y %T")

dsub <- subset(data, DateTime >= as.POSIXct('2007-02-01 00:00') & DateTime <=
                as.POSIXct('2007-02-02 23:59'))

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", type = c("cairo", "cairo-png", "Xlib", "quartz"))

hist(dsub$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()