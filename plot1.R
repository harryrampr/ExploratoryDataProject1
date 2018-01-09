# The script generates Plot #1, a histogram of "Global Active Power". 
#

# Get data if not already available
if (!exists("periodPowerDf")) {
    source("./LoadAndCleanData.R")
}

# Generate plot
png(
    file = "./plot1.png",
    width = 480,
    height = 480,
    units = "px"
)
opar = par(ps = 10,
           mfcol = c(1, 1),
           mar = c(5, 5, 4, 1))

hist(
    periodPowerDf$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowats)",
    col = "red"
)

dev.off()
par(opar)
