library(lubridate) # package for date-time handling

data <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE) 

# Filter the dataset to include only records from February 1 and 2, 2007
data_use <- subset(data, Date=="1/2/2007" | Date=="2/2/2007") 


# Create a histogram of Global Active Power
graph1 <- function() {
     
     hist(as.numeric(data_use$Global_active_power), col="red", xlab="Global Active Power (killowatts)", main="Global Active Power")
     
}


# Plot Global Active Power over time
graph2 <- function() {
     
     data_use$Datetime <- dmy_hms(paste(data_use$Date, data_use$Time))
     
     # Determine x-axis tick positions at midnight for each unique date
     tick_positions <- as.POSIXct(unique(as.Date(data_use$Datetime)))
     
     # Adds one extra day (86400 seconds) for proper labeling (Saturday).
     tick_positions <- c(tick_positions, max(tick_positions) + 86400)  # Add 1 day (86400 seconds)
     
     # Extracts abbreviated day names (e.g., "Thu", "Fri", "Sat").
     tick_labels <- weekdays(tick_positions, abbreviate = TRUE)
     
     par(mfrow = c(1,1))
     par(mar=c(5,5,3,3))
     plot(data_use$Datetime, data_use$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (killowatts)", main = "")
     axis(1, at = tick_positions, labels = tick_labels)
     
}



# Plot Energy Sub-Metering over time
graph3 <- function() {
     
     data_use$Datetime <- dmy_hms(paste(data_use$Date, data_use$Time))
     
     # Determine x-axis tick positions at midnight for each unique date
     tick_positions <- as.POSIXct(unique(as.Date(data_use$Datetime)))
     
     # Adds one extra day (86400 seconds) for proper labeling (Saturday).
     tick_positions <- c(tick_positions, max(tick_positions) + 86400)  # Add 1 day (86400 seconds)
     
     # Extracts abbreviated day names (e.g., "Thu", "Fri", "Sat").
     tick_labels <- weekdays(tick_positions, abbreviate = TRUE)
     
     par(mfrow = c(1,1))
     par(mar=c(5,5,3,3))
     plot(data_use$Datetime, data_use$Sub_metering_1,  col = "black", type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering", main = "")
     lines(data_use$Datetime, data_use$Sub_metering_2, col = "red")
     lines(data_use$Datetime, data_use$Sub_metering_3, col = "blue")
     axis(1, at = tick_positions, labels = tick_labels)
     legend("topright",pch=c("-", "-", "-"), col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     
}


# Create a 2x2 panel of plots
graph4 <- function() {
     
     data_use$Datetime <- dmy_hms(paste(data_use$Date, data_use$Time))
     
     # Finds unique midnight timestamps from Datetime.
     tick_positions <- as.POSIXct(unique(as.Date(data_use$Datetime)))
     
     # Adds one extra day (86400 seconds) for proper labeling (Saturday).
     tick_positions <- c(tick_positions, max(tick_positions) + 86400)  # Add 1 day (86400 seconds)
     
     # Extracts abbreviated day names (e.g., "Thu", "Fri", "Sat").
     tick_labels <- weekdays(tick_positions, abbreviate = TRUE)
     
     par(mfrow = c(2,2))
     par(mar=c(6,6,4,4))
     plot(data_use$Datetime, data_use$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power", main = "")
     plot(data_use$Datetime, data_use$Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage", main = "")
     plot(data_use$Datetime, data_use$Sub_metering_1,  col = "black", type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering", main = "")
     lines(data_use$Datetime, data_use$Sub_metering_2, col = "red")
     lines(data_use$Datetime, data_use$Sub_metering_3, col = "blue")
     legend("topright",pch=c("-", "-", "-"), col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
     plot(data_use$Datetime, data_use$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime", ylab = "Global reactive power", main = "")
     axis(1, at = tick_positions, labels = tick_labels)
     
}
