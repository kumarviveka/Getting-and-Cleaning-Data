require("data.table")
require("reshape2")

install.packages("data.table")
library("data.table")
install.packages("reshape2")
activity_labels <- read.table("C:\\Users\\Nagendra\\Downloads\\UCI HAR Dataset\\activity_labels.txt")[,2]
features <- read.table("C:\\Users\\Nagendra\\Downloads\\UCI HAR Dataset\\features.txt")[,2]
extract_features <- grepl("mean|std", features)
str(activity_labels)
setwd("C:\\Users\\Nagendra\\Desktop\\Pramiti\\UCI HAR Dataset\\test")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
subject_test<-data.table(subject_test)
names(X_test) = features
X_test = X_test[,extract_features]
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"
test_data <- cbind(subject_test, y_test, X_test)
head(test_data)
setwd("C:\\Users\\Nagendra\\Desktop\\Pramiti\\UCI HAR Dataset\\train")
X_train <- read.table("X_train.txt")
head(y_train)
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
subject_train<-data.table(subject_train)
names(X_train) = features
X_train = X_train[,extract_features]
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"
train_data <- cbind(subject_train, y_train, X_train)
data = rbind(test_data, train_data)
str(data)
data1<-as.data.table(data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data1, id = id_labels, measure.vars = data_labels)
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)
tidy_data<-data.frame(tidy_data)

 write.table(tidy_data.txt, row.name=FALSE) 
