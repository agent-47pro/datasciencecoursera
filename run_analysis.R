file.name <- "Coursera_DS3_Final.zip"

# Downloading file and putting it in a folder.
if (!file.exists(file.name)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, file.name)
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(file.name) 
}

## Creating data frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Merging the training and the test sets to create one data set.

A <- rbind(x_train,x_test)
B <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged.data <- cbind(subject, B, A)

## Extracting only the measurements on the mean and standard deviation for each measurement.

tidy.data <- merged.data %>% select(subject, code, contains("mean"), contains("std"))

## Using descriptive activity names to name the activities in the data set

tiday.data$code <- activities[tidy.data$code, 2]

## Appropriately labelling the data set with descriptive variable names.

names(tidy.data) [2] = "activity"
names(tidy.data) <- gsub("Acc", "Accelerometer",names(tidy.data))
names(tidy.data) <- gsub("Gyro", "Gyroscope",names(tidy.data))
names(tidy.data) <- gsub("BodyBody", "Body",names(tidy.data))
names(tidy.data) <- gsub("Mag", "Magnitude",names(tidy.data))
names(tidy.data) <- gsub("^t", "Time",names(tidy.data))
names(tidy.data)<-gsub("^f", "Frequency", names(tidy.data))
names(tidy.data)<-gsub("tBody", "TimeBody", names(tidy.data))
names(tidy.data)<-gsub("-mean()", "Mean", names(tidy.data), ignore.case = TRUE)
names(tidy.data)<-gsub("-std()", "STD", names(tiday.data), ignore.case = TRUE)
names(tidy.data)<-gsub ("-freq()", "Frequency", names(tidy.data, ignore.case = TRUE))
names(tidy.data)<-gsub("angle", "Angle", names(tidy.data))
names(tidy.data)<-gsub("gravity", "Gravity", names(tiday.data))

## From the data set in the previous step, creating a 2nd, independent tidy data set with the 
## average of each variable for each activity and each subject.

indi.data <- tidy.data %>% group_by(subject, activity) %>% summarise_all(list(mean))
write.table(indi.data, file = "Independent Data.txt", row.name = FALSE)




