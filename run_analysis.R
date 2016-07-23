# read data
train_x <- read.table("./Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt")
test_x <- read.table("./Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt")
names <- read.table("./Getting and Cleaning Data/UCI HAR Dataset/features.txt")
train_subject <- read.table("./Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("./Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

# combine data together
data_x <- rbind(train_x, test_x)
data_y <- rbind(train_y, test_y)
data_subject <- rbind(train_subject, test_subject)

# find the mean and std row, and just select them. Attention, there should not be meanFreq as require said.
mean_name <- grep("mean\\(\\)", names$V2)
std_name <- grep("std\\(\\)", names$V2)
data_col <- sort(c(mean_name, std_name))
data_x <- data_x[,data_col]
colnames(data_x) <- names$V2[data_col]
colnames(data_y) <- "activity"
colnames(data_subject) <- "subject"
data <- cbind(data_y, data_x, data_subject)

# Write codebook by R
name_for_codebook <- as.character(names$V2[data_col])
splitNames <- strsplit(name_for_codebook, "-")
firstElement <- function(x) {x[1]}
unique(sapply(splitNames, firstElement))
sentences <- matrix(rep("",198), nrow = 66, ncol = 3)
put_words <- function(element, sentence, place)
{
  index <- grep(element, name_for_codebook)
  sentences[index, place] <- sentence
  sentences
}
sentences <- put_words("mean\\(\\)", "The mean value of", 1)
sentences <- put_words("std\\(\\)", "The standard deviation of", 1)
sentences <- put_words("-X$", "on the x axis", 3)
sentences <- put_words("-Y$", "on the y axis", 3)
sentences <- put_words("-Z$", "on the z axis", 3)
sentences <- put_words("tBodyAcc-", "the body acceleration signals in time domain signals", 2)
sentences <- put_words("tGravityAcc-", "the gravity acceleration signals in time domain signals", 2)
sentences <- put_words("tBodyAccJerk-", "the body linear acceleration derived in time to obtain Jerk signals", 2)
sentences <- put_words("tBodyGyro-", "the body gyroscope signals in time domain signals", 2)
sentences <- put_words("tBodyGyroJerk-", "the body angular velocity derived in time to obtain Jerk signals", 2)
sentences <- put_words("tBodyAccMag-", "the magnitude of the body acceleration signals calculated using the Euclidean norm", 2)
sentences <- put_words("tGravityAccMag-", "the magnitude of the gravity acceleration signals calculated using the Euclidean norm", 2)
sentences <- put_words("tBodyAccJerkMag-", "the magnitude of the body linear acceleration signals derived in time to obtain Jerk signals calculated using the Euclidean norm", 2)
sentences <- put_words("tBodyGyroMag-", "the magnitude of the body gyroscope signals calculated using the Euclidean norm", 2)
sentences <- put_words("tBodyGyroJerkMag-", "the magnitude of the body angular velocity signals derived in time to obtain Jerk signals calculated using the Euclidean norm", 2)
sentences <- put_words("fBodyAcc-", "Fast Fourier Transform (FFT) applied to the body acceleration signals", 2)
sentences <- put_words("fBodyAccJerk-", "FFT applied to the body linear acceleration to obtain Jerk signals", 2)
sentences <- put_words("fBodyGyro-", "FFT applied to the body gyroscope signals", 2)
sentences <- put_words("fBodyAccMag-", "FFT applied to the magnitude of the body acceleration signals calculated using the Euclidean norm", 2)
sentences <- put_words("fBodyBodyAccJerkMag-", "FFT applied to the magnitude of the body linear acceleration signals to obtain Jerk signals calculated using the Euclidean norm", 2)
sentences <- put_words("fBodyBodyGyroMag-", "FFT applied to the magnitude of the body gyroscope signals calculated using the Euclidean norm", 2)
sentences <- put_words("fBodyBodyGyroJerkMag-", "FFT applied to the magnitude of the body angular velocity signals to obtain Jerk signals calculated using the Euclidean norm", 2)

sen <- paste(sentences[,1],sentences[,2],sentences[,3])
output <- as.data.frame(cbind(name_for_codebook, sen))
write.table(output, file = "./Getting and Cleaning Data/codebook.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)

#
groupdata <- group_by(data, activity, subject)
summarise(groupdata, sapply(data, mean))
