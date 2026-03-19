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

raw_15min[3,2] # in brackets, first variable is row number, second is column. Better to use named columns
mean(raw_15min$speed) #won't work because there are NA values in column
mean(raw_15min$volume) #this works because column is all integer values
hist(raw_15min$volume) #shows basic distribution of values in bar graph (see Plots)

# integrating filters

occ_20plus <- raw_15min |> 
  filter(occupancy > 20)
  
  # the end of line 34 is the "pipe". can also do %>%, also with ctrl+shift+m

#multiple filters

occ10_spd80 <- raw_15min |> 
  filter(occupancy < 10 & speed > 80)
table(occ10_spd80$detector_id) # this table function shows how many times each value appears in stated column
