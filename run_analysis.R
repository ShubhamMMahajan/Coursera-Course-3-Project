#This is where data is stored
setwd("C:\\Users\\shubh\\Documents\\Coursera\\Getting and Cleaning Data\\Week 3\\UCI HAR Dataset")

#training data
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

#testing data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")


#features
features <- read.table("features.txt")
features[,2] <- as.character(features[,2])
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
x_train <- x_train[featuresWanted]
x_test <- x_test[featuresWanted]

#formating the name
names <- features[featuresWanted, 2]
names <- gsub("mean\\(\\)-", "mean_", names)
names <- gsub("std\\(\\)-", "std_", names)


#merging the data
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
all <- cbind(subject, y, x)
colnames(all) <- c("Subject", "Activity", names)

activity_labels <- read.table("activity_labels.txt")
all$Activity <- activity_labels[all$Activity, 2]

average_per_subject_and_activity <- aggregate(all[,c(3:length(names(all)))], by = list(all$Subject, all$Activity), FUN = "mean")

colnames(average_per_subject_and_activity) <- c("Subject", "Activity", names)

#This is where the data will be stored
setwd("C:\\Users\\shubh\\Documents\\Coursera\\Getting and Cleaning Data\\Week 3") 
write.table(average_per_subject_and_activity, file = "tidy_all_activities_by_subject.txt", row.names = FALSE)
