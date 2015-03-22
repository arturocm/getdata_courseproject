#Coursera's Data Science Specialization Repo - Getting and Cleaning Data Course Project


This repo contains the 3 requirements ask by the Course Project of the Getting and Cleaning Data course.

The run_analysis.R script contains a run() function that will perform the task asked by the project:

* 1) Merges the training and the test sets to create one data set.
* 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
* 3) Uses descriptive activity names to name the activities in the data set
* 4) Appropriately labels the data set with descriptive variable names. 
* 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


There are a couple of considerations needed for the function to work.

* a) It assumes "getdata-projectfiles-UCI HAR Dataset" zip file has been extracted in working directory as it is (the read.table functions includes paths to the necessary txt files)
* b) It assumes whoever is running the script  has already installed gdata/gplyr/reshape packages

The script also includes comments between code lines to facilitate the understanding of its logic step by step.

Wish me luck... and good luck to you too!


##arturocm