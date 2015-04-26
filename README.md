---
title: "Readme"
author: "Mitta Suresh"
date: "Sunday, April 26, 2015"
output: html_document
---

# Getting-and-Cleaning-Data-Project
Course Project for getting and cleaning data


#COURSE PROJECT#

Please refer to the attached R script titled "run_analysis.R"

The script is divided into 4 sections

##Loading Data and Merging##
Read multiple files using read.tables()
Merged the files with rbind() and cbind() as needed


##Adding Descriptive Titles##
Read the column header file and added them to the column names
Changed the Activity number to descriptive names based on the information in the Activities file.

##Reducing Number of Columns##
This was tricky, until I found the right function. I used grep() function to find the colnames which contained the word "mean" and"std"
Then copied the appropriate columns to a reduced_data frame

##Creating Tidy Set by Averaging Selective Rows##
In the last step I used a nested loop to loop over subject and activity. Identified relevant rows and calculated ColMeans.
The Values were saved into a dataframe.
In the End the data frame is written to a file using write.table() function.

The attached R script should run as long as the required files are in the working directory.
