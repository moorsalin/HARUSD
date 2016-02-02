# Getting and Cleaning Data
##  How to run
Set the working directory to the folder containg the data set UCI HAR, availible [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

Then execute the script. It will generate a text file in the same folder as the data sets containing 
average values for each element of the 561 feature vector.

The script will first create a large table combining training and test data. Then it will
collect rows that contain standard deviation or mean data. Those columns are then renamed appropriately.
FInally that smaller subset of data is outputted to a text file.s