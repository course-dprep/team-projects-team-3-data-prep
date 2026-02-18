# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

library(dplyr)
library(stringr)

dataset_restaurants <- Dataset_raw %>%
  filter(str_detect(categories, regex("\\bRestaurants\\b", ignore_case = TRUE)))
view(dataset_restaurants)
dataset_restaurants <- dataset_restaurants %>% filter(str_detect(attributes, "RestaurantsPriceRange2"))


dataset_restaurants <- dataset_restaurants %>%
  mutate(
    price_range = as.numeric(
      str_match(
        attributes,
        "RestaurantsPriceRange2'\\s*:\\s*'([1-5])"
      )[,2]
    )
  )



dataset_restaurants <- dataset_restaurants %>% filter(!is.na(price_range))
