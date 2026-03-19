# load libraries
library(dplyr)
library(ggplot2)
library(tidyr)

# load clean dataset
clean_df <- readRDS("data/clean_data.rds") #this imports the data file


speed_occ <- clean_df |> 
  ggplot(aes(x = speed, y = occupancy, colour = detector_id)) +
  geom_point()
  speed_occ
  #aes assigns base x and y coordinates; use + instead of pipe since we're layering data
  
clean_df$detector_id <- as.factor(clean_df$detector_id) # one way to change data type for a column, but very permanent

#in this next version, we change the format of detector_id to a factor so that it's easier to see
speed_occ <- clean_df |> 
  ggplot(aes(x = speed, y = occupancy, colour = as.factor(detector_id))) +
  geom_point()
speed_occ

#speed vs volume
speed_vol <- clean_df |> 
  ggplot(aes(x = speed, y = volume, colour = as.factor(detector_id))) +
  geom_point()
speed_vol

#another version, now with filters (best version)
speed_occ <- clean_df |> 
  filter(detector_id < 101100) |> 
  filter(speed > 40) |>
  ggplot(aes(x = speed, y = occupancy, colour = as.factor(detector_id))) +
  geom_point()
speed_occ

#another version, different graphs type (geom)
speed_occ <- clean_df |> 
  filter(detector_id == 100900) |> 
  ggplot(aes(x = speed, y = starttime)) +
  geom_point()
speed_occ

#another version, now with ability to click plot points using plotly
library(plotly)
det_speed_figly <- ggplotly(speed_occ)
det_speed_figly

