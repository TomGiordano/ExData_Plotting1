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
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent", type = c("cairo", "cairo-png", "Xlib", "quartz"))

# Create histogram output
hist(dsub$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Close output device
dev.off()