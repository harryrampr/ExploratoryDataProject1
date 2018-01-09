# This script will download, save to disk, load, clean and filter the data
# required to generates plots for "Course Project 1"
#
library(utils)
library(dplyr)
#setwd("~/Documents/DataScience/Coursera/R Files/ExploratoryDataAnalysis/CourseProject1")

dataUrl <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

dataFileName <- "./Data/household_power_consumption.txt"

# Download data if needed
if (!file.exists(dataFileName)) {
    dataZipFile <- "./household_power_consumption.zip"
    download.file(dataUrl, dataZipFile)
    unzip(dataZipFile, exdir = "./Data")
}

# Test data memory requirements
memoryTestDf <-
    read.table(
        dataFileName,
        sep = ";",
        header = TRUE,
        nrows = 100,
        stringsAsFactors = FALSE
    )
memSize <-
    format(object.size(memoryTestDf) * 2075.259,
           units = "GB",
           quote = FALSE)
memSize
rm(memoryTestDf)

# Read data from file
powerDf <-
    read.table(
        dataFileName,
        sep = ";",
        header = TRUE,
        na.strings = "?",
        colClasses = c(
            "character",
            "character",
            "numeric",
            "numeric",
            "numeric",
            "numeric",
            "numeric",
            "numeric",
            "numeric"
        ),
        stringsAsFactors = FALSE
    )
str(powerDf)

# Set period of interest
periodStart <-
    as.POSIXct(strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S", tz = "GMT"))
periodStart

periodEnd <-
    as.POSIXct(strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S", tz = "GMT"))
periodEnd

# Clean and filter data
periodPowerDf <- powerDf %>%
    mutate(DateTime = as.POSIXct(strptime(
        paste(Date, Time), "%d/%m/%Y %H:%M:%S", tz = "GMT"
    ))) %>%
    filter(DateTime >= periodStart &
               DateTime <= periodEnd) %>%
    select(DateTime, everything()) %>%
    select(-c(Date, Time)) %>%
    arrange(DateTime)

str(periodPowerDf)
head(periodPowerDf)
tail(periodPowerDf)

#rm(powerDf)
