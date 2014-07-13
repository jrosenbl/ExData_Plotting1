# plot 1
WD = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/ExData_Plotting1/'
IN_DIR = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/'

#  please see read_data.R for the code that inputs the data
source(paste0(WD,'read_data.R'))

hh_energy = read_data()
png(paste0(IN_DIR,'plot1.png'),480,480)
with(hh_energy, hist(global_active_power,col='red',main='Global Active Power',xlab='Global Active Power (kilowatts)'))
dev.off()
message('plot 1 saved')