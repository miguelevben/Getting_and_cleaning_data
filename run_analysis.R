######################################################################################
## Function..: run_analysis  
## Action    :Script for collect, processing and clean a data set. 
##            - download and unzip file
##            - processing and clean data in 5 steps indicated in source code.
##            - finally export an independent tidy set (step 5)
## 
##
## Parameters: -  'directory': path in local machine.(workspace)  
##               
##             - 'file': url+file for zip data file.
##  
## Output :   file second_tidy_data.txt  
######################################################################################
##  

run_analysis <- function(directory = "UCI HAR Dataset", file = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"){
  # declare variables
  
  # a.- Path variables
  wd_test <- sprintf('%s/%s/test/',getwd(),directory)    # Work Dir files TEST
  wd_train <- sprintf('%s/%s/train/',getwd(),directory)  # Work Dir files TRAIN
  workdir <- sprintf('./%s',directory)                   # Work dir for this project 
                                                         
  
  # b.- initial data-sets variables
  
  X_test <- paste(wd_test,"X_test.txt",sep="")         # file X_test Test set.
  y_test <- paste(wd_test,"y_test.txt",sep="")         # file y_test Test labels.
  subject_test <- paste(wd_test,"subject_test.txt",sep="") #  Test set.Each row identifies the subject who performed the activity
                                                           #  for each window sample. Its range is from 1 to 30. 
  X_train <- paste(wd_train,"X_train.txt",sep="")      # file X_train  Training set.
  y_train <- paste(wd_train,"y_train.txt",sep="")      # file y_train  Training labels. 
  subject_train <- paste(wd_train,"subject_train.txt",sep="") #  Train set.Each row identifies the subject who performed the activity
                                                           #  for each window sample. Its range is from 1 to 30. 
  
  activity_labels <- paste(workdir,"/activity_labels.txt",sep="")      # file activity_labels
                                                                      # Links the class labels with their activity name.
  features <- paste(workdir,"/features.txt",sep="")                    # List of all features.
  
  
  # initial data-frames variables
  DF_subject_test <- data.frame()
  DF_X_test <- data.frame()
  DF_y_test <- data.frame()
  
  DF_subject_train <- data.frame()
  DF_X_train <- data.frame()
  DF_y_train <- data.frame()
  
  DF_features <- data.frame()
  DF_activity_labels <- data.frame()
  
  DF_fusion_set_test <- data.frame()       # merge set data for "test"    
  DF_fusion_set_train <- data.frame()      # merge set data for "train" 
  DF_fusion_set_final <- data.frame()      # merge sets data "test"+"train" 
  DF_names <- data.frame()                 # Column names final set.
  DF_vector_names <- data.frame()          # logical vector selection column names for final set
  DF_filter_col <- data.frame()            # data frame fusion of DF_names + DF_vector_names
  
  DF_second_tidy_set <- data.frame()
  DF_temp            <- data.frame()
  # check work dir : if exist then the files were downloaded and you are reexecuting this script.
  #                  else is the first execution and then need download and unzip files INTO workdirectory
  
  
  
  if (!file.exists(workdir)){
    dir.create(workdir)
    download.file(file,destfile="Datos.zip",method="auto")
    unzip("Datos.zip")
  }
  
  # 1. Merge the training and the test sets to create one data set.
  # 1.a.- reads : load files in data frames
  #               
                
  DF_features <- read.table(features,header=FALSE)
  DF_activity_labels <- read.table(activity_labels,header=FALSE)
  
  DF_X_test <- read.table(X_test,header=FALSE)
  DF_y_test <- read.table(y_test,header=FALSE)
  DF_subject_test <- read.table(subject_test,header=FALSE)
  
  DF_X_train <- read.table(X_train,header=FALSE)
  DF_y_train <- read.table(y_train,header=FALSE)
  DF_subject_train <- read.table(subject_train,header=FALSE)
  
  #1.b.- assign names to columns  dataframes 
  colnames(DF_activity_labels) <- c('KEY_activity','Name_activity')
  colnames(DF_subject_test) <- "KEY_subject"
  colnames(DF_subject_train) <- "KEY_subject"
  colnames(DF_X_test) <- DF_features[,2]         
  colnames(DF_y_test) <- "KEY_activity"
  colnames(DF_X_train) <- DF_features[,2]         
  colnames(DF_y_train) <- "KEY_activity"
  
  #1.C.- Fusion datasets training+test
  DF_fusion_set_test <- cbind(DF_y_test,DF_subject_test,DF_X_test)
  DF_fusion_set_train <- cbind(DF_y_train,DF_subject_train,DF_X_train)
  #1.D.- Creation one data-set merging the datasets
  DF_fusion_set_final <- rbind(DF_fusion_set_train,DF_fusion_set_test)
  
  #2.- Extracts only the measurements on the mean and STD for each measurement
  DF_names <- colnames(DF_fusion_set_final)
  DF_vector_names <- (grepl("KEY_..",DF_names)|grepl("-mean()-..",DF_names) & !grepl("-meanFreq..",DF_names) & !grepl("mean..-",DF_names)|grepl("-mean()",DF_names)& !grepl("-meanFreq()",DF_names)|grepl("-std()",DF_names)|grepl("-std()-..",DF_names))
  DF_filter_col <- data.frame(DF_names,DF_vector_names)

  DF_fusion_set_final <- DF_fusion_set_final[DF_vector_names==TRUE]
  
  #3.- Uses descriptive activity names to name the activities in the data set
  #    - merge tables DF_fusion_set_final and DF_activity_labels by 
  #      KEY_activity column (descriptor)
  DF_fusion_set_final <- merge(DF_fusion_set_final,DF_activity_labels,by='KEY_activity',all.x=TRUE)

  
  # write.table(DF_fusion_set_final,file = "./fusion_sindepurar.txt",row.names=FALSE,sep='\t');
  
  #4.- Appropriately labels the data set with descriptive variable names
  DF_names <- colnames(DF_fusion_set_final)  #store colnames final data set for treatment

  for (i in 1:length(DF_names)) 
  {
    DF_names[i] <- gsub("tBodyAcc-","time-Body Accelerometer-",DF_names[i])
    DF_names[i] <- gsub("tGravityAcc-","time-Gravity Accelerom-",DF_names[i])
    DF_names[i] <- gsub("tBodyAccJerk-","time-Body Accelerom.Jerk signal-",DF_names[i])
    DF_names[i] <- gsub("tBodyGyro-","time-Body Gyroscope -",DF_names[i])
    DF_names[i] <- gsub("tBodyGyroJerk-","time-Body Gyroscope.Jerk signal-",DF_names[i])
    DF_names[i] <- gsub("tBodyAccMag-","time-Body Accelerometer Magnitude-",DF_names[i])
    DF_names[i] <- gsub("tGravityAccMag-","time-Gravity Accel.Magnitude-",DF_names[i])
    DF_names[i] <- gsub("tBodyAccJerkMag-","time-Body Accelerom.Jerk signal Magnitud-",DF_names[i])
    DF_names[i] <- gsub("tBodyGyroMag-","time-Body Gyroscope Magnitud -",DF_names[i])
    DF_names[i] <- gsub("tBodyGyroJerkMag-","time-Body Gyroscope.Jerk signal Magnitud-",DF_names[i])
    DF_names[i] <- gsub("fBodyAcc-","frequency-Body Accelerometer-",DF_names[i])
    DF_names[i] <- gsub("fBodyAccJerk-","frequency-Body Accelerom.Jerk signal-",DF_names[i])
    DF_names[i] <- gsub("fBodyGyro-","frequency-Body Gyroscope -",DF_names[i])
    DF_names[i] <- gsub("fBodyAccMag-","frequency-Body Accelerometer Magnitude-",DF_names[i])
    DF_names[i] <- gsub("fBodyBodyAccJerkMag-","frequency-Body Accelerom.Jerk signal Magnitud-",DF_names[i])
    DF_names[i] <- gsub("fBodyBodyGyroMag-","frequency-Body Gyroscope Magnitud -",DF_names[i])
    DF_names[i] <- gsub("fBodyBodyGyroJerkMag-","frequency-Body Gyroscope.Jerk signal Magnitud-",DF_names[i])
    
  }
  colnames(DF_fusion_set_final) <- DF_names
  
  #5.- Creates a second, independent tidy data set with the average of each variable for each activity
  #    and each object.
   
  DF_temp <- DF_fusion_set_final[,names(DF_fusion_set_final) != 'Name_activity']
  
  DF_second_tidy_set <- aggregate(DF_temp[,names(DF_temp) != c('KEY_activity','KEY_subject')],by=list(KEY_activity=DF_temp$KEY_activity,KEY_subject = DF_temp$KEY_subject),mean) 
 
  DF_second_tidy_set <- merge(DF_second_tidy_set,DF_activity_labels,by='KEY_activity',all.x=TRUE)
  
  write.table(DF_second_tidy_set,file = "./second_tidy_data.txt",row.names=FALSE,sep='\t');
  
}