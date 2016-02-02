# Getting and Cleaning Data
## Data Set
[Source](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## File Info
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Tidying Data
A table was formed with the features vectors, identifiers for each subject, and activity labels for both training and testing sets.
Then the two tables were binded by row, with one stacked on top of the other.
```
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
```
