# input: train and test data set 
# output: 
## data_mean_std.csv: extract only variables with mean() and std()
## data_mean_summary: calculate mean of each variable from data_mean_std.csv grouped by subject and activity

library(dplyr)
library(tidyr)
path <- "./"

# load data
x_train <- read.table(file.path(path, "train", "X_train.txt"))
y_train <- read.table(file.path(path, "train", "y_train.txt"))
subject_train <- read.table(file.path(path, "train", "subject_train.txt"))
x_test <- read.table(file.path(path, "test", "X_test.txt"))
y_test <- read.table(file.path(path, "test", "y_test.txt"))
subject_test <- read.table(file.path(path, "test", "subject_test.txt"))
features <- read.table(file.path(path, "features.txt"))

# bind together rows of train set and test set
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# assign explicit activity name
colnames(x) <- features$V2
colnames(y) <- "activityLabel"
colnames(subject) <- "subjectLabel"

# bind together subject, y, and x respectively
data <- cbind(subject, y, x)

# extract mean and standard deviation of each measurement
name <- names(data)
index <- grep("mean()|std()", name)
# because extracting columns with "mean()" might get "meanFreq()" too
index2 <- grep("meanFreq()", name)
index3 <- setdiff(index, index2)
data_mean_std <- data[,c(1,2,index3)] # tidy data set

# create independent tidy data set showing average of each variable
# grouped by subject-label and activity-label
data_mean_summary <- data_mean_std
data_mean_summary <- group_by(data_mean_summary, subjectLabel, activityLabel)

# save file as .csv
write.table(data_mean_std, file="data_mean_std.txt", row.names = FALSE)
write.table(data_mean_summary, file="data_mean_summary.txt", row.names = FALSE)
