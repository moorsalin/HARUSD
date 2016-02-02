## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## Task 1. Merge the training and the test sets to create one data set.
## Task 2. Extract only the measurements on the mean and standard deviation for each measurement. 
## Task 3. Use descriptive activity names to name the activities in the data set
## Task 4. Appropriately label the data set with descriptive activity names. 
## Task 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Task 1. Merge the training and the test sets to create one data set.
#set working directory to folder with UCI HAR Data
labels <- read.table("features.txt",header=F)
features     = read.table("./features.txt",header=FALSE)
activityLabel = read.table("./activity_labels.txt",header=FALSE)
subjectTrain = read.table("./train/subject_train.txt",header=FALSE)
xTrain       = read.table("./train/x_train.txt",header=FALSE)
yTrain       = read.table("./train/y_train.txt",header=FALSE)
colnames(activityLabel)  = c("activityId","activityLabel")
colnames(subjectTrain)  = "subjectId"
colnames(xTrain)        = features[,2] 
colnames(yTrain)        = "activityId"
trainingData = cbind(yTrain,subjectTrain,xTrain)

subjectTest = read.table("./test/subject_test.txt",header=FALSE)
xTest       = read.table("./test/x_test.txt",header=FALSE)
yTest       = read.table("./test/y_test.txt",header=FALSE)
colnames(subjectTest) = "subjectId"
colnames(xTest)       = features[,2] 
colnames(yTest)       = "activityId"
testDataset = cbind(yTest,subjectTest,xTest)
finalDataset = rbind(trainingData,testDataset)
colNames  = colnames(finalDataset)

## Task 2. Extract only the measurements on the mean and standard deviation for each measurement.
logicalVector = (grepl("activity..",colNames) | 
				 grepl("subject..",colNames) | 
				 grepl("-mean..",colNames) & 
				 !grepl("-meanFreq..",colNames) & 
				 !grepl("mean..-",colNames) | 
				 grepl("-std..",colNames) & 
				 !grepl("-std()..-",colNames))
finalDataset = finalDataset[logicalVector==TRUE]

## Task 3. Use descriptive activity names to name the activities in the data set
finalDataset = merge(finalDataset,activityLabel,by="activityId",all.x=TRUE)
colNames  = colnames(finalDataset) 

# Task 4. Appropriately label the data set with descriptive activity names. 
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}
colnames(finalDataset) = colNames

## Task 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
finalDatasetNoactivityLabel  = finalDataset[,names(finalDataset) != "activityLabel"]
tidyDataset    = aggregate(finalDatasetNoactivityLabel[,names(finalDatasetNoactivityLabel) != c("activityId","subjectId")],by=list(activityId=finalDatasetNoactivityLabel$activityId,subjectId = finalDatasetNoactivityLabel$subjectId),mean)
tidyDataset    = merge(tidyDataset,activityLabel,by="activityId",all.x=TRUE)
write.table(tidyDataset, "./tidyData.txt",row.names=TRUE,sep="\t")
