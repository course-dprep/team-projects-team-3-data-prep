# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

library(dplyr)
library(stringr)

dataset_restaurants <- Dataset_raw %>%
  filter(str_detect(categories, regex("\\bRestaurants\\b", ignore_case = TRUE)))
dataset_restaurants <- dataset_restaurants %>% filter(str_detect(attributes, "RestaurantsPriceRange2"))
view(dataset_restaurants)



