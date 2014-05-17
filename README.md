# Getting and Cleaning Data Course Project

## Introduction

The purpose of this project is to demonstrate my ability to collect, work with, 
and clean a data set. The goal is to prepare tidy data that can be used for later 
analysis.

Information about the original data (including the license and citation request) 
is given at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and in txt files that are bundled into the zip archive that can be downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

If you run the functions (in run_analysis.R) 
tidy_data() followed by create_tidy_data_set_with_averages()
you create two data sets in a directory called tidyData.

## Files

file name       | description
----------------|---------
download_data.R | Download the original data.
                |
run_analysis.R  | Provide a list of instructions to tidy and aggregate the original data.
                |
                | The function tidy_data() combines the train and test data set of 
                | the original data, adds headers to the columns and adds columns for
                | subject and activity. It stores the resulting tidy data set as
                | a text file sensor_data_for_human_activity.txt in a directory 
                | called tidyData.
                |
                | The function create_tidy_data_set_with_averages() creates a 
                | second data set which contains the mean of the variables
                | for each combination of subject and activity. It stores the resulting
                | file aggregated_mean_sensor_data_for_human_activity.txt in 
                | the tidyData directory.
                |
README.md       | Important general information on the project
                |
CodeBook.md     | Explains the tidy data set
                |
What_is_gyro_jerk.R | Explains the decision to rename variable gyroJerk


## Instruction list

1. The data was downloaded from

    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    
    at datetime 2014-05-13 10:33:28 UTC using the function download_data() 
    in download_data.R

2. The data was selected and tidied using the function tidy_data() in run_analysis.R

3. A clean data set with the medians of variables was created with the function 
    create_tidy_data_set_with_averages() in run_analysis.R

4. The tidy data set was documented in CodeBook.md

## Instructions for the project on the course website (and my interpretation)

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

    Interpretation: Select columns that contain mean(), std() or meanFreq() 
    assuming that frequency 
    components are a measurement, with respect to the second measurement 
    in the instruction.

3. Uses descriptive activity names to name the activities in the data set
    
    Interpretation: Replace the numbers 1 to 6 by the corresponding activity label.

4. Appropriately labels the data set with descriptive activity names.

    Interpretation: Give the columns names that correctly describe the variables.
    See David Hood's comment in the forum 
    https://class.coursera.org/getdata-003/forum/thread?thread_id=15

5. Creates a second, independent tidy data set with the average of each 
    variable for each activity and each subject.

    Interpretation: Store the first tidy data set. Then create a second 
    data set that has the median of each variable for each combination of 
    subject and activity. See David Hood's informal checklist in the forum 
    https://class.coursera.org/getdata-003/forum/thread?thread_id=92.
    
    


## Detailed documentation (somewhat a duplication of run_analysis.R)

### Transforming the variable names

- I decided that explicitly mentioning the time domain was not necessary.

- I decided that explicitly mentioning the magnitude was not necessary. 
    It should be clear that if it is not one of the vector components 
    that it is the magnitude.
    
- I was not sure if the gravity was the only static acceleration, thus I used 
    static acceleration, which seems to be the standard term in accelerometer 
    descriptions.
    
- As jerk is the first time derivative of acceleration, a constant 
    static acceleration won't contribute. Thus I decided to call dynamic jerk 
    just jerk.

- As GyroJerk seems to be the first time derivative of angular velocity, I named 
    it angular acceleration. (see What_is_gyro_jerk.R for details)
    
- To indicate that the data is in the frequency domain, I used spectral in the 
    variable name.

 old names         | new names                
-------------------|--------------------------
 tBodyAcc-XYZ      | dynamic_acceleration_xyz  
 tGravityAcc-XYZ   | static_acceleration_xyz   
 tBodyAccJerk-XYZ  | jerk_xyz 
 tBodyGyro-XYZ     | angular_velocity_xyz     
 tBodyGyroJerk-XYZ | angular_acceleration_xyz
 tBodyAccMag       | dynamic_acceleration
 tGravityAccMag    | static_acceleration
 tBodyAccJerkMag   | jerk 
 tBodyGyroMag      | angular_velocity
 tBodyGyroJerkMag  | angular_acceleration
 fBodyAcc-XYZ      | spectral_dynamic_acceleration_xyz
 fBodyAccJerk-XYZ  | spectral_jerk_xyz
 fBodyGyro-XYZ     | spectral_angular_velocity_xyz
 fBodyAccMag       | spectral_dynamic_acceleration
 fBodyAccJerkMag   | spectral_jerk
 fBodyGyroMag      | spectral_angular_velocity
 fBodyGyroJerkMag  | spectral_angular_acceleration


- mean() is changed to mean at the beginning of the name
- std() is changed to standard_deviation at the beginning of the name
- meanFreq() is changed to mean_frequency at the beginning of the name


## Decisions

- When combining the test and train data sets into one file, I decided to drop the information about which observations were in the train and test data sets, i.e. I did not create a partition column with values train and test. As they were randomly partitioned and we are not using the data set to reproduce the results of the paper that the creators of the data set published, I did not think that the information was worth saving.

- I renamed the variables according to the safe naming conventions by Hadley Wickham at http://adv-r.had.co.nz/Style.html. This means I used underscores to separate words. I am aware that this might not be in agreement with the opinion of the instructor of this course. I also tried to have meaningful names that avoid disinformation. Thus my names might be very different from the ones in the raw data set. See CodeBook.md for details.

- In my attempt to create meaningful variable names, I made the decision that GyroJerk was mislabeled in the original data (see What_is_gyro_jerk.R script for details). As I believe it is the first derivative of angular velocity, it should be labeled as angular acceleration.

- To extract measurements on the mean and standard deviation, I decided to include the variables that were obtained with the "estimation"" techniques mean(), std(), and meanFreq(). The meanFreq() was included, as I decided that the frequency components were also a measurement.

- The average in step 5) of the instructions is the median. 
    I use the median, as the mean does not make sense for at least the 
    mean_static_acceleration_z of subject 28 laying. If you plot a histogram 
    of the 2.56 second window means for this case, you will find that there are 
    two peaks of similar height at -1.0 and at +1.0. The mean would produce 
    a result of 0.0158, while the median produces a result of 0.830 which is more 
    representative of the data. However, a different summary might be more appropriate.

- Changed activity labels walking_up_stairs and walking_downstairs to walking_up_stairs 
and walking_down_stairs as this acitivity was pictured in the paper referenced in 
the original data.
