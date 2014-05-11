## Create plot of Global active power vs. date/time
## using filterd data from download:
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


## merge date and time columns to produce 
## plot of Global_active_power vs. date/time

x <-paste(hpcData$Date, hpcData$Time)
DateTime<- strptime(x, "%d/%m/%Y %H:%M:%S")

plot(DateTime, hpcData$Global_active_power,
      type="l",  
      xlab = "",
      ylab = "Global Active Power (kilowatts)"
     )

##Create PNG file for Plot 2 of Exploratory Data Analysis 
##programming assignment 1

dev.copy(png, file ="Plot2.png")
dev.off()


