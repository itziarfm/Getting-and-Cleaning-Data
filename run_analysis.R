##########################################################################################################
## Getting and Cleaning Data Course Project

# File Description:

# This script will perform the following steps,
# 0. Downloaded dataset from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################
library(data.table)

setwd("C:/Users/Itziar/Documents/Data science specialization/Getting and Cleaning Data/Week3/Project")


##############################################################################
###### 0. Download the zip data and extract files ############################
##############################################################################
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
f <- 'dataset.zip'

download.file(url, destfile = f)
unzip(f)



##############################################################################
###### 1. Merge the training and the test sets to create one data set ########
##############################################################################
# Get Features
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("index", "name"))
# Get Labels
label <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("level", "label"))


### Read train data set
prefix <- "./UCI HAR Dataset/train/"
f.data <- paste(prefix, "X_train.txt", sep = "")
f.label <- paste(prefix, "y_train.txt", sep = "")
f.subject <- paste(prefix, 'subject_train.txt',sep = "")

# Read the data into a data.frame
train.data <- read.table(f.data)[, features$index]
names(train.data) <- features$name

train.label <- read.table(f.label)[, 1]

train.subject <- read.table(f.subject)[, 1]


### Read test data set
prefix <- "./UCI HAR Dataset/test/"
f.data <- paste(prefix, "X_test.txt", sep = "")
f.label <- paste(prefix, "y_test.txt", sep = "")
f.subject <- paste(prefix, 'subject_test.txt',sep = "")

# Read the data into a data.frame
test.data <- read.table(f.data)[, features$index]
names(test.data) <- features$name

test.label <- read.table(f.label)[, 1]

test.subject <- read.table(f.subject)[, 1]

### Raw data set: combine train and test data
raw.dataset <- rbind(train.data, test.data)


##############################################################################
######  2. Extract only the measurements on the mean and standard deviation ##
##############################################################################
# logical vector that contains TRUE for mean or std columns
col.select<-is.element(colnames(raw.dataset),subset(features, grepl('-(mean|std)[(]', colnames(raw.dataset)))$name)

# keep only desired columns
raw.dataset<-raw.dataset[,col.select]


##############################################################################
### 3.Use descriptive activity names to name the activities in the data set ##
##############################################################################
raw.dataset$activity <- factor(c(train.label,test.label), levels=label$level, labels=label$label)
 


##############################################################################
##### 4. Appropriately labels the data set with descriptive variable names ###
##############################################################################
ColNames <- colnames(raw.dataset)
ColNames <- gsub('-mean', 'Mean',  ColNames) # Replace `-mean' by `Mean'
ColNames <- gsub('-std', 'Std',  ColNames) # Replace `-std' by 'Std'
ColNames <- gsub('[()-]', '',  ColNames) # Remove the parenthesis and dashes
ColNames <- gsub('BodyBody', 'Body',  ColNames) # Replace `BodyBody' by `Body'

colnames(raw.dataset)<-ColNames


##############################################################################
## 5. tidy data set, average of each variable for each activity and subject ##
##############################################################################
# add subject id
raw.dataset$subject <- factor(c(train.subject,test.subject))

tidy.dataset <- data.table(raw.dataset)[, lapply(.SD, mean), by=list(activity, subject)]

write.table(tidy.dataset, './tidyData.txt',row.names=TRUE,sep='\t')
