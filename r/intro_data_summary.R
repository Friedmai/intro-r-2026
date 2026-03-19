# Load libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(summarytools)

# can also do as a list

# Loading raw data

raw_15min <- read.csv("data/raw/agg_15min_data.csv", stringsAsFactors = F)

#what stringsAsFactors does is treat values that repeat in a column as a factor (i.e. like a category) instead of a text string, which we don't want, thus set it to false

#these next functions allow you to analyze the data in the csv file

#structure of data (as data frame); shows column names, data types, and example values
str(raw_15min)

# preliminary data exploration
head(raw_15min) #gives first 6 rows of data
tail(raw_15min) #gives final 6 rows
summary(raw_15min) #provides aggregate data about each column
glimpse(raw_15min) #nicer version of str()
dfSummary(raw_15min) #another nice summary format
