# Getting-and-Cleaning-Data-Course-Project

README.md  explains how all of the scripts work and how they are connected.

CodeBook.md describes the variables, the data, and any transformations or work that I performed to clean up the data 

run_analysis.R a R script does the following.

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I read the dataset from X_train.txt, y_train.txt, X_test.txt, y_test.txt, subject_train.txt, subject_test.txt.
Firstly, I combine every train and test dataset together.
Then, I change the column names by using the names in features.txt, and combine X, y and subject together.
And I also do something about write the codebook.
At last, I take the average of each activity and each subject and combine them into a dataset.
