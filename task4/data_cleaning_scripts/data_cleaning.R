library(tidyverse)
library(readxl)
library(janitor)

candy_2015 <- read_excel("raw_data/boing-boing-candy-2015.xlsx")
candy_2016 <- read_excel("raw_data/boing-boing-candy-2016.xlsx")
candy_2017 <- read_excel("raw_data/boing-boing-candy-2017.xlsx")

# CANDY 2017

# cleaning variable names

colnames(candy_2017) <- colnames(candy_2017) %>% 
  str_remove_all(c("Q6 \\| |Q\\d{1,2}\\:" = "",
                   "\\? |\\!" = "",
                   "/  \\," = " ",
                   "\\( |\\)" = ""))

candy_2017 <- clean_names(candy_2017)

# excluding variables not needed for data analysis

candy_2017 <- candy_2017 %>% 
  select(-c(state_province_county_etc, bonkers_the_board_game, 
            cash_or_other_forms_of_legal_tender, hugs_actual_physical_hugs,
            abstained_from_m_ming, 
            real_housewives_of_orange_county_season_9_blue_ray,
            joy_other, despair_other, other_comments, dress, x114, day, 
            media_daily_dish, media_science, media_espn, media_espn, media_yahoo,
            click_coordinates_x_y, internal_id, 
            creepy_religious_comics_chick_tracts, healthy_fruit, kale_smoothie, 
            white_bread, whole_wheat_anything, 
            sandwich_sized_bags_filled_with_boo_berry_crunch))

# CANDY 2016

# cleaning variable names

candy_2016 <- clean_names(candy_2016)

# excluding variables not needed for data analysis

candy_2016 <- candy_2016 %>% 
  select(-c(timestamp, which_state_province_county_do_you_live_in, 
            bonkers_the_board_game, cash_or_other_forms_of_legal_tender,
            creepy_religious_comics_chick_tracts, healthy_fruit, 
            kale_smoothie, person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes,
            white_bread, whole_wheat_anything, 
            please_list_any_items_not_included_above_that_give_you_joy:york_peppermint_patties_ignore,
            hugs_actual_physical_hugs))

# CANDY 2015

# cleaning variable names

candy_2015 <- clean_names(candy_2015)

# excluding variables not needed for data analysis

candy_2015 <- candy_2015 %>% 
  select(-c(timestamp, cash_or_other_forms_of_legal_tender, lapel_pins, 
            creepy_religious_comics_chick_tracts, healthy_fruit, kale_smoothie,
            white_bread, whole_wheat_anything, hugs_actual_physical_hugs,
            peterson_brand_sidewalk_chalk,
            please_leave_any_remarks_or_comments_regarding_your_choices:please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_francis_bacon_1561_1626,
            which_day_do_you_prefer_friday_or_sunday:please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_beyonce_knowles)
         )

# check variable names across tables

names(candy_2016) %in% names(candy_2017)

names(candy_2017) %in% names(candy_2016)

names(candy_2015) %in% names(candy_2017)

names(candy_2017) %in% names(candy_2015)

# rename variables to march names across tables

candy_2017 <- candy_2017 %>% 
  rename(trick_or_treat = going_out)

candy_2016 <- candy_2016 %>% 
  rename(trick_or_treat = are_you_going_actually_going_trick_or_treating_yourself,
         gender = your_gender,
         age = how_old_are_you,
         country = which_country_do_you_live_in,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
         independent_m_ms = third_party_m_ms)

candy_2015 <- candy_2015 %>% 
  rename(trick_or_treat = are_you_going_actually_going_trick_or_treating_yourself,
         age = how_old_are_you, 
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
         bonkers_the_candy = bonkers,
         boxo_raisins = box_o_raisins,
         hersheys_dark_chocolate = dark_chocolate_hershey,
         hersheys_kisses = hershey_s_kissables,
         sweetums_a_friend_to_diabetes = sweetums)

# alter the table look

table_2017<- candy_2017 %>% 
  pivot_longer(cols = x100_grand_bar:york_peppermint_patties,
               names_to = "candy_type",
               values_to = "feeling")

table_2016<- candy_2016 %>% 
  pivot_longer(cols = x100_grand_bar:york_peppermint_patties,
               names_to = "candy_type",
               values_to = "feeling")

table_2015<- candy_2015 %>% 
  pivot_longer(cols = butterfinger:necco_wafers,
               names_to = "candy_type",
               values_to = "feeling")

# add year column to data frames

table_2017$year <- 2017

table_2016$year <- 2016

table_2015$year <- 2015

# bind rows

candy <- bind_rows(table_2015, table_2016, table_2017)

# CLEAN COUNTRY COLUMN

# unify casing for all text data

candy <- candy %>% 
  mutate(country = str_to_lower(country),
         trick_or_treat = str_to_lower(trick_or_treat),
         feeling = str_to_lower(feeling))

# create new table with distinct country names

distinct_countries <- candy %>% 
  distinct(country)

# unify the variations of strings for particular country entry
    
candy <- candy %>% 
  mutate(country = case_when(
    country %in% c("us", "united states", "ussa", "united states of america",
                   "america", "u.s.a.", "murica", "usa!", "units states",
                   "u.s.", "usa usa usa", 
                   "usa (i think but it's an election year so who can really tell)",
                   "the best one - usa", "usa! usa! usa!", "usa!!!!!!", 
                   "usa! usa!", "united sates", "merica", "united stetes",
                   "usa usa usa usa", "united  states of america", "united state",
                   "united staes", "usausausa", "us of a", "unites states",
                   "the united states", "north carolina", "unied states",
                   "u s", "the united states of america", "unite states",
                   "usa? hard to tell anymore..", "'merica", "usas",
                   "pittsburgh", "new york", "california", "united stated",
                   "ahem....amerca", "new jersey", "united ststes",
                   "united statss", "usaa", "alaska", "u s a", "united statea",
                   "usa usa usa!!!!", "murrika",
                   "i pretend to be from canada, but i am really from the united states.") ~ "usa",
    country %in% c("united kingdom", "england", "scotland", "united kindom", 
                   "u.k.", "endland") ~ "uk",
    country %in% c("sub-canadian north america... 'merica", "can", "canada`",
                   "n. america") ~ "canada",
    T ~ country))

# clean age column, extract numeric values, and convert unreasonable numbers to NA

candy <- candy %>% 
  mutate(age = as.numeric(str_extract(age, "[0-9]+")),
         age = na_if(age, age > 122))


# save cleaned data frame

write_excel_csv(candy, "clean_data/candy.xlsx")

write_csv(candy, "clean_data/candy.csv")


