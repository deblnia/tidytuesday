library(tidyverse)
library(ggrepel)
library(geomtextpath)

# kinda weak (narratively and graphically) but good enough i guess 

winners <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-25/winners.csv')
london_marathon <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-25/london_marathon.csv') %>% 
                    rename( 
                      # could simplify with to_lower or like 
                      official_charity = `Official charity`, 
                      ds = `Date`, 
                      applicants = `Applicants`, 
                      year = `Year`, 
                      accepted = `Accepted`, 
                      starters = `Starters`, 
                      finishers = `Finishers`, 
                      raised = `Raised`
                    )
# year, accepted, raised 
london_marathon %>% 
  drop_na(raised) %>% 
  ggplot(aes(year, accepted)) + 
  geom_point(aes(size = raised), alpha = 0.2) + 
  geom_text_repel(aes(label = official_charity), size = 2, vjust=0.3) + 
  theme_minimal() + 
  theme(legend.position = "top") + 
  labs(x = "", 
       y = "Num. Runners Accepted", 
       size = "Money (£ millions)") + 
  scale_y_continuous(labels = scales::label_number_si())


winners %>% 
  ggplot(aes(x = Time, color = Category, label = Category)) + 
  geom_textdensity(hjust = 0.25, size = 3) + 
  theme_minimal() + 
  theme(legend.position = "none") + 
  labs(y = "")

