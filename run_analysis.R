#Loading the required packages
library(plyr)
library(Hmisc)

#The script assumes that the user running it has the test and train data in the 
#directory

#---------------Step1:Merges the training and the test sets to create one data set.--

#Reading data from the training data set using the data.table data structure
XTrain<-read.table("train/x_train.txt")
YTrain<-read.table("train/y_train.txt")
SubjectTrain<-read.table("train/subject_train.txt")

#Reading data from the training data set using the data.table data structure
XTest<-read.table("test/x_test.txt")
YTest<-read.table("test/y_test.txt")
SubjectTest<-read.table("test/subject_test.txt")

#Combining the X test and training data

combinedX<-rbind(XTrain,XTest)

#Combining the Y test and training data
combinedY<-rbind(YTrain,YTest)

#Combining the Xand Y subject data
combinedSubject<-rbind(SubjectTest,SubjectTrain)

#---------------Step2:Extracts only the measurements on the mean and standard deviation for each measurement.--

#Identifying the index in the features.txt which corresponds to the value of
#mean and standard deviation in the combinedX data table

#Reading the data from the features.txt
AllFeatures<-read.table("features.txt")

#Identifying the index for the mean value in the features.txt
mean_feature_index<-grep("-mean\\(",AllFeatures[,2])

#Identifying the index for the SD value in the features.txt
std_feature_index<-grep("-std\\(",AllFeatures[,2])

#Combining the indices for SD and mean
mean_std_features_index<-c(mean_feature_index,std_feature_index)
mean_std_features_index<-sort(mean_std_features_index)

#Retaining only values  which has computations related to std deviation and mean
combinedX<-combinedX[,mean_std_features_index]

#Adding relevant colum names from the feature file
names(combinedX)<-AllFeatures[mean_std_features_index,2]

#---------------Step3:Uses descriptive activity names to name the activities in the data set--

#Test labels and trial labels(testY and trialY repectively) are all associalted with a number.Purpose of these lines
#is to associate with there corresponding names.
#Mapping is as follows
#1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING

#Reading the descriptive activity name data
activity_mapping<-read.table("activity_labels.txt")

#Naming the labels column
names(combinedY)<-c("ACTION_PERFORMED")

#Assigning the mapping values by subsetting each row
combinedY[,1]<-activity_mapping[combinedY[,1],2]

#---------------Step4:Appropriately labels the data set with descriptive variable names. --

#Two data frames combinedX and combinedY have been assigned descriptive names.
#Assigning column name to combinedSubject 

names(combinedSubject)<-c("Subject")

#Combining the 3 data frames into one single data frame

finalResult<-cbind(combinedX,combinedY,combinedSubject)

#---------------Step 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#Detemining the average of each column in the data set
avgResult<-ddply(finalResult,.(Subject,ACTION_PERFORMED),function(x)colMeans(x[,1:66]))

#Writing the data to a text file
write.table(avgResult,"averages_data.txt",row.names = FALSE)


