run <- function(){
  
## Required Libraries
library(dplyr)
library(gdata)
library(reshape2)

# Read all required data tables assumming "getdata-projectfiles-UCI HAR Dataset"
# was unzipped in the same folder as run_analysis.R is located
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/Y_test.txt")
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Rename table columns
colnames(test_x) <- features[,2]
colnames(train_x) <- features[,2]
colnames(test_y) <- c("activity")
colnames(train_y) <- c("activity")
colnames(subject_test) <- c("subject")
colnames(subject_train) <- c("subject")
colnames(activity_label) <- c("activity","activity_name")

# Cross reference activity table with train/test Y
train_y <- merge(train_y,activity_label)
test_y <- merge(test_y,activity_label)

# Identify columns containing Mean or Std values
MS_col <- matchcols(test_x,with=c("mean","std"),method="or",ignore.case=TRUE)
# Create a vector with the columns containing the word mean or std
MS_col_vec <- as.vector(unlist(MS_col))

# Subset test data with columns containing Mean or Std Values
test_x_subset <- subset(test_x, select = MS_col_vec)
# Column bind test X, test Y and Subject test
total_test <- cbind(test_x_subset,test_y,subject_test)
Test <- mutate(total_test,file="test")

# Subset train data with columns containing Mean or Std Values
train_x_subset <- subset(train_x, select = MS_col_vec)
# Column bind train X, train Y and Subject train
total_train <- cbind(train_x_subset,train_y,subject_train)
Train <- mutate(total_train,file="train")

# Merge everyting in a single data frame
Data <- rbind(Test,Train)
# Use reshape2 package to obtain the tidy data
Data_melt <- melt(Data, id=c("subject","activity_name"), measure.vars=MS_col_vec)
Data_cast <- dcast(Data_melt, subject + activity_name ~ variable, mean)

# write the final tabl
write.table(Data_cast,file="tidy_data.txt",row.name=FALSE)

print("Data frame has been saved to the working directory as tidy_data.txt")

}