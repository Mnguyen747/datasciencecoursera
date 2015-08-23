dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" #Our data file
dir.create("project") # created a folder to house data file
download.file(dataFile, "project/UCI-HAR-dataset.zip") # downloads data file into project folder we just created
unzip("project/UCI-HAR-dataset.zip") #unzips data file we just downloaded

#1. Merges the training and the test sets to create one data set.

test <- read.table("./UCI HAR Dataset/test/X_test.txt")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
data <- rbind(train,test)
rm(test)
rm(train)

headers <- read.table("./UCI HAR Dataset/features.txt")
headers <- as.character(headers[,2])
colnames(data) <- headers
rm(headers)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

data <- data[,grepl("mean()|std()", names(data))]
data <- data[,!(grepl("Freq", names(data)))]

#3. Uses descriptive activity names to name the activities in the data set

test_act <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
train_act <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
y <- rbind(test_act, train_act)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(labels)) {
  nmbr <- as.numeric(labels[i, 1])
  actn <- as.character(labels[i, 2])
  y[y$activity == nmbr, ] <- actn
}

#4. Appropriately labels the data set with descriptive activity names. 

data <- cbind(y,data)
rm(labels,y,test_act,train_act,nmbr,i,actn)

#5. From the data set in step 4, creates a second, independent tidy data set with 
#   the average of each variable for each activity and each subject.

train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(train_subject,test_subject)
colnames(subject) <- c("subject")
rm(train_subject,test_subject)

tidy_data <- aggregate(data, by = list(data$activity, subject = subject[,1]), mean)
tidy_data <- cbind(tidy_data[,c(1:2)],tidy_data[,c(4:ncol(tidy_data))])
colnames(tidy_data)[1] <- "Activity"

write.csv(tidy_data, file='project/tidy_data.txt', row.names=FALSE)