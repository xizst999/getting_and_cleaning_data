# run_analysis.R

#import dplyr package
library(dplyr)

#Merges the training and the test sets to create one data set.#
setwd("./UCI HAR Dataset/train")
a <- list.files(pattern=".*.txt")
train_Data <- do.call(cbind,lapply(a, read.table))
#merge test_X???test_Yto create test_Data#
setwd("./UCI HAR Dataset/test")
b <- list.files(pattern=".*.txt")
test_Data <- do.call(cbind,lapply(b, read.table))
#merge the data into one dataset#
dataset <- rbind(train_Data, test_Data)
#return the means, standard deviations
apply(train_Data, 1, mean)
apply(train_Data, 1, std)
apply(test_Data, 1, mean)
apply(test_Data, 1, std)

#relabel activities
dataset$V1[dataset$V1 == 1] <-"WALKING"
dataset$V1[dataset$V1 == 2] <-"WALKING UPSTAIRS"
dataset$V1[dataset$V1 == 3] <- "WALKING_DOWNSTAIRS"
dataset$V1[dataset$V1 == 4] <- "SITTING"
dataset$V1[dataset$V1 == 5] <- "STANDING"
dataset$V1[dataset$V1 == 6] <- "LAYING"

#read the labels
features <- read.table("/Users/fushanshan/Downloads/UCI HAR Dataset/features.txt")
feature <- rbind(features[,c(1,2)], matrix(c(562,"activity", 563, "subject"), nrow = 2, byrow = TRUE))
#appropriately lables the dataset with 
colnames(dataset) <- feature[,2]

#calculate means
act_mean <- aggregate(dataset$activity, dataset, mean)
#average each means into new table
sub_mean <- aggregate(act_mean$subject, act_mean, mean)
new_table <- sub_mean[,c(564,565)]

#writeout data
write.table(new_table, file = "/Users/fushanshan/Downloads/new_table.txt", row.name = F, quote = F)

