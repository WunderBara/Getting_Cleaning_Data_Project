This codebook describes variables and transformations in run_analysis.R file.

**Data frame Signals_Measures_labeled**
- signal - type of signal from Inertial Signals, derived from file names
- mean - mean for each measurement in Inertial Signals
- SD - standard deviation for each measurement in Inertial Signals
- activity - the name of a measured activity

**Data frame Signals_Avg**
- signal - type of signal from Inertial Signals, derived from file names
- activity - the name of a measured activity
- subject - identification of a measured person
- average - everage of each activity for each activity and each subject

**Transformations**
- signal name is derived from the file names in Inertial Signals (remove "_test.txt")
- mean and standard deviation are computed from signal measures (Inertial Signals) in a loop for each type of signal
- activity name: first column bind activity number and then merge with the codetable with activity names
- subject is column bind in a loop for each type of signal
- average is computed using data.table package (mean by signal, activity,subject)
