# training_source.R — shared setup for Intro to R Workshop
# Installs (if needed) and loads packages, then defines helper functions used in the QMD.

pkgs <- c(
  "rio",        # import/export by file extension
  "tidyverse",  # dplyr, tidyr, ggplot2, readr, etc.
  "lubridate",  # date-time parsing
  "stringr",    # string utilities
  "janitor",    # clean_names(), tabyl(), etc.
  "scales",     # percent_format and friends
  "tidycensus"  # ACS API wrapper (optional bonus section)
)

need <- pkgs[!pkgs %in% rownames(installed.packages())]
if (length(need)) install.packages(need)

invisible(lapply(pkgs, library, character.only = TRUE))

