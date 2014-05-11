## Create panel of 4 plots for Exploratory Data Analysis
## Program Assignment 1 

## Uses filtered data from download:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## Download date: 5/10/2014
## Text file:"household_power_consumption.txt"
## Filtered data: Two days worth of data collected from
## 1/2/2007 00:00:00 to  2/2/2007 23:59:00 (dd:mm:yyyy)

## skip row calculations:
## 1 row/min generated from start of file
## 16/12/2006 17:24:00 to 31/1/2007 23:59:00

## nrows = 2*24*60


hpcData <- read.table(file = "household_power_consumption.txt", 
                  sep = ";", 
                  skip = 66637,
                  nrows = 2880)


## following code restores column headers stripped away
## by skip attribute to read.table()

cols<-(colnames(read.table("household_power_consumption.txt",
                   nrow = 1,           #first row contains header names   
                   header = TRUE, 
                   sep=";")))

names(hpcData) <- cols                 #replaces R-generated col names (V1,..)
                                       # with those from colnames() 


## merge date and time columns to produce DateTime column for analysis 

x <-paste(hpcData$Date, hpcData$Time)
DateTime<- strptime(x, "%d/%m/%Y %H:%M:%S")

par(mfrow = c(2,2))   # set up 2 x 2 panel for 4 plots

## PANEL 1  Global active power vs. date/time

plot(DateTime, hpcData$Global_active_power,
      type="l",                                 
      ylab = "Global Active Power"
     )

## PANEL 2  Voltage vs. date/time

plot(DateTime, hpcData$Voltage,
      type="l",                                 
      ylab = "Voltage",
	xlab = "datetime"
     )

## PANEL 3  Multiple metering locations vs. date/time

plot(DateTime, hpcData$Sub_metering_1,    # first line
	type= "l",
      ylab = "Energy sub metering",
      xlab = "")


lines(DateTime, hpcData$Sub_metering_2, col ="red")  #second line
lines(DateTime, hpcData$Sub_metering_3, col ="blue") #third line


legend("topright", lwd = 1,  # add legend to plot
     box.lwd = -1,           # remove box line from legend 
     cex = .86,	           # shrink size of legend to match plot 
     col = c("black", "red", "blue"),
     legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
     )

## PANEL 4  Global reactive power vs. date/time

plot(DateTime, hpcData$Global_reactive_power,
      type="l",                                 
      ylab = "Global_reactive_power",
	xlab = "datetime"
     )

##Create PNG file for Plot 4 of Exploratory Data Analysis 
##programming assignment 1

dev.copy(png, file ="Plot4.png")
dev.off()


