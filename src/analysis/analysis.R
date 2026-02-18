# In this directory, you will keep all source code related to your analysis.

#Below is the code for several exploratory plots that give insight into the data

#Histogram of distribution of restaurant star ratings
library(ggplot2)

ggplot(dataset_restaurants, aes(x = stars)) +
  geom_histogram(binwidth = 0.5, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Restaurant Ratings",
    x = "Rating",
    y = "Number of Restaurants"
  ) +
  theme_minimal()

#Histogram of distibution of price range
library(ggplot2)

ggplot(dataset_restaurants, aes(x = price_range)) +
  geom_histogram(binwidth = 0.5, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Price Range for restaurants",
    x = "Price range indicator",
    y = "Number of Restaurants"
  ) +
  theme_minimal()

#
