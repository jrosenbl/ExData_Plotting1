# plot 2
WD = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/ExData_Plotting1/'
IN_DIR = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/'

#  please see read_data.R for the code that inputs the data
source(paste0(WD,'read_data.R'))

hh_energy = read_data()
png(paste0(IN_DIR,'plot2.png'),480,480)
with(hh_energy, plot(x=date_time,y=global_active_power,type='l',xlab='',ylab='Global Active Power (kilowatts)'))
dev.off()
message('plot 2 saved')