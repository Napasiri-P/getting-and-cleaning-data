---
title: "Tidy Data Codebook"
author: "Napasiri-P"
date: "5/26/2020"
output: html_document
---

The run_analysis.R performs following steps.

1. Merge the trainin and the test sets to create one data set, 'data' variabls  
- assign data set to x_train, y_train, x_test, y_test, subject_train, subject_test, features (feature names)  
- merge x_train-x_test, y_train-y_test with `rbind`  
- merges subject_train-subject_test with `rbind`  
- assign features as column names for x, subjectLabel for subject, and activityLabel for y  
- use `cbind` to bind together y, subject, x respectively  

2. Extract only features with mean and standard deviation (std)  
- use `grep` and `index` to find 'mean()' and 'std()' in column names  
- rule out 'meanFreq()' that is not mean()  
- keep data frame as `data_mean_std`

3. Create another dependent data set with mean of each column  
- `group_by` subjectLabel and activityLabel  
- use `summarise_all` to find mean of all columns  
- keep data as `data_mean_summary`

4. Save file  
- with `write.table` and `row.names = FALSE`  