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

png(file = "plot2.png")  #default is 480 x 480 px
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()