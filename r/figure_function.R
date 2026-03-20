#libraries
library(ggplot2)
library(dplyr)

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