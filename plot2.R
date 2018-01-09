# The script generates Plot #2, a plot of "Global Active Power" vs "DateTime". 
#

# Get data if not already available
if (!exists("periodPowerDf")) {
    source("./LoadAndCleanData.R")
}

# Generate plot
png(
    file = "./plot2.png",
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
             y = Global_active_power,
             xlab = "",
             ylab = "Global Active Power (kilowats)",
             type = "l",
             axes = FALSE,
             ylim = c(0.2, 7.5)
         )
         box()
         middleDayIndex = round(length(DateTime) / 2, 0)
         axis(
             1,
             pos = -0.1,
             at = c(
                 first(DateTime),
                 nth(DateTime, middleDayIndex),
                 last(DateTime)
             ),
             labels = c("Thu", "Fri", "Sat")
         )
         axis(2, at = seq(0, 6, by = 2))
     })
dev.off()
par(opar)
