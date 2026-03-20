#load libraries

library(tidyr, dplyr, lubridate)

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

sta_1059 <- stations_df |> 
  filter(stationid == 1059) |> 
  ggplot(aes(x = starttime, y = tot_volume)) +
  geom_line() + 
  geom_point()
sta_1059