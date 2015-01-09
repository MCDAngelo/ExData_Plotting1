require(data.table)
#the requried data was downloaded and the unzipped file was
#stored in the folder "data"
fileName <- "data/household_power_consumption.txt"
data <- fread(paste("grep ^[12]/2/2007", fileName),na.strings = c("?", ""))
# "grep" lost the headers, so get them
setnames(data, colnames(fread(fileName, nrows=0)))

png(file = "plot1.png") #default is 480 x 480 px
hist(data$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
