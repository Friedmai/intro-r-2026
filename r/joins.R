library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(viridis)

clean_df <- readRDS("../data/clean_data.rds")
detectors <- read.csv("~/git-practice/intro-r-2026/data/raw/detectors.csv")

det <- detectors |> 
  filter(end_date == "") |> 
  select(detectorid, stationid)

df_stids <- clean_df |> 
  left_join(det, by =c("detector_id" = "detectorid"))

stations_df <- df_stids |> 
  group_by(
    stationid,
    starttime
  ) |> 
  summarise(
    mean_speed = mean(speed),
    tot_volume = sum(volume),
    mean_occ = mean(occupancy)
  )

st_speed_occ_fig <- stations_df |> 
  filter(stationid < 3140) |> 
  ggplot(aes(x = mean_speed, y = mean_occ)) +
  geom_point(aes(color = factor(stationid))) +
  scale_color_viridis(discrete = T) +
  theme_bw() +
  facet_grid(stationid ~ .,
             scales = "free")

st_speed_occ_fig
