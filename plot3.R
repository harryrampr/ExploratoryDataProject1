# The script generates Plot #3, a plot of "Energy Sub metering" vs "DateTime". 
#

# Get data if not already available
if (!exists("periodPowerDf")) {
    source("./LoadAndCleanData.R")
}

# Generate plot
png(
    file = "./plot3.png",
    width = 480,
    height = 480,
    units = "px"
)
opar = par(ps = 10,
           mfcol = c(1, 1),
           mar = c(4, 5, 3, 2))
with(periodPowerDf,
     {
         plot(
             x = DateTime,
             y = Sub_metering_1,
             xlab = "",
             ylab = "Energy sub metering",
             type = "l",
             axes = FALSE,
             ylim = c(0, 38.5)
         )
         lines(x = DateTime,
               y = Sub_metering_2, col = "red")
         lines(x = DateTime,
               y = Sub_metering_3, col = "blue")
         box()
         middleDayIndex = round(length(DateTime) / 2, 0)
         axis(
             1,
             pos = -1.5,
             at = c(
                 first(DateTime),
                 nth(DateTime, middleDayIndex),
                 last(DateTime)
             ),
             labels = c("Thu", "Fri", "Sat")
         )
         axis(2, at = seq(0, 30, by = 10))
         legend(
             "topright",
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             lty = c(1, 1, 1),
             lwd = c(1, 1, 1),
             col = c("black", "red", "blue"),
             cex = 0.95,
             x.intersp = 1,
             y.intersp = .9
         )
     })
dev.off()
par(opar)
