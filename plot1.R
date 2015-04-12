# Exploratory Data Analysis - Programming assignment 01
#
# Plot 01
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
hist(rel_data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "red1")

# Copying to .png file:
dev.copy(png, file = "plot1.png")
dev.off()
