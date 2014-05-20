# Check what is meant by the following sentence in features_info.txt:
# 
# "Subsequently, the body linear acceleration and angular velocity 
# were derived in time to obtain Jerk signals 
# (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ)."
#
# I am especially worried about the word jerk with respect to the gyroscope
# which measures angular velocity. If the "derived" in the sentence above refers
# to taking the first derivative, then the variable should not be named Jerk. 
# It should be named angular acceleration.

# implement the normalization that was applied
normalize <- function(x){
    # scale to a width of 2
    x <- x/(max(x)-min(x))*2
    # shift so that minimum is -1
    x <- x-min(x)-1
    # return the normalized data
    x
}

# get the combined feature data
file_path <- file.path("UCI HAR Dataset","test",
                       "X_test.txt")
dfX <- read.table(file_path)
file_path <- file.path("UCI HAR Dataset","train",
                       "X_train.txt")
dfX_train <- read.table(file_path)
dfX <- rbind(dfX,dfX_train)

# read the raw data (after noise filtering) from the gyroscope
file_path <- file.path("UCI HAR Dataset","test","Inertial Signals",
                       "body_gyro_x_test.txt")
df_gyro_x <- read.table(file_path)
file_path <- file.path("UCI HAR Dataset","train","Inertial Signals",
                       "body_gyro_x_train.txt")
df_gyro_x_train <- read.table(file_path)
# combine into one data frame
df_gyro_x <- rbind(df_gyro_x,df_gyro_x_train)

# obtain the row means
gyro_x_means <- rowMeans(df_gyro_x)
head(normalize(gyro_x_means))
# Compare to head(dfX[,121])
summary(normalize(gyro_x_means)-dfX[,121])
#       Min.    1st Qu.     Median       Mean    3rd Qu.       Max.
# -3.065e-08  1.413e-08  1.507e-08  1.516e-08  1.588e-08  5.726e-08
# I take it that I understand what they were doing correctly.

# Now to jerk (Is jerk the first or second derivative of angular velocity?)

# My derivatives here are very simple. They might have used more advanced schemes.
# simple first derivative
first_derivative <- -df_gyro_x[,1:127]+df_gyro_x[,2:128]
head(normalize(rowMeans(first_derivative)))
# Compare to head(dfX[,161]) 161: tBodyGyroJerk-mean()-X
summary(normalize(rowMeans(first_derivative)) - dfX[,161])
#       Min.    1st Qu.     Median       Mean    3rd Qu.       Max.
# -0.2637000 -0.0007028  0.0018640  0.0013130  0.0043240  0.2414000
# most results are quite close.

# simple second derivative
second_derivative <- -first_derivative[,1:126]+first_derivative[,2:127]
head(normalize(rowMeans(second_derivative)))
summary(normalize(rowMeans(second_derivative)) - dfX[,161])
#     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
# -1.20500  0.01466  0.03757  0.03620  0.06011  1.42600
# Roughly an order of magnitude worse than the first derivative.

# Decision: Jerk for Gyro is not angular jerk but angular acceleration!

# My suspicion was confirmed by Jorge from the smart lab team.
# Summary of the email exchange:
# My question:
# In the features_info.txt it says:
# "Subsequently, the body linear acceleration and angular velocity were derived 
# in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ)."
#
# Does this mean that you took the first derivative with respect to time of
# tBodyAcc-XYZ and tBodyGyro-XYZ?
#
# Jorge's answer:
# Regarding to your question, I confirm you we took the derivate of the signal 
# wrt time to obtain the jerk. It has the advantage to remove the DC component 
# from the signal and focus on signal variations.  
#
# In Matlab we used the diff() function for this:
#    e.g.
# derivate = diff(signal);
# derivate(end+1,:) = derivate(end,:); % add missing value
#
# My reply:
# That clarified my confusion. As tBodyGyro refers to angular velocity, 
# I was not sure if tBodyJerk refers to angular acceleration or angular jerk.
#
# Jorge:
# You are right. It refers to angular acceleration, maybe I didn't use the 
# optimal notation. You know that Jerk refers to the derivate of the acceleration 
# http://en.wikipedia.org/wiki/Jerk_(physics) but I used it to name to talk 
# about the derivate of the angular velocity. 

# tBodyAccJerk is the derivative of tBodyAcc 
# tBodyGyroJerk is the derivate of  tBodyGyro



