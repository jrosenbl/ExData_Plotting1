# plot 4
WD = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/ExData_Plotting1/'
IN_DIR = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/'

#  please see read_data.R for the code that inputs the data
source(paste0(WD,'read_data.R'))

hh_energy = read_data()
png(paste0(IN_DIR,'plot4.png'),480,480)
par(mfrow=c(2,2))
with(hh_energy, {
     plot(x=date_time,y=global_active_power,type='l',xlab='',ylab='Global Active Power')
     plot(x=date_time,y=voltage,type='l',xlab='datetime',ylab='Voltage')
     plot(x=date_time,y=sub_metering_1,type='l',xlab='',ylab='Energy Sub Metering')
       points(x=date_time,y=sub_metering_2,type='l',col='red')
       points(x=date_time,y=sub_metering_3,type='l',col='blue')
       legend('topright',bty='n',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty=c(1,1,1),col=c('black','red','blue'))
     plot(x=date_time,y=global_reactive_power,type='l',xlab='datetime',ylab='Global_reactive_power')
})
dev.off()