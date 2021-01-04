library(tidyverse)

decathlon <- read_rds("raw_data/decathlon.rds")

# convert row names of a data frame into a variable

decathlon <- tibble::rownames_to_column(decathlon, "athlete")

# rename columns

names(decathlon) <- c("athlete", "sprint_100m", "long_jump", "shot_put", "high_jump", 
                      "sprint_400m", "hurdle_110m", "discus", "pole_vault", "javeline", 
                      "distance_1500m", "rank", "points", "competition")

# formatting

decathlon <- decathlon %>% 
  mutate(athlete = str_to_title(athlete),
         athlete = str_replace(athlete, "Mcmullen", "McMullen"),
         competition = str_replace_all(competition, "OlympicG", "Olympic_Games"))

# reshape data to long format

decathlon <- decathlon %>% 
  pivot_longer(sprint_100m:distance_1500m, names_to = "event", values_to = "score")

# save cleaned data into clean_data folder

write_rds(decathlon, "clean_data/decathlon.rds")
write_csv(decathlon, "clean_data/decathlon.csv")

