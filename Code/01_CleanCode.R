here::i_am("Code/01_CleanCode.R")

#libraries
library(tidyverse)
library(ggrepel) #makes it easy to auto position labels
library(ggtext) #add annotations that mix normal text with italic and bold text
library(ggfittext) #autofit text on ggplots
library(countrycode) #assign continents by country code

library(showtext)
font_add_google("Lato")
showtext_auto()

#import data
data <- read.csv(here::here("Data/lgbt-rights-index.csv"))

#cleaning steps
data_clean <- data %>% 
  rename(PolicyIndex = LGBT..Policy.Index) #renaming policy index column

data_countries <- data_clean %>% 
  filter(Code != "") %>% 
  filter(Entity != "World" & Entity != "Kosovo" & Entity != "Micronesia (country)")

#pulling continent info using countrycode package
data_countries$Continent <- countrycode(sourcevar = data_countries$Entity, origin = "country.name", destination = "continent")

#data viz options for the dashboard
  # map by country
  # countries or continents over time
    # can set that the countries are shown for respective regions or continents selected!

theme_set(theme_minimal(base_family = "Lato", base_size = 18))

# line plot, index by continent over time
plot <- data_clean %>%
  filter(Entity == "Africa" | Entity == "Asia" | Entity == "Europe" |
           Entity == "North America" | Entity == "Oceania" | Entity == "South America") %>%
  ggplot(aes(Year, PolicyIndex, color = Entity)) +
  geom_line(size = 1) +
  labs(
    x = "Year", 
    y = "LGBT+ Rights Index",
    title = "Unequal Celebrations: Disparities in LGBT+ Rights Across the Globe (1991-2019)",
    subtitle = "This line graph showcases the disparity in equality for LGBT+ individuals across the globe. It highlights the varying trajectories regions of the world have been on to improve the rights for LGBT+ people - illuminating the 
diverse lived experiences of LGBT+ communities globally. The index measures a country's policy equality between LGBT+ and non-LGBT+ residents. Key highlights include the significant surge observed in South America
over the past decade reflecting the impact of cultural movements in this region. Conversely, the stagnant change in Africa underscores the ongoing challenges in this region for LGBT+ people.",
    caption = "Data Source: Kristopher Velasco (2020) – processed by Our World in Data"
  ) +
  theme(
    legend.position = "right",
    legend.title = element_blank(),
    legend.text = element_text(size = 30),
    axis.title.x = element_text(size = 30),
    axis.title.y = element_text(size = 30),
    axis.text = element_text(size = 25),
    plot.title = element_text(size = 73, face = "bold"),
    plot.subtitle = element_text(size = 28, lineheight = .5),
    plot.caption = element_text(hjust = 0, size = 25))

ggsave(
  filename = "lgbtrights_continent.png",
  plot = plot,
  width = 12.5,   
  height = 6.54,  
  units = "in",   
  dpi = 300,      
  bg = "white"    
)
