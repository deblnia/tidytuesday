packages <- c("tidyverse", "magrittr")
missing_packages <- packages[!(packages %in% installed.packages()[,"Package"])]

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}


library(tidyverse)
library(magrittr)

df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/master/data/2024/2024-10-08/most_visited_nps_species_data.csv")


head(df)

df %>% 
filter(TaxonRecordStatus == 'Inactive') %>% 
count(ParkName) %>% 
top_n(10) %>% 
arrange(desc(n)) %>% 
ggplot() + 
geom_col(aes(fct_reorder(as_factor(ParkName), n), n)) + 
coord_flip() + 
theme_minimal() + 
labs(x = "", 
     y = "", 
     title = "Where were the extinct animals?") + 
  theme(plot.title = element_text(hjust = 0.5))
