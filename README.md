# Getting-and-Cleaning-Data
Course Project submission

##Working Directory and Files

The two packages, dplyr and utils should be installed and loaded before setting working directory and downloading data

## 
## Attaching package: 'dplyr'
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
As my computer has C as hard drive name, I would like to start the directory as C, then download the data set before unzip the file. The final directory is then directed to the data set

This is the link to download the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

List of Variables:

Activity <- store table “activity_labels, which is used to decode y_train, y_test. Solve the problem 3: Uses descriptive activity names to name the activities in the data set
Features <- store table “features”, which is used to name columns of X_train
subject_train <- store the subject_train in train folder
X_train <- store the X_train in train folder
y_train <- store the y_train in train folder
subject_test <- store the subject_test in test folder
X_test <- store the X_test in test folder
y_test <- store the y_test in train folder
Subject <- Merger of subject_train and subject_test
Y <- Merger of y_train and y_test
X <- Merger of X_train and X_test

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. This step will apply group_by and summarize_all.

Tidy_Data <- Extract_Data %>% group_by(Activity,Subject_No) %>% summarise_all(funs(mean))

#write the Tidy_Data in csv file
if(!file.exists("Tidy_Data.txt")){write.table(Tidy_Data,"Tidy_Data.txt", row.names = FALSE)}
