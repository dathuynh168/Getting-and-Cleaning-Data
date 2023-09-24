#Create folder "Course Project" in C drive
setwd("C:/")
foldername<-"Course Project"
if(!file.exists(foldername)){
  dir.create(foldername)
}

#Redirect to folder "Course Project
setwd(paste("C:/",foldername,sep = ""))
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Download the data zip file
filename<-"Coursera_Week4_CourseProject"
if(!file.exists(filename)){
  download.file(fileurl,filename,method="curl")
}

#unzip the data file
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

#Redirect to folder with data files
setwd("./UCI HAR Dataset")
getwd()

#Assign variables
Activity <- read.table("C:/Course Project/UCI HAR Dataset/activity_labels.txt")
names(Activity)<-c("Code","Activity")

Features <- read.table("C:/Course Project/UCI HAR Dataset/features.txt")
names(Features)<-c("N","Function")

subject_train <- read.table("C:/Course Project/UCI HAR Dataset/train/subject_train.txt",col.names = "Subject_No")
y_train <- read.table("C:/Course Project/UCI HAR Dataset/train/y_train.txt", col.names = "Code")
X_train <- read.table("C:/Course Project/UCI HAR Dataset/train/X_train.txt",col.names = Features$Function)
subject_test<- read.table("C:/Course Project/UCI HAR Dataset/test/subject_test.txt",col.names = "Subject_No")
y_test <- read.table("C:/Course Project/UCI HAR Dataset/test/y_test.txt", col.names = "Code")
X_test <- read.table("C:/Course Project/UCI HAR Dataset/test/X_test.txt",col.names = Features$Function)
Subject <- rbind(subject_train,subject_test)
Y <- rbind(y_train,y_test)
X <- rbind(X_train,X_test)
Master_Data <-cbind(Subject,Y,X)
#Uses descriptive activity names to name the activities in the data set
Master_Data$Code<-Activity[Master_Data$Code,]$Activity

names(Master_Data)[2]<-"Activity"
Extract_Data<-Master_Data %>% select(Subject_No, Activity,contains("mean"),contains("std"))

names(Extract_Data)<-gsub("^t","Time-",names(Extract_Data))
names(Extract_Data)<-gsub("[Bb]ody[Bb]ody|[Bb]ody","Body-",names(Extract_Data))
names(Extract_Data)<-gsub("^f","Frequency-",names(Extract_Data))
names(Extract_Data)<-gsub("^angle.t","Angle-",names(Extract_Data))
names(Extract_Data)<-gsub("Acc","Accelerometer-",names(Extract_Data))
names(Extract_Data)<-gsub("\\.","",names(Extract_Data))
names(Extract_Data)<-gsub("Gyro","Gyroscope-",names(Extract_Data))
names(Extract_Data)<-gsub("Jerk","Jerk-",names(Extract_Data))
names(Extract_Data)<-gsub("[Mm]ag","Magnitude-",names(Extract_Data))
names(Extract_Data)<-gsub("[Mm]ean","Mean-",names(Extract_Data))
names(Extract_Data)<-gsub("-$","",names(Extract_Data))

Tidy_Data <- Extract_Data %>% group_by(Activity,Subject_No) %>% summarise_all(funs(mean))

#write the Tidy_Data in csv file
if(!file.exists("Tidy_Data.csv")){write.csv(Tidy_Data,"Tidy_Data.csv", row.names = FALSE)}