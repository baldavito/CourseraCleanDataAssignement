

## Read Test Data

xTest<-read.table("./X_test.txt")
yTest<-read.table("./Y_test.txt")
colnames(yTest)<-c("Labels")
subjectTest<-read.table("./subject_test.txt")
colnames(subjectTest)<-"Subject"

## Read Train Data

xTrain<-read.table("./X_train.txt")
yTrain<-read.table("./Y_train.txt")
colnames(yTrain)<-c("Labels")
subjectTrain<-read.table("./subject_train.txt")
colnames(subjectTrain)<-"Subject"

## Read Activities

labels<-read.table("activity_labels.txt")
 colnames(labels)<-c("Labels","Activity")

## Define column list

columnList<-c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,347,348,349,350,374,374,375,424,425,426,427,428,429,452,453,454,503,504,513,516,517,526,529,530,539,542,552,555,556,557,558,559,560,561)

## Subset the measures tables with mean and std columns


xTest<-xTest[,columnList]
xTrain<-xTrain[,columnList]

## Merge Test Data in one single table

testData<-cbind(subjectTest,yTest,xTest)

## Merge Train Data in one single table

trainData<-cbind(subjectTrain,yTrain,xTrain)

## Create unique dataset

totalData<-rbind(testData,trainData)

## Apply activity names

total<-merge(labels,totalData,by="Labels")

## Calculate the mean

finalAggregation<-aggregate(.~Activity+Subject,total,mean)

## Create file

write.table(finalAggregation, file="tidyData.txt")
