# create a publication ready plot


library(tidyverse)

# load data
tbl_pollen <- readRDS("00_Data/pollen.rds")




# melt/gather/collect the inside and outside pollen counts (pol.count.in, pol.count.out)
tbl_pollen_long1 <- tbl_pollen %>% 
  pivot_longer(c(pol.count.in, pol.count.out))
  

# plot boxplots (horizontally) of the values by orient.vent; distinguish by in/out
# hint: fill works well for boxplots
tbl_pollen_long1 %>% 
  ggplot(aes(value, orient.vent, fill = name))+
  geom_boxplot()

# switch the theme (choose one you like)
tbl_pollen_long1 %>% 
  ggplot(aes(value, orient.vent, fill = name))+
  geom_boxplot()+
  theme_bw()

# remove axis title for orient.vent
# change value legend to "Pollen grains per cubic metre"
tbl_pollen_long1 %>% 
  ggplot(aes(value, orient.vent, fill = name))+
  geom_boxplot()+
  theme_bw()+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)


# increase the overall size of labels
# hint: base size of the theme
tbl_pollen_long1 %>% 
  ggplot(aes(value, orient.vent, fill = name))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)


# change the color scale | or manually choose colors
tbl_pollen_long1 %>% 
  ggplot(aes(value, orient.vent, fill = name))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)+
  scale_fill_brewer(type = "qual")

# remove legend title
# hint: look at theme()
tbl_pollen_long1 %>% 
  
  ggplot(aes(value, orient.vent, fill = name))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)+
  scale_fill_brewer(type = "qual")+
  theme(legend.title = element_blank())

# rearrange boxplot order (of orient.vent) by values
tbl_pollen_long1 %>% 
  mutate(orient.vent_fct = fct_reorder(orient.vent, value)) %>% 
  
  ggplot(aes(value, orient.vent_fct, fill = name))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)+
  scale_fill_brewer(type = "qual")+
  theme(legend.title = element_blank())

# modify the labels of pol.count.in and pol.count.out to
# e.g. Inside and Outside
tbl_pollen_long1 %>% 
  mutate(orient.vent_fct = fct_reorder(orient.vent, value),
         name_fct = fct_recode(
           name,
           "Inside" = "pol.count.in",
           "Outside" = "pol.count.out"
         )) %>% 
  
  ggplot(aes(value, orient.vent_fct, fill = name_fct))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)+
  scale_fill_brewer(type = "qual")+
  theme(legend.title = element_blank())


# move the legend inside the plot area
# hint: theme -> legend.***
tbl_pollen_long1 %>% 
  mutate(orient.vent_fct = fct_reorder(orient.vent, value),
         name_fct = fct_recode(
           name,
           "Inside" = "pol.count.in",
           "Outside" = "pol.count.out"
         )) %>% 
  
  ggplot(aes(value, orient.vent_fct, fill = name_fct))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)+
  scale_fill_brewer(type = "qual")+
  theme(legend.title = element_blank(),
        legend.position = c(0.8, 0.9))

# add a box around the legend (to distinguish from plot)
tbl_pollen_long1 %>% 
  mutate(orient.vent_fct = fct_reorder(orient.vent, value),
         name_fct = fct_recode(
           name,
           "Inside" = "pol.count.in",
           "Outside" = "pol.count.out"
         )) %>% 
  
  ggplot(aes(value, orient.vent_fct, fill = name_fct))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)+
  scale_fill_brewer(type = "qual")+
  theme(legend.title = element_blank(),
        legend.position = c(0.8, 0.9),
        legend.background = element_rect(linetype = "solid", color = "black"))


# match the order of the color in the boxplots to the order of colors in the legend
# hint: breaks argument in the color scale defines also order
tbl_pollen_long1 %>% 
  mutate(orient.vent_fct = fct_reorder(orient.vent, value),
         name_fct = fct_recode(
           name,
           "Inside" = "pol.count.in",
           "Outside" = "pol.count.out"
         )) %>% 
  
  ggplot(aes(value, orient.vent_fct, fill = name_fct))+
  geom_boxplot()+
  theme_bw(14)+
  xlab("Pollen grains per cubic metre")+
  ylab(NULL)+
  scale_fill_brewer(type = "qual", breaks = c("Outside", "Inside"))+
  theme(legend.title = element_blank(),
        legend.position = c(0.8, 0.9),
        legend.background = element_rect(linetype = "solid", color = "black"))


# save the plot as pdf and png
ggsave(filename = "ready-01.pdf", width = 8, height = 5)
ggsave(filename = "ready-01.png", width = 8, height = 5)


