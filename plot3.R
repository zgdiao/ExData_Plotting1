#-------------------------------------------------------------------------------
# download and unzip input file

## download the zip file for the project
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exdata_data_household_power_consumption.zip")

## unzip the file
unzip("./exdata_data_household_power_consumption.zip")


#-------------------------------------------------------------------------------
# read and filter input file

## only read data between 1/2/2007 and 2/2/2007
t <- grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value=TRUE)
n <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
df <- read.table(text = t, sep = ';', col.names = n, na.strings = '?')


#-------------------------------------------------------------------------------
# Plot 3: Create a plot for the data time and the energy sub metering

## add date time column and convert it to time
df$Datetime <- paste(df$Date, df$Time, sep = " ")

## convert related columns
df$Datetime <- strptime(df$Datetime, "%d/%m/%Y %H:%M:%S")

## switch the current device to PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot3.png", width = 480, height = 480)

## create the plot
plot(df$Datetime, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(df$Datetime, df$Sub_metering_2, type = "l", col = "red")
lines(df$Datetime, df$Sub_metering_3, type = "l", col = "blue")

## add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

## shut down the specified device
dev.off()
