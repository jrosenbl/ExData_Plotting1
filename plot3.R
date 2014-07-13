# plot 3
WD = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/ExData_Plotting1/'
IN_DIR = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/'

#  please see read_data.R for the code that inputs the data
source(paste0(WD,'read_data.R'))

hh_energy = read_data()       
png(paste0(IN_DIR,'plot3.png'),480,480)
with(hh_energy, {
  plot(x=date_time,y=sub_metering_1,type='l',xlab='',ylab='Energy Sub Metering')
    points(x=date_time,y=sub_metering_2,type='l',col='red')
    points(x=date_time,y=sub_metering_3,type='l',col='blue')
    legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty=c(1,1,1),col=c('black','red','blue'))
})
dev.off()
message('plot 3 saved')