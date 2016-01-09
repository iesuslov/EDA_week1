# add required libraries
library(sqldf)

#get the file out of the archive
unzip("consumption.zip")

#concume required rows
working_file <- file( "household_power_consumption.txt")
attr(working_file, "file.format") <- list(sep = ";", header = TRUE)
working_file.df <- sqldf("SELECT * FROM working_file as D where D.Date in ('1/2/2007','2/2/2007')")

#parse and process the data
png(file="plot1.png", width=480, height=480)
with(working_file.df, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)"))
dev.off()