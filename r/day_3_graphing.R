#load libraries

library(tidyr) 
library(dplyr)
library(lubridate)
library(ggplot2)

#load in data

clean_df <-  readRDS("../data/clean_data.rds")
raw_detectors <- read.csv("../data/raw/detectors.csv", stringsAsFactors = F)

#check what the data looks like
head(clean_df$starttime)

#use lubridate to change time zone
head(ymd_hms(clean_df$starttime, tz = "US/Pacific"))

#find the codes for every time zone
OlsonNames()

#change date format
clean_df$starttime <- ymd_hms(clean_df$starttime, tz = "US/Pacific")

#get unique detectors and station ids
det_st_ids <- raw_detectors |>
  select(
    detectorid,
    stationid
  ) |> 
  distinct()

#aggregate data from detector level to station level

stations_df <- clean_df |> 
  left_join(det_st_ids, by =c("detector_id" = "detectorid")) |> 
  group_by(
    stationid,
    starttime
  ) |> 
  summarise(
    mean_speed = mean(speed),
    tot_volume = sum(volume),
    mean_occ = mean(occupancy)
  ) |> 
  as.data.frame() #this helps keep the data in a tidy data frame; see how it runs the str function below without it

#view the structure of what we just made above
str(stations_df)

#create line graph of total volume by date at one station; right join to the starttime_seq data to remove the gaps
sta_1059 <- stations_df |> 
  filter(stationid == 1059) |> #just looking at one station to make data cleaner
  right_join(starttime_seq, by = "starttime") |>  #can do just the by = because column names are the same
  ggplot(aes(x = starttime, y = tot_volume)) +
  geom_line(color = "skyblue") + 
  geom_point(color = "darkblue") +
  scale_x_datetime(
    date_breaks = "1 day",
    date_labels = "%Y-%m-%d",
    guide = guide_axis(angle = 45)
  ) +
  xlab(NULL) +
  theme_bw() +
  geom_hline(yintercept = mean(stations_df$tot_volume),
             color = 'orange')
sta_1059

#how to address gaps in time data

starttime_seq <- seq(
  from = ymd_hms("2026-02-01 00:00:00", tz = "US/Pacific"),
  to = ymd_hms("2026-02-16 00:00:00", tz = "US/Pacific"),
  by = "15 min"
) |> 
  as.data.frame()
colnames(starttime_seq) <- c("starttime")

#create a function
figure_function <- function(stid,measure){
  sta_1059 <- stations_df |> 
    filter(stationid == stid) |> #just looking at one station to make data cleaner
    right_join(starttime_seq, by = "starttime") |>  #can do just the by = because column names are the same
    ggplot(aes(x = starttime, y = {{measure}})) +
    geom_line(color = "skyblue") + 
    geom_point(color = "darkblue") +
    scale_x_datetime(
      date_breaks = "1 day",
      date_labels = "%Y-%m-%d",
      guide = guide_axis(angle = 45)
    ) +
    xlab(NULL) +
    theme_bw() 
  sta_1059
}

figure_function(3142, mean_speed)

#we can save the above function as a separate R file; 
#loading it through source() executes the code in that file (so we don't need to rewrite the source)
source("figure_function.R") 
#now that it's loaded, you can run the function below without setting it up in current R file
figure_function(10755, mean_occ)


