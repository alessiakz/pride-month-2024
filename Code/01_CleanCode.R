here::i_am("Code/01_CleanCode.R")

#libraries
library(tidyverse)
library(ggrepel) #makes it easy to auto position labels
library(ggtext) #add annotations that mix normal text with italic and bold text

library(showtext)
font_add_google("Lato")
showtext_auto()

#import data
data <- read.csv(here::here("Data/lgbt-rights-index.csv"))

#cleaning steps
data_clean <- data %>% 
  rename(PolicyIndex = LGBT..Policy.Index) #renaming policy index column

#data viz options for the dashboard
  # map by country
  # countries or continents over time
    # can set that the countries are shown for respective regions or continents selected!

theme_set(theme_minimal(base_family = "Lato"))

data_clean %>%
  filter(Entity == "Africa" | Entity == "Asia" | Entity == "Europe"
         | Entity == "North America" | Entity == "Oceania" | Entity == "South America") %>% 
  ggplot(aes(Year, PolicyIndex, color=Entity)) +
  geom_line(size = 1)


  





