# This script will be used to populate the \data directory
# with all necessary raw data files.

#Run the installs below if you don't have these R packages yet (by removing the # in front of the lines)
#install.packages("googledrive")
#install.packages(tidyverse)

#Below is the code to download the relevant yelp dataset, note that you need to choose 1 or 2 in the console to login to google drive to get the authorization to download the data
suppressWarnings(library(googledrive))
file_id <- "13AZqPcwUro0jwsZIv6Q3WXeEn58YD5_x" 
drive_deauth()  # clear old token
drive_auth(scopes = "drive.readonly")
drive_download(as_id(file_id), path = "users.csv", overwrite = TRUE)
library(tidyverse)
Dataset_raw <- read_csv("users.csv")
View(Dataset_raw)
