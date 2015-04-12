# Exploratory Data Analysis - Programming assignment 01
#
# Plot 04
#

# R initialization:
library(data.table)

# Getting the data and unzipping the file:
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "exdata-data-household_power_consumption.zip")

zip_filename <- 'exdata-data-household_power_consumption.zip'
unzip(zip_filename)

# Reading the data:
power_data <- read.table(dat_filename, header = TRUE, sep = ";",
                         na.strings = "?")

# Extracting relevant indices:
idx1 <- (as.Date(strptime(power_data$Date, "%d/%m/%Y")) >= date_start)
idx2 <- (as.Date(strptime(power_data$Date, "%d/%m/%Y")) <= date_end)
rel_idx <- idx1 & idx2

# Subsetting target data:
rel_data <- power_data[rel_idx, ]

# Creating the plots:
windows(width = 480, height = 480)
par(mfrow = c(2, 2))

# Plot (1,1):
plot(x = 1:length(rel_data$Global_active_power), 
     y = rel_data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power", xaxt = "n")
axis(1, at=c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# Plot (1,2):
plot(x = 1:length(rel_data$Voltage), 
     y = rel_data$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage", xaxt = "n")
axis(1, at=c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# Plot (2,1):
plot(x = 1:length(rel_data$Sub_metering_1), y = rel_data$Sub_metering_1, 
     type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(1:length(rel_data$Sub_metering_2), rel_data$Sub_metering_2, 
      xlab = "", col = "red")
lines(1:length(rel_data$Sub_metering_3), rel_data$Sub_metering_3, 
      xlab = "", col = "blue")
axis(1, at=c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

legend("topright", col = c("black", "red", "blue"), lty = c(1, 1, 1),
       box.lwd = "",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot (2,2):
plot(x = 1:length(rel_data$Global_reactive_power), 
     y = rel_data$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power", 
     xaxt = "n")
axis(1, at=c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# Copying to .png file:
dev.copy(png, file = "plot4.png")
dev.off()
