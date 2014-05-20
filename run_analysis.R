# Course Project
# Coursera's Getting and Cleaning Data

# This files consists of two top-level functions
# create_tidy_data_set_with_averages and tidy_data.
#
# To create the two tidy data sets run:
# source("run_analysis.R")
# tidy_data()
# create_tidy_data_set_with_averages()

# tidy_data performs the first 4 steps from the instructions:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive activity names.
# This results in the data set sensor_data_for_human_activity.txt

# create_tidy_data_set_with_averages does the final step from the instructions
# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# This results in the data set aggregated_mean_sensor_data_for_human_activity.txt

# The two resulting data sets are stored in the folder tidy_directory.
# tidy_data uses a temporary directory temp_directory

# name of the directory used to store data temporarily
temp_directory <- "temp"
# name of the directory where the tidy data sets sill be stored
tidy_directory <- "tidyData"

# function to create the second tidy data set with the average (median) of each 
# variable for each combination of subject and activity
create_tidy_data_set_with_averages <- function(){
    # read the first tidy data set
    file_path <- file.path(tidy_directory, "sensor_data_for_human_activity.txt")
    df <- read.table(file_path, header=TRUE)
    # calculate the median for each measurement column grouped by subject and activity
    n_columns <- length(df)
    aggregated_median_sensor_data_for_human_activity <- aggregate(df[3:n_columns], 
                                                                  by=as.list(df[1:2]), 
                                                                  FUN = median)
    # create nice column names (median + measured variable)
    column_names <- names(df)
    column_names[3:n_columns] <- paste0("median_",column_names[3:n_columns])
    names(aggregated_median_sensor_data_for_human_activity) <- column_names
    # store data in the tidy data folder
    save_in_tidy_directory(aggregated_median_sensor_data_for_human_activity)
}

# function to create the first tidy data set
tidy_data <- function(){
    # unzip file Dataset.zip
    unzip_file()
    # create temporary directory
    create_directory(temp_directory)
    # Merge the training and the test sets to create one data set
    # in the temporary directory
    create_joined_data_files_in_temp()
    # read the data_file from the temporary directory
    # and tidy the data
    sensor_data_for_human_activity <- get_combined_data()
    # remove the temporary directory and its content
    delete_temporary_directory()
    # create directory for tidy data
    create_directory(tidy_directory)
    # save data in tidy direcotry
    save_in_tidy_directory(sensor_data_for_human_activity)   
}

save_in_tidy_directory <- function(data_frame){
    # get the name of data_frame, e.g. if data_frame = x, then the result is "x"
    data_frame_name <- deparse(substitute(data_frame))
    # set the path
    file_path <- file.path(tidy_directory,paste0(data_frame_name,".txt"))
    # write the data frame to a txt file without the row names
    write.table(data_frame, file=file_path, row.names = FALSE)
}

get_combined_data <- function(){
    # get the column names as the second column from features.txt
    column_names <- read.table(file.path(temp_directory,"features.txt"))[,2]
    # get indices of columns that have statistics: mean, std, or meanFreq
    relevant_column_indices <- grep("(?:mean|std)",column_names)
    # keep only the names of the relevant columns and clean them up
    column_names <- clean_column_names(column_names[relevant_column_indices])
    # set up a mask to read only the relevant columns
    # 561 is the number of columns in X.txt
    column_mask <- rep("NULL",561)
    column_mask[relevant_column_indices] <- "numeric" 
    # read the data
    dfX <- read.table(file.path(temp_directory,"X.txt"),
                      colClasses = column_mask)
    # name the columns
    names(dfX) <- column_names
    
    # add the activity variable to the data
    # get the activity labels
    dfactivity <- read.table(file.path(temp_directory,"activity_labels.txt"))
    # clean the activity labels
    dfactivity[,2] <- clean_activity_names(dfactivity[,2])
    # get the activities corresponding to the rows
    dfy <- read.table(file.path(temp_directory,"y.txt"))
    # replace the integer by descriptive labels
    dfy <- dfactivity[dfy[,1],2]
    # add column to the data frame
    dfX[,"activity"] <- dfy
    
    # add the subject variable
    subjects <- read.table(file.path(temp_directory,"subject.txt"))
    dfX[,"subject"] <- subjects[,1]
    
    # sort the columns (move fixed variables to the front)
    dfX <- dfX[,c(length(dfX), length(dfX)-1, 1:(length(dfX)-2))]
    
    #return the data frame
    dfX
}

clean_activity_names <- function(activity_names){
    # clean up the activity names
    # convert to lower case
    activity_names <- tolower(activity_names)
    # ensure the meaning is clear, separate words by underscore 
    # (see comment in README.md)
    activity_names[grep("upstair",activity_names)] <- "walking_up_stairs"
    activity_names[grep("downstair",activity_names)] <- "walking_down_stairs"
    # return the clean activity names
    activity_names
}

clean_column_names <- function(column_names){
    # tidy the column names
    # I decided to use underscores (see comment in README.md)
    
    # The new names are composed of the following elements as follows
    # statistic _ fourier_transform _ measurement _ component
    # therefore I create empty character vectors first.
    # Afterwards I obtain the corresponding entries for the variables
    # and finally combine the elements into the variable names.
    
    # length of vectors
    n_names <- length(column_names)
    
    # check if the variable is in the frequency domain
    fourier_transform <- character(n_names)
    # search for all names starting with f
    # (I hope that spectral is understood as frequency spectrum related quantity)
    fourier_transform[grep("^f", column_names)] <- "spectral_"
    
    # check for the statistic
    statistic <- character(n_names)
    # search mean not followed by F
    statistic[grep("mean[^F]", column_names)] <- "mean_"
    # search std
    statistic[grep("std", column_names)] <- "standard_deviation_"
    # search meanFreq
    statistic[grep("meanFreq", column_names)] <- "mean_frequency_"
    
    # convert the measurement names
    # this also finds the variables that contain BodyBody
    measurement <- character(n_names)
    measurement[grep("BodyAcc", column_names)] <- "dynamic_acceleration"
    measurement[grep("GravityAcc", column_names)] <- "static_acceleration"
    measurement[grep("BodyAccJerk", column_names)] <- "jerk"
    measurement[grep("BodyGyro", column_names)] <- "angular_velocity"
    measurement[grep("BodyGyroJerk", column_names)] <- "angular_acceleration"
    
    # add vector components
    component <- character(n_names)
    # check if name ends in XYZ
    component[grep("X$",column_names)] <- "_x"
    component[grep("Y$",column_names)] <- "_y"
    component[grep("Z$",column_names)] <- "_z"
    
    # assemble names    
    column_names <- paste0(statistic,fourier_transform,measurement,component)
    # return clean column names
    column_names
}

create_joined_data_files_in_temp <- function(){
    # create a joined data set in the temp folder
    # copies files activity_labels.txt, features.txt,
    # subject_*.txt, X_*.txt and y_*.txt where * is train or test.
    # This discards the information about which part was in the 
    # training set and which part was in the test set.
    
    # source data directory
    directory <- "UCI HAR Dataset"
    # copy activity_labels.txt to the temporary directory
    activity_labels_file <- "activity_labels.txt"
    activity_labels_file_path <- file.path(directory,activity_labels_file)
    target_file_path <- file.path(temp_directory,activity_labels_file)
    if (file.exists(activity_labels_file_path)){
        file.copy(activity_labels_file_path, target_file_path, overwrite = TRUE)
    } else {
        stop("File does not exist")
    }
    
    # copy activity_labels.txt to the temporary directory
    features_file <- "features.txt"
    features_file_path <- file.path(directory,features_file)
    target_file_path <- file.path(temp_directory,features_file)
    if (file.exists(features_file_path)){
        file.copy(features_file_path, target_file_path, overwrite = TRUE)
    } else {
        stop("File does not exist")
    }
    
    # files in the train and test subdirectory
    file_name_bases <- c("subject","X","y")
    for (file_name_base in file_name_bases){
        # create path to the target file in the temporary directory
        target_file <- paste0(file_name_base,".txt")
        target_file_path <- file.path(temp_directory,target_file)
        
        # copy the file from the test subdirectory
        # to the target file
        source_file <- paste0(file_name_base,"_test.txt")
        source_file_path <- file.path(directory,"test",source_file)
        if (file.exists(source_file_path)){
            file.copy(source_file_path, target_file_path, overwrite = TRUE)
        } else {
            stop("File does not exist")
        }
        # append the target file in the temp directory
        # with the file from the train subdirectory
        source_file <- paste0(file_name_base,"_train.txt")
        source_file_path <- file.path(directory,"train",source_file)
        if (file.exists(source_file_path)){
            file.append(target_file_path, source_file_path)
        } else {
            stop("File does not exist")
        }
    }
}


# create directory for temporary data
create_directory <- function(directory){ 
    if (!file.exists(directory)){
        dir.create(directory)
    }    
}
# delete directory with temporary data
delete_temporary_directory <- function(){ 
    if (file.exists(temp_directory)){
        unlink(temp_directory, recursive = TRUE)
    }    
}

# unzip the downloaded file called Dataset.zip
unzip_file <- function(){
    file_name <- "Dataset.zip"
    file_path <- file.path(".",file_name)
    if (file.exists(file_path)){
        unzip(file_path, overwrite = FALSE) 
    } else {
        stop("You need to download the data first.")
    }
}
