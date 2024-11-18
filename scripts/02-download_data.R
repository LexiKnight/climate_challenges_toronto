#### Preamble ####
# Purpose: Downloads and saves the climate data from opendatatoronto.
# Author: Lexi Knight
# Date: 17 November 2024
# Contact: lexi.knight@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
# Install the necessary packages if needed
# install.packages(c("httr", "readxl", "tidyverse", "data.table"))

# Load required libraries
library(httr)
library(readxl)
library(tidyverse)
library(data.table)

#### Download data ####
# URL to the CSV file
csv_url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/77e593cf-877b-4bcc-bfdf-0b99e2935e5f/resource/cd92b939-f618-49db-b497-b6daf06ecf02/download/Raw%20data.csv"

# Download the file to a temporary file using httr::GET
response <- GET(csv_url, write_disk(tf <- tempfile(fileext = ".csv")))

# Check if the response is successful (HTTP 200)
if (response$status_code != 200) {
  stop("Failed to download file: HTTP ", response$status_code)
}

# Read the CSV file using fread
raw_data <- fread(tf)

# View the first few rows to confirm the data
head(raw_data)

#### Save data ####
write_csv(raw_data, "data/01-raw_data/climate_challenges_raw_data.csv")