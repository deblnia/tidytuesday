library(tidyverse)

# There was some stuff I wanted to do that I didn't get to here: 
  # Direct labels - the offset kept getting messy using ggtextpath::geom_linelabel() 
    # geom_textline(vjust=-0.6, size=3, hjust=0.1, linewidth=0.5, offset = unit(-0.6, "inch"), padding = unit(0.8, "inch")) + 
  # Arrows - I ended up going with just rotated text in the box instead of having an arrow but that's a useful snippet I think 
    # annotate("segment", x = as.Date("2019-06-01"), xend = as.Date("2019-12-01"), y = 800e6, yend = 800e6,
      #  size = .5, arrow = arrow(type = "closed", length = unit(0.02, "npc"))) + 
  # Direct text - I used the default annotate function, but I could've also used ggtext::geom_text_box()

eggproduction  <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-11/egg-production.csv')

eggproduction %>% 
  filter(prod_process != "all") %>%
  mutate(prod_process = if_else(prod_process == 'cage-free (organic)', 'Organic', 'Non-Organic')) %>% 
ggplot(aes(observed_month, n_eggs, color = prod_process, label=prod_process)) + 
  geom_line() + 
  annotate("rect", xmin = as.Date("2020-01-01"), xmax = as.Date("2021-03-01"), ymin = 0, ymax = 1.6e9,
           alpha = .5,fill = "darkgrey") + 
  annotate(geom = "text", x = as.Date("2020-02-15"), y = 8e8, label = "COVID-19", color = "black",
           angle = 90) + 
  theme_minimal() + 
  theme(legend.position = "top",
        legend.title = element_blank()) + 
  scale_y_continuous(labels = scales::label_number_si()) + 
  labs(x = "", 
       y = "Num. Cage-Free Eggs")


  
