
library(data.table)
setwd("Project_3_1")

##### Tasks 1-4 #####

# Merge "y" files and rename to "activities"
y_test <- read.table("test/y_Test.txt")
y_train <- read.table("train/y_train.txt")
y_Merged <- y_test
activities <- rbind(y_Merged, y_train)
colnames(activities) <- "act_nbr"

# Merge "subject" files
subject_test <- read.table("test/subject_test.txt")
subject_train <- read.table("train/subject_train.txt")
subject_merged <- subject_test
subject_merged <- rbind(subject_merged, subject_train)

# Merge Inertial Signals
filenames_test <- list.files("test/Inertial Signals")
filenames_train <- list.files("train/Inertial Signals")
path_test <- "test/Inertial Signals"
path_train <- "train/Inertial Signals"

# Prepare data frame for merged signals from "Inertial Signals"
Signals_Measures <- data.frame(0,0,0,0)
colnames(Signals_Measures) <- c("signal", "mean", "SD", "act_nbr")

# Load activity labels
activities_codetable <- data.frame(read.table("activity_labels.txt"))
colnames(activities_codetable) <- c("act_nbr", "activity")


# For each file from "Inertial Signals" do:
i <- 1
while (i <= length(filenames_test)) {
  
  # Prepare names for signals (measures)
  signal_name <- gsub("_test.txt", "", filenames_test[i])
  
  # Prepare path for files to merge
  path_test_file <- paste(path_test,"/",filenames_test[i], sep = "")
  path_train_file <- paste(path_train,"/",filenames_train[i], sep = "")
  
  # Prepare for file load
  num2 <- rep(16, times = 128)
  
  # Load files
  Signals_Test <- read.fwf(path_test_file, num2, sep = "")
  Signals_Train <- read.fwf(path_train_file, num2, sep = "")
  
  # Merge files
  Signals_Merged <- Signals_Test
  Signals_Merged <- rbind(Signals_Merged, Signals_Train)
  
  # Count rows for each kind of signal
  rows <- nrow(Signals_Merged)
  
  # Prepare a data frame with signal name, mean, standard deviation and activity number
  Signals_Measures_tmp <- data.frame("signal" = rep(signal_name, times = rows))
  Signals_Measures_tmp <- cbind(Signals_Measures_tmp, data.frame("mean" = rowMeans(Signals_Merged)))
  tmp_frame <- data.frame("SD" = apply(Signals_Merged,1, sd))
  Signals_Measures_tmp <- cbind(Signals_Measures_tmp, tmp_frame)
  Signals_Measures_tmp <- cbind(Signals_Measures_tmp, activities)
  Signals_Measures <- rbind(Signals_Measures,Signals_Measures_tmp)
  i <- i+1
}

# Merge with activity names
Signals_Measures_labeled <- merge(x = Signals_Measures, y = activities_codetable, by = "act_nbr")

# Order and ommit "act_nbr"
Signals_Measures_labeled <- Signals_Measures_labeled[,c(2,3,4,5)]

##### Task 5 #####

# Rename
subject <- subject_merged
colnames(subject) <- "subject"

# Prepare data frames
Signals_Averages_Prep <- data.frame("signal" = 0, "mean" = 0, "SD" = 0, "activity" = 0)
Signals_Averages <- data.frame("signal" = 0, "mean" = 0, "SD" = 0, "activity" = 0, "subject" = 0)

signal_names <- unique(Signals_Measures_labeled$signal)

# For every kind of signal do:
i <- 1
while (i <= length(signal_names)) {
  Signals_Averages_Prep <- rbind(filter(Signals_Measures_labeled, signal == signal_names[i]))
  Signals_Averages_Prep <- cbind(Signals_Averages_Prep, "subject" = subject)
  Signals_Averages <- rbind(Signals_Averages, Signals_Averages_Prep)
  i = i+1
}

# Final computing of average measures for subject-activity-signal
Signals_Avg <- data.table(Signals_Averages)
Signals_Avg <- Signals_Avg[,.("average" = mean(mean)), by = .(signal, activity,subject)]

# Show all rows
print(Signals_Avg, nrow=316)

# Export to a txt file
write.table(Signals_Avg, "Signals_Avg.txt", row.name=FALSE)
