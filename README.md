Getting and Cleaning Data: Project
===================================

Introduction
------------
This repo contains project code for `Getting and Cleaning Data` course


About the script
----------------
It contains a script called run_analysis.R which will perform the following steps:

  0. Downloaded dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract the UCI HAR Dataset

  1. Merge the training and the test sets to create one data set.

  2. Extract only the measurements on the mean and standard deviation for each measurement. 

  3. Use descriptive activity names to name the activities in the data set.

  4. Appropriately label the data set with descriptive activity names. 

  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



About the tidy dataset
----------------------
he script will create a tidy data set containing the means of all the columns per test subject and per activity.
This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.



About the Code Book
-------------------
The CodeBook.md file explains the transformations performed and the resulting data and variables.
