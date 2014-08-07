### Plot 3
### Mulivariate Line Plot for Sub Metering 1, 2 & 3 over Time

# Dataset: Electric power consumption [20Mb]
# 
# Description: Measurements of electric power consumption in one household with
# a one-minute sampling rate over a period of almost 4 years. Different
# electrical quantities and some sub-metering values are available. The
# following descriptions of the 9 variables in the dataset are taken from the
# UCI web site.
# Date: Date in format dd/mm/yyyy 
# Time: time in format hh:mm:ss 
# Global_active_power: household global minute-averaged active power (in kilowatt) 
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
# Voltage: minute-averaged voltage (in volt) 
# Global_intensity: household global minute-averaged current intensity (in ampere) 
# Sub_metering_1: Kitchen WH (dishwasher, an oven and a microwave)
# Sub_metering_2: Laundry WH (laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.)
# Sub_metering_3: Heating WH (Water Heater / Air Conditioner)60*

# Load data into R
rawdataset <- read.table(file="./household_power_consumption.txt", sep=";", header= TRUE, na.strings="?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Preview Dataset
head(rawdataset)
str(rawdataset)

# Process Date and Time
rawdataset$Date <- strptime(paste(rawdataset$Date, rawdataset$Time), "%d/%m/%Y %H:%M:%S", tz="")
# Drop the now supurflous time
rawdataset <- subset(rawdataset, select=-Time)

# Subset Data to Dates between 2007-02-01 and 2007-02-02
rawdataset <- rawdataset[rawdataset$Date >= strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S") & rawdataset$Date <= strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S"),]

# Drop incomplete date records
rawdataset <- rawdataset[is.na(rawdataset$Date)==0,]
rawdataset[rawdataset == "?"] <- NA #Set ? as NA

# Clean up data set
EPCData <- rawdataset
rm(rawdataset)

# Plot to PNG and save as plot4.png
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
# Set for 2 x 2 presentation TL=1, TR=2, BL=3, BR=4
par(mfrow=c(2,2)) 
# Draw Global Active Power over Time First (TL)
plot(EPCData$Date, EPCData$Global_active_power, type="l", col="Black", main="", xlab="", ylab="Global Active Power")
# Draw Voltage over Time Second (TR)
plot(EPCData$Date, EPCData$Voltage, type="l", col="Black", main="", xlab="datetime", ylab="Voltage")
# Draw Mulivariate Line Plot for Sub Metering 1, 2 & 3 over Time Remove Legend Border (BL)
plot(EPCData$Date, EPCData$Sub_metering_1, type="l", col="Black", main="", xlab="", ylab="Energy sub metering")
points(EPCData$Date, EPCData$Sub_metering_2, type="l", col="Red")
points(EPCData$Date, EPCData$Sub_metering_3, type="l", col="Blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("Black","Red","Blue"), bty="n", lty=1)
# Draw Global Reactive Power over Time (BR)
plot(EPCData$Date, EPCData$Global_reactive_power, type="l", col="Black", main="", xlab="datetime", ylab="Global_reactive_power")
dev.off() # Close file handle