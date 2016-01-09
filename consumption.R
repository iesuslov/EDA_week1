# add required libraries
library(sqldf)
library(ggplot2)

#get the file out of the archive
unzip("consumption.zip")

#concume required rows
working_file <- file( "household_power_consumption.txt")
attr(working_file, "file.format") <- list(sep = ";", header = TRUE)
working_file.df <- sqldf("SELECT * FROM working_file as D where D.Date in ('1/2/2007','2/2/2007')")

#processing plot 1
png(file="plot1.png", width=480, height=480)
with(working_file.df, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)"))
dev.off()

#processing plot 2
time <- with(working_file.df, paste(Date, Time, sep=" "))
time <- strptime(time, format="%d/%m/%Y %H:%M:%S")
working_file.df$Timestamp <- time

png(file="plot2.png", width=480, height=480)
with(working_file.df, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()

#processing plot 3
png(file="plot3.png", width=480, height=480)
with(working_file.df, plot(Timestamp, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(working_file.df, lines(Timestamp, Sub_metering_1, col="black"))
with(working_file.df, lines(Timestamp, Sub_metering_2, col="blue"))
with(working_file.df, lines(Timestamp, Sub_metering_3, col="red"))
legend("topright", col=c("black", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
dev.off()

#processing plot 4
png(file="plot4.png", width=480, height=480)
# define the 2x2 set
par(mfrow=c(2,2))
# Draw first plot
with(working_file.df, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
# Draw second plot
with(working_file.df, plot(Timestamp, Voltage, type="l", xlab="", ylab="Voltage"))
# Draw third plot
with(working_file.df, plot(Timestamp, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(working_file.df, lines(Timestamp, Sub_metering_1, col="black"))
with(working_file.df, lines(Timestamp, Sub_metering_2, col="red"))
with(working_file.df, lines(Timestamp, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
# Draw fourth plot
with(working_file.df, plot(Timestamp, Global_reactive_power, type="l", xlab="", ylab="Global Reactive Power"))
# Close the png device
dev.off()