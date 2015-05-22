# Getting_Cleaning_Data_Project
This repository was created for the purpose of a Coursera project in the Getting and Cleaning Data class.

Repository contains 3 files:

- run_analysis.R - code transforming data using R language
- CodeBook.md - metadata file explaining variables and transformations in run_analysis.R
- README.md - metadata file explaining repository Getting_Cleaning_Data_Project

The main file is **run_analysis.R** which can be run in RStudio and was written using R version 3.1.3. Needed input is the dataset described in project description (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

**Variables (ordered alphabeticaly) in the code:**
- activities_codetable - data frame with the names of activities, later merged with Signals_Measures
- filenames_test - names of files in the directory "test\Inertial Signals"
- filenames_train - names of files in the directory "train\Inertial Signals"
- num2 - the number of measures 
- path_test, path train - paths to files in "Inertial Signals"
- path_test_file, path_train_file - full path to each file in "Inertial Signals"
- rows - the number of rows for each type of signal (each file in "Inertial Signals")
- signal_name - name of each signal, derived from file names in directory "Inertial Signals"
- Signals_Averages - data frame containing data from tasks 1-4 including subject numbers
- Signals_Averages_Prep - temporary data frame to help create Signals_Averages
- Signals_Avg - final tidy data set with the average of each variable for each activity and each subject
- Signals_Measures - data frame containing data for tasks 1-4 (columns: signal, mean,SD,act_nbr)
- Signals_Measures_labeled - data frame containing final data for tasks 1-4 includig activity names (columns: signal, mean, SD, activity)
- Signals_Measures_tmp, tmp_frame - temporary data frames to help create Signals_Measures data frame
- Signals_Merged - contains merged files from "Inertial Signals" with the signals data
- Signals_Test, Signals_Train - original files from "Inertial Signals" loaded in order to be merged
- subject_merged - a new data set containing both original data files with subject numbers
- subject_test, subject_merged - data loaded from original sources, subject number
- y_Merged - a new data set containing both original data files with activity numbers
- y_test, y_train - data loaded from original sources, activity number
