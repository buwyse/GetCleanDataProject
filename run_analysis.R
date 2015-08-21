##1Initialize workspace
####Dont forget to correctly set your working directory!!!!!
library(plyr)
library(dplyr)
library(data.table)
library(reshape2)
require(plyr)
require(dplyr)
require(data.table)
require(reshape2)
##2 Read feature labeling file.
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features<-grepl("mean|std",features)
##3 Test Data: reads test data and applies column names to data as it is read into R.
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names="Subject")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names="Activity")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names=features)
##3b Pull out most non-mean/std measures from test data.
X_test<-X_test[,extract_features]
##3c Combine test data.
testdata<-cbind(subject_test,y_test,X_test)
rm(subject_test,y_test,X_test)
##4 Train Data: reads train data and applies column names to data as it is read into R.
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names="Subject")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names="Activity")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names=features)
##4b Pull out most non-mean/std measures from train data.
X_train<-X_train[,extract_features]
##4c Combine train data
traindata<-cbind(subject_train,y_train,X_train)
rm(subject_train,y_train,X_train)
##5 Combine test and train data, remove feature labeling vectors that are no longer needed
rm(features,extract_features)
combdata<-rbind(testdata,traindata)
rm(testdata,traindata)
##6 Pull out remaining meanFreq data.
combdata<-combdata[,!grepl("meanFreq",names(combdata))]
##7 Analyze data to retain a single mean of each variable for each subject and activity.
combdata<-tbl_df(combdata)
combdata<-melt(combdata, id = c("Subject","Activity"), measure.vars = setdiff(colnames(combdata), c("Subject","Activity")),variable.name="Feature")
combdata<-combdata %>% 
    group_by(Subject,Activity,Feature) %>%
    summarise("MeanMeasurement"=mean(value))
##8 Add descriptive activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
combdata$Activity<-factor(combdata$Activity,levels=labels(activity_labels),labels=levels(activity_labels))
rm(activity_labels)
##9 Write data to a file in current working directory.
write.table(combdata,file="./Tidy Dataset.txt",row.names=FALSE)
rm(combdata)