# Course Project for Getting and Cleaning Data
#Author: Mitta Suresh
#
#LOADING DATA AND MERGING
# load data from train and test subfolders

x_train=read.table("./train/X_train.txt")
y_train=read.table("./train/y_train.txt")
subject_train=read.table("./train/subject_train.txt")
x_test=read.table("./test/X_test.txt")
y_test=read.table("./test/y_test.txt")
subject_test=read.table("./test/subject_test.txt")

# combine test and train files
combo_subject=rbind(subject_train,subject_test)
combo_activity=rbind(y_train,y_test)
combodata=rbind(x_train,x_test)

#ADDING DESCRIPTIVE TITLES AND ADD ACTIVITY DESCRIPTION
# read the variable names file and assign the naems to the column header
var_names=read.table("features.txt")
test_head=var_names[,2]
colnames(combodata)=test_head

##Combine subject and activity columns to the data, add appropriate col names
combodata=cbind(combo_subject,combo_activity,combodata)
colnames(combodata)[1]="Subject"
colnames(combodata)[2]="ACtivity"

# change the Activity Column to have proper description
# there is probably a more elegant and compact way to handle this, but I was running out of time
#so used the one I know works

for (i in 1:nrow(combodata)){
        if (combodata[i,2]=="1")
                
        {combodata[i,2]="WALKING"
        } else if 
        (combodata[i,2]=="2") {
                combodata[i,2]="WALKING_UPSTAIRS"
        } else if
        (combodata[i,2]==3) {
                combodata[i,2]="WALKING_DOWNSTAIRS"
        } else if 
        (combodata[i,2]==4) {
                combodata[i,2]="SITTING"
        } else if 
        (combodata[i,2]==5) {
                combodata[i,2]="STANDING"
        } else combodata[i,2]="LYING"      
}

# REDUCING NUMBER OF COLUMNS TO THOSE OF MEAN AND STD. DEV
# reduce the number of columns by selecting only those which refer to mean and stad. deviation
# find list of columns which contain words mean or std


mean_cols=grep("mean",names(combodata))
std_cols=grep("std",names(combodata))

# combine the columns with std and mean along with subject and activity columns
select_cols=c(1,2,mean_cols,std_cols)

#Reduce the data frame
reduced_data=combodata[,select_cols]
str(reduced_data)

# CREATING TIDY DATA BY GETTING AVERAGE BASED ON SUBJECT AND ACTIVITY
# this is the last part of the project to create a tidy set with averaged values
# initiate a empty data frame and fill it with values, add column names
tidydata=data.frame(matrix(NA, nrow=180,ncol=81))
names(tidydata)=names(reduced_data)

# create an activity list
Activity=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LYING")

# running two nested loops to cover all subjects and all activities, calculating the means
# and adding it as one to the data frame shell created above for each iteration
for (i in 1:30){
        for (j in seq_along(Activity)) {
                tempdf=reduced_data[which(reduced_data$Subject==i & reduced_data$ACtivity==Activity[j]),]
                meancols=colMeans(tempdf[,3:ncol(tempdf)])
                allcols= c(i,Activity[j],meancols)
                tidydata[((length(Activity)*(i-1))+j),]=allcols
        }
        
}

# write output to file

write.table(tidydata,file="tidydata.txt",row.names=FALSE)
