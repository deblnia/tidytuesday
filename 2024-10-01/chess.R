if (!c("tidyverse","maggrittr") %in% installed.packages()) {
  install.package("tidyverse")
  install.packaeg("magrittr")
}


library(tidyverse)
library(magrittr)


df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/master/data/2024/2024-10-01/chess.csv")


df %>% 
  count(opening_name, winner) 