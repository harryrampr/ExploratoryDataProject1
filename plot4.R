# The script generates Plot #4, four different plots on same page.
#

# Get data if not already available
if (!exists("periodPowerDf")) {
    source("./LoadAndCleanData.R")
}

# Generate plots
png(
    file = "./plot4.png",
    width = 480,
    height = 480,
    units = "px"
)
opar = par(ps = 10,
           mfcol = c(2, 2),
           mar = c(4, 4, 4, 2))

#1st Plot
with(periodPowerDf,
     {
         plot(
             x = DateTime,
             y = Global_active_power,
             xlab = "",
             ylab = "Global Active Power",
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

#2nd Plot
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

#3rd Plot
with(periodPowerDf,
     {
         plot(
             x = DateTime,
             y = Voltage,
             xlab = "datetime",
             type = "l",
             axes = FALSE
         )
         box()
         middleDayIndex = round(length(DateTime) / 2, 0)
         axis(1,
              at = c(
                  first(DateTime),
                  nth(DateTime, middleDayIndex),
                  last(DateTime)
              ),
              labels = c("Thu", "Fri", "Sat"))
         axis(2)
     })

# 4th Plot
with(periodPowerDf,
     {
         plot(
             x = DateTime,
             y = Global_reactive_power,
             xlab = "datetime",
             type = "l",
             axes = FALSE
         )
         box()
         middleDayIndex = round(length(DateTime) / 2, 0)
         axis(1,
              at = c(
                  first(DateTime),
                  nth(DateTime, middleDayIndex),
                  last(DateTime)
              ),
              labels = c("Thu", "Fri", "Sat"))
         axis(2)
     })

dev.off()
par(opar)