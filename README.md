# Course Project - Getting & Cleaning Data #

### The following describes how my script works for our course project. ###

#### 1. Merges the training and the test sets to create one data set. ####

* Reads in our train and test data.
* Bind the train and test data together.
* Adds headers to the columns based on the features file.

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ####

* Subsets all columns with the words "mean" and the world "std."
* Subsets all columns without the word "Freq." 
 
#### 3. Uses descriptive activity names to name the activities in the data set. ####

* Reads in the activity numeric column.
* Reads in the key-value pair table.
* Maps the activity to the activity numeric column. 

#### 4. Appropriately labels the data set with descriptive variable names. ####

* Binds the now mapped activity column to our dataset. 

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ####

* Reads in the subject identifier data.
* Generates a tidy data set that gives us the mean of all variables by all combinations of subject and activity. 