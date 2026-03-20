#load libraries
library(dplyr)
library(tidyr)
library(leaflet)
library(sf)

#pull in source data
raw_stations <- read.csv("../data/raw/stations.csv", stringsAsFactors = F)

#clean up with just the columns we need
stations <- raw_stations |> 
  filter(end_date == "") |> #filters out decommissioned stations
  select(
    stationid,
    locationtext,
    lon,
    lat,
    milepost,
    agency
  )

stations_map <- stations |> 
  filter(lon != -1) #trying to get rid of the weird values near Africa
  leaflet() |> #note that leaflet uses the pipe instead of + or comma
  addProviderTiles(providers$CartoDB.Positron) |> #tiles out the map
  addCircleMarkers(
    lng = stations$lon,
    lat = stations$lat,
    color = "purple",
    radius = 2,
    #popup sequence below creates a popup when you click a dot
    popup = paste("Stationid: ", stations$stationid, "<br>",
                  "Description: ", stations$locationtext, "<br>",
                  "Agency: ", stations$agency, "<br>",
                  "MP: ", stations$milepost)
  )
  
stations_map
  