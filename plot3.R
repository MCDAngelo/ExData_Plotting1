require(data.table)
#the requried data was downloaded and the unzipped file was
#stored in the folder "data"
fileName <- "data/household_power_consumption.txt"
data <- fread(paste("grep ^[12]/2/2007", fileName),na.strings = c("?", ""))
# "grep" lost the headers, so get them
setnames(data, colnames(fread(fileName, nrows=0)))

#Calculate a variable containing date and time information
Dates <- as.Date(data$Date, "%d/%m/%Y")
Times <- data$Time
DateTime <- as.POSIXct(paste(as.character(Dates),as.character(Times)))
#Add it to data.table
data[,DateTime := DateTime]

#make the graph and save it to file plot3.png
png(file = "plot3.png")  #default is 480 x 480 px
plot(data$DateTime, data$Sub_metering_1, 
     ylab = "Energy sub metering",xlab = "", type = "n")
lines(data$DateTime, data$Sub_metering_1, col = "black") #, type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "red") #, type = "l")
lines(data$DateTime, data$Sub_metering_3, col = "blue") #, type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = c(1, 1, 1))
dev.off()



