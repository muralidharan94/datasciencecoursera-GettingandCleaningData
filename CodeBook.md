#Introduction

##**Variables:**Following are the variables that are used
###**XTrain,YTrain,SubjectTrain** contain the data that is read from training folder.It contains the training data.

###**XTest,YTest,SubjectTest** contains the data that is read from the test data folder.It contains the test data.

###**combinedX,combinedY,combinedSubject** contains the data that is obtained from merging the test and training data

###**AllFeatures**is the data that is obtained from reading the feature file.It contains the various parameter that where measured.It includes mean,standard deviation and so on.

###**mean_feature_index** is the vector containing index of the rows contatining the expression "mean("

###**std_feature_index** is the vector containing  index of the rows containing the phrase "std("

###**mean_std_feature_index** is the index obtatined by combining the mean and std index.

###**activity_mapping:**contains a detailed activity names.

###**finalResult:**Containing the data formed by combining test,training and subject results

###**avgResults:**Contains the average of the each of the colums in the finalResult.It is stored in a text file called **averages_data.txt**