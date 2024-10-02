packages <- c("tidyverse", "magrittr", "geomtextpath", "tidytext")
missing_packages <- packages[!(packages %in% installed.packages()[,"Package"])]

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}


library(tidyverse)
library(magrittr)
library(tidytext)

df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/master/data/2024/2024-10-01/chess.csv")


df %>% 
  count(opening_name, winner) %>% 
  group_by(winner) %>%
  top_n(5, n) %>%
  ungroup() %>%
  filter(winner != 'draw') %>%
  mutate(opening_name = reorder_within(opening_name, n, winner)) %>%
  ggplot(aes(opening_name, n)) + 
  geom_col(show.legend = FALSE) + 
  facet_wrap(~winner, scales = "free_y") + 
  coord_flip() + 
  scale_x_reordered() + 
  theme_bw() + 
  labs(x = "", y = "")






df %>% 
  count(winner, victory_status)  

# difference in rating distribution
df %>%
  ggplot() + 
  geom_textdensity(aes(white_rating, label="white"), color = "darkgrey", hjust=0.7) +  
  geom_textdensity(aes(black_rating, label="black"), color = "black", hjust=0.2) +
  theme_minimal()

# color winners 
df %>% 
  ggplot() + 
  geom_bar(aes(winner)) + 
  theme_minimal() + 
  scale_y_continuous(labels = scales::comma) + 
  labs(
    x = "", 
    y = ""
  ) + 
  ggtitle("Which color won more games?")