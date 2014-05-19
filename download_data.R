# Course Project
# Coursera's Getting and Cleaning Data

# to run this code
# source("download_data.R")
# download_data()

# downloading the data
download_data <- function(){
    # name of the file where the downloaded data is saved.
    file_name <- "Dataset.zip"
    file_path <- file.path(".",file_name)
    # check if file exists already
    if (!file.exists(file_path)){
        # url as given in the project instructions
        file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        # download file
        download.file(file_url, destfile = file_path, method = "curl")
        # store download date
        date_file_path <- file.path(".","Source_Info_Dataset.csv")
        write.csv(data.frame(time_downloaded = 
                                 format(Sys.time(),tz="UTC",usetz=TRUE),
                             file_url = file_url),
                  file = date_file_path, row.names = FALSE) 
    }
}



