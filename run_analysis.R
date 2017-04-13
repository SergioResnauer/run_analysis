##
##

library(plyr) # load plyr first, then dplyr 
library(data.table) # a prockage that handles dataframe better
library(dplyr)

## Download the archive.
if (!file.exists("./data")) {dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/dataset.zip")
unzip("./data/dataset.zip")

############################################################### 
## 1 - Merging the training and test set
############################################################### 

## Reading data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Putting colum names
colnames(x_test) <- t(features[2])
colnames(x_train) <- t(features[2])

## Putting activities and participants
x_train$activities <- y_train[, 1]
x_train$participants <- subj_train[, 1]
x_test$activities <- y_test[, 1]
x_test$participants <- subj_test[, 1]

## Merging data
x_set <- rbind(x_train, x_test)
y_set <- rbind(y_train, y_test)


############################################################### 
## 2 - Extracting mean and standard deviation
############################################################### 

## Selecting mean and std names in features.txt

desire_names <- grep("*mean()|*std()", features[,2], ignore.case = FALSE, value = FALSE)
mean_std_set <- x_set[,desire_names]
colnames(mean_std_set) <- features[desire_names,2]

############################################################### 
## 3 - Uses descriptive activity names to name the activities in the data set
############################################################### 

x_set$activities <- act_labels[x_set$activities,2]
x_set$participants <- paste("Participante", x_set$participants)

############################################################### 
## 4 - Appropriately labels the data set with descriptive variable names
############################################################### 
names(x_set) <- gsub("Acc", "Acceleration", names(x_set))
names(x_set) <- gsub("^t", "timedomain", names(x_set))
names(x_set) <- gsub("^f", "frequencydomain", names(x_set))

############################################################### 
## 5 -  Independent tidy data set with the average of each variable for each activity and each subject
############################################################### 

x_set.dt <- data.table(x_set)
mean_data <- x_set.dt[, lapply(.SD, mean), by = 'participants,activities']
write.table(mean_data, file = "MeanData.txt", row.names = FALSE)