read_data = function() {
  # This function returns the data frame used by the plotting scripts plot1.R, plot2.R, plot3.R and plot4.R
  # The source data for this data frame is a 20 MB file that can be downloaded from here
  #    https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
  # This script assumes that this file has been downloaded, unziped and placed in the directory
  # referenced by the variable IN_DIR with the file name referenced by variable IN_FILE.
  #
  # As specified in the assignment, the plots use only a small subet (2 days) of the source data and 
  # since it can take a long time to read in the entire source data file, I've included a couple of
  # options to make make running the plot scripts faster vs reading the entire source data file each time.
  #
  # The first option checks for the existence of the data frame 'hh_energy'.  If it exists the user is 
  # asked if it should be used for the plot. If the user enters 'Y' or 'y', the function simply returns
  # this data frame.  Otherwise it checks for the existence of a subset data file created by an earlier run
  # of this function (referenced by variable 'subset_file') and asks the user if it should be used for the plot.
  # If the user answers 'Y' or 'y' the function inputs this file into a data frame and returns it.
  # Otherwise the function reads the source data file, subsets it, writes the subset to a file and returns
  # a data frame containing the subset.  I tested all 3 options to make sure they produced the same plots.
  #  
  # Uncomment the commands below if you need to increase the heap to accomodate the size of the source data
  # file.  I did not need to on my Mac with 16G.
  # 
  # clear workspace and increase java heap
  # options(java.parameters = '-Xmx3000m') 
  # library(rJava)
  # .jinit()
  
  IN_DIR = '/Users/jrosenbl/documents/learning/Coursera/Exploratory data analysis/'
  IN_FILE = 'household_power_consumption.txt'
  SUBSET_FILE_ROOT = 'hhpower_consumption'
  DAY_1 = '2007-02-01'
  DAY_2 = '2007-02-02'
  subset_file = paste0(IN_DIR,paste(SUBSET_FILE_ROOT,DAY_1,DAY_2,sep='_'),'.txt')
  data_file = paste0(IN_DIR,IN_FILE)
  
  # if the hh_energy data frame exists ask the user if they want to use it
  if (exists('hh_energy')) {
    message('hh_energy with ',nrow(hh_energy),' rows exists')
    yn = readline('use it? ')
    if (yn %in% c('Y','y')) {
      return(hh_energy)
    }
  }
  
  # if the subset file exists ask the user if they want to use it
  if (file.exists(subset_file)) {
    message(subset_file,' exists.')
    yn = readline('use it? ')
    if (yn %in% c('Y','y')) {
      setClass('mkDate')
      setAs("character","mkDate", function(from) as.Date(from, format="%d/%m/%Y") )    
      hh_energy = read.table(subset_file,header=TRUE,sep=';',
                             colClasses=c('mkDate','character',rep('numeric',7),'character'))
      hh_energy$date_time = strptime(hh_energy$date_time,format="%Y-%m-%d %H:%M:%S")
      return(hh_energy)
    }
  }
  
  #  ** First time through -- read the entire source data file **
  # create a date conversion method
  setClass('mkDate')
  setAs("character","mkDate", function(from) as.Date(from, format="%d/%m/%Y") )
 
  # read entire table and convert column names to lowercase
  message('reading ',data_file)
  t1 = Sys.time()
  t_hh_energy = read.table(data_file,na.strings='?',
                           sep=';',header=TRUE,colClasses=c('mkDate','character',rep('numeric',7)))
  t2 = Sys.time()
  d = t2-t1
  message('done. ',format(nrow(t_hh_energy),big.mark=','),' rows read in ',round(d,2),' ',units(d))

  # a good thing I learned in the previous course in this series - clean up column names
  message('changing column names to lowercase')
  colnames(t_hh_energy) = tolower(colnames(t_hh_energy))

  # subset to just the 2 days specified in DAY_1 and DAY_2
  message('subsetting to dates ',DAY_1,' & ',DAY_2)
  hh_energy = t_hh_energy[t_hh_energy$date == DAY_1 | t_hh_energy$date == DAY_2,]
  message(format(nrow(hh_energy),big.mark=','),' rows in subet')
 
  # create a POSIXlt date-time column from the date and time columns
  message('creating date column')
  hh_energy$date_time = strptime(paste(as.character(hh_energy$date),hh_energy$time),format="%Y-%m-%d %H:%M:%S")
 
  # save the subset for later use
  message('saving subset table to ',subset_file)
  write.table(hh_energy,subset_file,row.names=FALSE,sep=';')
 
  return(hh_energy)
}

