# Exploratory Data Analysis - Programming assignment 01
#
# Plot 03
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

# Creating the plot:
windows(width = 480, height = 480)

plot(x = 1:length(rel_data$Sub_metering_1), y = rel_data$Sub_metering_1, 
     type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(1:length(rel_data$Sub_metering_2), rel_data$Sub_metering_2, 
      xlab = "", col = "red")
lines(1:length(rel_data$Sub_metering_3), rel_data$Sub_metering_3, 
      xlab = "", col = "blue")
axis(1, at=c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

legend("topright", col = c("black", "red", "blue"), lty = c(1, 1, 1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copying to .png file:
dev.copy(png, file = "plot3.png")
dev.off()
