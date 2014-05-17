# aggregated mean sensor data for human activity data set

This code book describes the tidy data set 
aggregated_mean_sensor_data_for_human_activity.txt created by the function 
create_tidy_data_set_with_averages() in run_analysis.R.

This document has two sections:

1. the code book describing the variables

2. the study design giving information about how the data was collected

## Code book

### Variable composition

There a two fixed variables (given in the first two columns of the data set):

- **subject**: 
    The subject performing the activity and wearing the smartphone while 
    the data was recorded. The subjects are identified by numbers 1 to 30.

- **activity**:
    The activity performed by the subject while the smartphone sensor data 
    was recorded. The activities are laying, sitting, standing, walking, 
    walking_down_stairs, walking_up_stairs.


There are 79 measured numerical variables in the data set. As the original data 
had been normalized the variables are dimensionless. The measured variables 
are build up from five bases:

- **dynamic_acceleration**:
    The accelerations measured by the accelerometer which have features 
    in the frequency range between 0.3 and 20 Hz.

- **static_acceleration**:
    The accelerations measured by the accelerometer which have features 
    with frequencies below 0.3 Hz.

- **jerk**:
    The first time derivative of dynamic acceleration.
    
- **angular_velocity**:
    The angular velocities measured by the gyroscope which have features
    with frequencies below 20 Hz.

- **angular_acceleration**:
    The first time derivative of angular velocity.
        
The accelerometer and gyroscope are 3-axial. Thus they measure a vector in 
the coordinate system of the smartphone. The variables are mappings of this 
vector to one dimension. There are four different mappings:

- **x**, **y** or **z**: 
    If the variable name is followed by x, y or z, then the mapping projects 
    the x, y or z vector component.

- variable not followed by x, y, or z: 
    If the variable name is not followed by x, y or z, the reported quantity 
    is the Euclidean norm (**magnitude**).

There are three summaries that have been performed:

- **median_mean**: 
    This is the median for each subject and activity of the normalized 
    means of the 2.56 second fixed-width windows.

- **median_standard_deviation**: 
    This is the median for each subject and activity of the normalized standard 
    deviations of the 2.56 second fixed-width windows.
                            
- **median_mean_frequency**: 
    This is the median for each subject and activity of the normalized mean 
    frequency of the 2.56 second fixed-width windows.

There is one transformation that has been performed on some variables:

- **spectral**:
    A Fast Fourier Transform has been performed on the time domain variable
    to convert it to the frequency domain. Variables that do not contain 
    spectral in their name are in the time domain.

### List of all variables

column number | variable
--------------|-----------
 [1] |"subject"                                                  
 [2] |"activity"                                                 
 [3] |"median_mean_dynamic_acceleration_x"                       
 [4] |"median_mean_dynamic_acceleration_y"                       
 [5] |"median_mean_dynamic_acceleration_z"                       
 [6] |"median_standard_deviation_dynamic_acceleration_x"         
 [7] |"median_standard_deviation_dynamic_acceleration_y"         
 [8] |"median_standard_deviation_dynamic_acceleration_z"         
 [9] |"median_mean_static_acceleration_x"                        
[10] |"median_mean_static_acceleration_y"                        
[11] |"median_mean_static_acceleration_z"                        
[12] |"median_standard_deviation_static_acceleration_x"          
[13] |"median_standard_deviation_static_acceleration_y"          
[14] |"median_standard_deviation_static_acceleration_z"          
[15] |"median_mean_jerk_x"                                       
[16] |"median_mean_jerk_y"                                       
[17] |"median_mean_jerk_z"                                       
[18] |"median_standard_deviation_jerk_x"                         
[19] |"median_standard_deviation_jerk_y"                         
[20] |"median_standard_deviation_jerk_z"                         
[21] |"median_mean_angular_velocity_x"                           
[22] |"median_mean_angular_velocity_y"                           
[23] |"median_mean_angular_velocity_z"                           
[24] |"median_standard_deviation_angular_velocity_x"             
[25] |"median_standard_deviation_angular_velocity_y"             
[26] |"median_standard_deviation_angular_velocity_z"             
[27] |"median_mean_angular_acceleration_x"                       
[28] |"median_mean_angular_acceleration_y"                       
[29] |"median_mean_angular_acceleration_z"                       
[30] |"median_standard_deviation_angular_acceleration_x"         
[31] |"median_standard_deviation_angular_acceleration_y"         
[32] |"median_standard_deviation_angular_acceleration_z"         
[33] |"median_mean_dynamic_acceleration"                         
[34] |"median_standard_deviation_dynamic_acceleration"           
[35] |"median_mean_static_acceleration"                          
[36] |"median_standard_deviation_static_acceleration"            
[37] |"median_mean_jerk"                                         
[38] |"median_standard_deviation_jerk"                           
[39] |"median_mean_angular_velocity"                             
[40] |"median_standard_deviation_angular_velocity"               
[41] |"median_mean_angular_acceleration"                         
[42] |"median_standard_deviation_angular_acceleration"           
[43] |"median_mean_spectral_dynamic_acceleration_x"              
[44] |"median_mean_spectral_dynamic_acceleration_y"              
[45] |"median_mean_spectral_dynamic_acceleration_z"              
[46] |"median_standard_deviation_spectral_dynamic_acceleration_x"
[47] |"median_standard_deviation_spectral_dynamic_acceleration_y"
[48] |"median_standard_deviation_spectral_dynamic_acceleration_z"
[49] |"median_mean_frequency_spectral_dynamic_acceleration_x"    
[50] |"median_mean_frequency_spectral_dynamic_acceleration_y"    
[51] |"median_mean_frequency_spectral_dynamic_acceleration_z"    
[52] |"median_mean_spectral_jerk_x"                              
[53] |"median_mean_spectral_jerk_y"                              
[54] |"median_mean_spectral_jerk_z"                              
[55] |"median_standard_deviation_spectral_jerk_x"                
[56] |"median_standard_deviation_spectral_jerk_y"                
[57] |"median_standard_deviation_spectral_jerk_z"                
[58] |"median_mean_frequency_spectral_jerk_x"                    
[59] |"median_mean_frequency_spectral_jerk_y"                    
[60] |"median_mean_frequency_spectral_jerk_z"                    
[61] |"median_mean_spectral_angular_velocity_x"                  
[62] |"median_mean_spectral_angular_velocity_y"                  
[63] |"median_mean_spectral_angular_velocity_z"                  
[64] |"median_standard_deviation_spectral_angular_velocity_x"    
[65] |"median_standard_deviation_spectral_angular_velocity_y"    
[66] |"median_standard_deviation_spectral_angular_velocity_z"    
[67] |"median_mean_frequency_spectral_angular_velocity_x"        
[68] |"median_mean_frequency_spectral_angular_velocity_y"        
[69] |"median_mean_frequency_spectral_angular_velocity_z"        
[70] |"median_mean_spectral_dynamic_acceleration"                
[71] |"median_standard_deviation_spectral_dynamic_acceleration"  
[72] |"median_mean_frequency_spectral_dynamic_acceleration"      
[73] |"median_mean_spectral_jerk"                                
[74] |"median_standard_deviation_spectral_jerk"                  
[75] |"median_mean_frequency_spectral_jerk"                      
[76] |"median_mean_spectral_angular_velocity"                    
[77] |"median_standard_deviation_spectral_angular_velocity"      
[78] |"median_mean_frequency_spectral_angular_velocity"          
[79] |"median_mean_spectral_angular_acceleration"                
[80] |"median_standard_deviation_spectral_angular_acceleration"  
[81] |"median_mean_frequency_spectral_angular_acceleration" 

## Study Design

The data shown in this project was downloaded (2014-05-13 10:33:28 UTC) from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Information about how the original data was collected is given in the README.txt and 
features_info.txt contained in the zip file. I summarize the information here 
in the first section. Please, read the original information for more details. 
In the second section, I explain my added summary choices.

### Gathering of the original data

The experiments have been carried out with a group of 30 volunteers within an 
age bracket of 19-48 years. Each person performed six activities (walking, 
walking_up_stairs, walking_down_stairs, sitting, standing, laying) 
wearing a smartphone (Samsung Galaxy S II) on the waist.

The experiments have been video recorded to label the data manually
with the correct activities.

The 3-axial raw signals of the accelerometer and gyroscope of the 
smartphone have been sampled at a constant rate of 50 Hz while the subject was 
performing an activity.
The accelerometer measures acceleration in standard units of gravity g and 
the gyrospcope measures the angular velocity vector in radians/second.

All signals were filtered using a median filter and a 3rd-order low-pass 
Butterworth filter with a corner (cutoff) frequency of 20 Hz to remove noise.
The results are the angular velocity and total acceleration.

The noise-filtered acceleration was then again filtered with a Butterworth 
filter with a corner frequency of 0.3 Hz resulting in the 
static acceleration. The dynamic acceleration was obtained by subtracting the 
static acceleration from the total acceleration.

The data were split using a fixed-width sliding window of 2.56 sec 
(2.56 seconds/window * 50 readings/second = 128 readings/window) and 50% overlap.

To obtain jerk and angular acceleration, the first time derivative of the dynamic 
acceleratioin and the angular velocity were taken, respectively.

In some cases (labeled spectral) the results were fast Fourier transformed from 
the time domain to the frequency doamin.

The data in the windows were then summarized using mean, standard 
deviation and mean frequency on the data in individual windows. 
Mean frequency computed a weighted average of the frequency components. 
Obviously this was only done for spectral quantities.

The resulting measurements were normalized (across all subjects and activities)
and bounded within [-1,1].

### My summary choices

The previous steps have been performed by the creators of the original data set.
The data presented in this data set, summarizes the previous results.

The medians for each combination of subject and activity were taken for 
each variable in the data set. The median was chosen because the mean is not a 
good summary of the data for some cases, e.g. the mean 
of mean_static_acceleration_z subject 28 laying as detailed in the README.
