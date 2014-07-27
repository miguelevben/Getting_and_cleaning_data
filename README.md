 
 
##  Getting and cleaning data Project   

Project for collect and clean a data set for John Hopkins-Coursera "Getting and Cleaning data" course (Data Sciences specialization)

 **ABSTRACT**  

The purpose of this project is to demonstrate how collect, work and clean a data set.  The goal is to prepare a tidy data can be used for later analysis.

**INTRODUCTION**

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

The data can be obtained in this link:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

You can find extra information about the variables, data and transformations in the "CodeBook.md" file included in this repo.

The included script "run_analysis.R" automatically performs the whole process for obtain a tidy data set as explained below:

**"run_analysis.R" PROCESS DESCRIPTION**

The script contain an unique function "run_analysis(directory,file)". 

 *directory:* contain the path for working directory. As default is "./UCI HAR Dataset". 
 *file:* contain the url+zip file for data. As default is "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".

 The first action is download and unzip the original data set creating an working directory."~/UCI HAR Dataset". 

 The next actions are structured in 5 steps.

  
**1.-** Merges the training and the test sets to create one data set.

- 1.a.- load files unziped in data frames: activities, test and training data files (see CodeBook.md for more detailed information). 
 
- 1.b.- Assign names to columns of data frames. (assign names to data frames variables). 

- 1.c.- Join the test dataframes in a unique data frame (cbind function).

- 1.d.- Join the train dataframes in a unique data frame (cbind function).

- 1.e.- Merge both 1.c and 1.d dataframes, in one data set (rbind function).


**2.-**Extracts only the measurements on the mean and standard deviation for each measurement. 

- 2.a.- Load a dataframe with column names of the dataset obtained in step 1.e.

- 2.b.- Crate a logical vector with TRUE for  the column containing means (not meanFreq) and standard deviation measurement and FALSE for other columns. 

- 2.c.- Obtain a new dataframe only with the columns mark as TRUE in the logical vector of 2.b step. 
  
**3.-**Uses descriptive activity names to name the activities in the data set.

  Merge dataframe obtained in 2.c step and data frame with activity_labels by the comun column KEY_activity  (descriptor). The new dataframe will have as column names the activities names.


**4.-**Appropriately labels the data set with descriptive variable names.
 
- 4.a.- load a dataframe with the column names from dataframe obtain in  step 3.

- 4.b.- The new dataframe have shorts description column names (variables names). Replace the short variable names for long and descriptive variable names:

"tBodyAcc-"replace  for "time-Body Accelerometer-"

"tGravityAcc-"replace  for "time-Gravity Accelerom-"

"tBodyAccJerk-"replace  for "time-Body Accelerom.Jerk signal-"

"tBodyGyro-"replace  for "time-Body Gyroscope -"

"tBodyGyroJerk-"replace  for "time-Body Gyroscope.Jerk signal-"

"tBodyAccMag-"replace  for "time-Body Accelerometer Magnitude-"

"tGravityAccMag-"replace  for "time-Gravity Accel.Magnitude-"

"tBodyAccJerkMag-"replace  for "time-Body Accelerom.Jerk signal Magnitud-"

"tBodyGyroMag-"replace  for "time-Body Gyroscope Magnitud -"

"tBodyGyroJerkMag-"replace  for "time-Body Gyroscope.Jerk signal Magnitud-"

"fBodyAcc-"replace  for "frequency-Body Accelerometer-"

"fBodyAccJerk-"replace  for "frequency-Body Accelerom.Jerk signal-"

"fBodyGyro-"replace  for "frequency-Body Gyroscope -"

"fBodyAccMag-"replace  for "frequency-Body Accelerometer Magnitude-"

"fBodyBodyAccJerkMag-"replace  for "frequency-Body Accelerom.Jerk signal Magnitud-"

"fBodyBodyGyroMag-"replace  for "frequency-Body Gyroscope Magnitud -"

"fBodyBodyGyroJerkMag-"replace  for "frequency-Body Gyroscope.Jerk signal Magnitud-"

-  
**5.-**Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- 5.a.- Eliminate the column for activities names (Name_activity) From the dataframe obtained in 4.b.

- 5.b.- Splits the data into subsets by activity and subject (function aggregate) in a new dataframe.

- 5.c.- Add column Name_activity: merge the data frame with activity_labels and the new dataframe by the comun column KEY_activity  (descriptor).

- 5.d.- Finally export the new dataframe obtained in 5.c. to a txt file "second_tidy_data.txt".

 
=======
=======
>>>>>>> 7d967f1053297f2886cdfa0bcb814117a87e261f
Getting_and_cleaning_data
=========================

Project for collect and clean a data set for John Hopkins "Getting and Cleaning data" course.
<<<<<<< HEAD
>>>>>>> 7d967f1053297f2886cdfa0bcb814117a87e261f
=======
>>>>>>> 7d967f1053297f2886cdfa0bcb814117a87e261f
