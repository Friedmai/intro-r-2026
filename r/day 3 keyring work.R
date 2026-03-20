#load libraries
library(janitor)
library(dplyr)
library(keyring)

#create a key
key_set(service = "example_service", username = NULL, keyring = NULL, prompt = "Password")

kb <- key_get()