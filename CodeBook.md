# Code Book - Run_analysis.R

##Introduction
The run_analysis.R is a code to the Getting and Cleaning Data Couse project.

It does 5 steps:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variables
* x_set = set of datas contained in X_train.txt and X_test.txt archives.
* y_set = set of datas contained in y_train.txt and y_test.txt archives.
* desire_names = set of names with std() and mean() texts.
* x_set.dt = the values of x_seet in data.table format.
* mean_data = mean of each parameter (column) per participants and activities.