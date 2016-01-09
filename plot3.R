# add required libraries
library(sqldf)
library(ggplot2)

#get the file out of the archive
unzip("consumption.zip")

#concume required rows
working_file <- file( "household_power_consumption.txt")
attr(working_file, "file.format") <- list(sep = ";", header = TRUE)
working_file.df <- sqldf("SELECT * FROM working_file as D where D.Date in ('1/2/2007','2/2/2007')")

#processing plot 3
png(file="plot3.png", width=480, height=480)
with(working_file.df, plot(Timestamp, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(working_file.df, lines(Timestamp, Sub_metering_1, col="black"))
with(working_file.df, lines(Timestamp, Sub_metering_2, col="red"))
with(working_file.df, lines(Timestamp, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
dev.off()