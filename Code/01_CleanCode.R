here::i_am("Code/01_CleanCode.R")

#libraries
library(tidyverse)

#import data
data <- read.csv(here::here("Data/lgbt-rights-index.csv"))

#cleaning steps
data_clean <- data %>% 
  rename(PolicyIndex = LGBT..Policy.Index)
         