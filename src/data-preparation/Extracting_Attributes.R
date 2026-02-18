library(tidyverse)

#Extract Tru/false attributes
dataset_restaurants <- dataset_restaurants %>%
  mutate(
    # The delivery attributes
    RestaurantsDelivery = str_match(attributes, "RestaurantsDelivery'\\s*:\\s*'([^']*)'")[,2],
    RestaurantsTakeOut = str_match(attributes, "RestaurantsTakeOut'\\s*:\\s*'([^']*)'")[,2],
    Caters = str_match(attributes, "Caters'\\s*:\\s*'([^']*)'")[,2],
    DriveThru = str_match(attributes, "DriveThru'\\s*:\\s*'([^']*)'")[,2],
    
    # The dine-in related attributes
    RestaurantsReservations = str_match(attributes, "RestaurantsReservations'\\s*:\\s*'([^']*)'")[,2],
    RestaurantsGoodForGroups = str_match(attributes, "RestaurantsGoodForGroups'\\s*:\\s*'([^']*)'")[,2],
    Alcohol = str_match(attributes, "Alcohol'\\s*:\\s*'([^']*)'")[,2],
    HappyHour = str_match(attributes, "HappyHour'\\s*:\\s*'([^']*)'")[,2],
    OutdoorSeating = str_match(attributes, "OutdoorSeating'\\s*:\\s*'([^']*)'")[,2],
    GoodForKids = str_match(attributes, "GoodForKids'\\s*:\\s*'([^']*)'")[,2],
    RestaurantsTableService = str_match(attributes, "RestaurantsTableService'\\s*:\\s*'([^']*)'")[,2],
    
    # Extract Price range (numeric)
    price_range = as.numeric(str_match(attributes, "RestaurantsPriceRange2'\\s*:\\s*'([1-5])'")[,2])
  )

#Remove restaurants with price range NA
dataset_restaurants <- dataset_restaurants %>% filter(!is.na(price_range))

# Convert True/False to 1/0 to maybe work better in R
boolean_attributes <- c("RestaurantsDelivery", "RestaurantsTakeOut", "Caters", "DriveThru",
                        "RestaurantsReservations", "RestaurantsGoodForGroups", "HappyHour",
                        "OutdoorSeating", "GoodForKids", "RestaurantsTableService")

for(attr in boolean_attributes) {
  dataset_restaurants[[attr]] <- case_when(
    dataset_restaurants[[attr]] == "True" ~ 1,
    dataset_restaurants[[attr]] == "False" ~ 0,
    TRUE ~ NA_real_
  )
}

#Extract Alcohol attribute (string)
dataset_restaurants <- dataset_restaurants %>%
  mutate(
    # Extract Alcohol with a pattern that handles various formats
    Alcohol_raw = str_match(attributes, "Alcohol'\\s*:\\s*\"?(u?'[^']*')\"?")[,2],
    
    # Clean extracted values to just get the relevant info
    Alcohol = case_when(
      str_detect(Alcohol_raw, "none") ~ "none",
      str_detect(Alcohol_raw, "full_bar") ~ "full_bar",
      str_detect(Alcohol_raw, "beer_and_wine") ~ "beer_and_wine",
      TRUE ~ NA_character_
    ),
    
    # Convert to factor
    Alcohol = factor(Alcohol)
  ) %>%
  select(-Alcohol_raw)  # Remove temporary column

# Create cluster scores
dataset_restaurants <- dataset_restaurants %>%
  mutate(
    delivery_score = rowSums(across(all_of(c("RestaurantsDelivery", "RestaurantsTakeOut", 
                                             "Caters", "DriveThru"))), na.rm = TRUE),
    dinein_score = rowSums(across(all_of(c("RestaurantsReservations", "RestaurantsGoodForGroups",
                                           "HappyHour", "OutdoorSeating", "GoodForKids", 
                                           "RestaurantsTableService"))), na.rm = TRUE)
  )

