# Use local file for input.
#file <- "../data/household_power_consumption.txt"
#data <- read.delim(file, header = TRUE, sep=";", na.strings = "?")

# Download input file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method = "wget")
# Unzip and read input
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", na.strings = "?")
unlink(temp)

# Create datetime object
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %T")

# Subset dataset
dsub <- subset(data, DateTime >= as.POSIXct('2007-02-01 00:00') & DateTime <=
                 as.POSIXct('2007-02-02 23:59'))

# Open graphical output device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", type = c("cairo", "cairo-png", "Xlib", "quartz"))

# Set graphics array
par(mfrow = c(2,2))

# Draw plot
plot(dsub$DateTime, dsub$Global_active_power, xlab = NA, ylab = "Global Active Power",
     type = "l")

# Draw plot
plot(dsub$DateTime, dsub$Voltage, xlab = "datetime", ylab = "Voltage",
     type = "l")

# Draw plot
plot(dsub$DateTime, dsub$Sub_metering_1, xlab = NA, ylab = "Energy sub metering",
     type = "l")
# Add additional points
points(dsub$DateTime, dsub$Sub_metering_2, type = "l", col = "red")
points(dsub$DateTime, dsub$Sub_metering_3, type = "l", col = "blue")
# Draw legend
legend("topright", names(dsub[7:9]), bty = "n",
       lwd = 2 ,col = c("black", "red", "blue"))

# Draw plot
plot(dsub$DateTime, dsub$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",
     type = "l")

# Close output device
dev.off()