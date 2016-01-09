# add required libraries
library(sqldf)
library(ggplot2)

#get the file out of the archive
unzip("consumption.zip")

#concume required rows
working_file <- file( "household_power_consumption.txt")
attr(working_file, "file.format") <- list(sep = ";", header = TRUE)
working_file.df <- sqldf("SELECT * FROM working_file as D where D.Date in ('1/2/2007','2/2/2007')")

#processing plot 2
time <- with(working_file.df, paste(Date, Time, sep=" "))
time <- strptime(time, format="%d/%m/%Y %H:%M:%S")
working_file.df$Timestamp <- time

png(file="plot2.png", width=480, height=480)
with(working_file.df, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()