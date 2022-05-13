# create a publication ready plot


library(tidyverse)

# load data
tbl_pollen <- readRDS("00_Data/pollen.rds")



# melt/gather/collect the inside and outside pollen counts (pol.count.in, pol.count.out)
tbl_pollen_long1 <- tbl_pollen %>% 
  pivot_longer(c(pol.count.in, pol.count.out))
  

# plot boxplots (horizontally) of the values by orient.vent; distinguish by in/out
# hint: fill works well for boxplots




# switch the theme (choose one you like)






# remove axis title for orient.vent
# change value legend to "Pollen grains per cubic metre"








# increase the overall size of labels
# hint: base size of the theme








# change the color scale | or manually choose colors







# remove legend title
# hint: look at theme()









# rearrange boxplot order (of orient.vent) by values









# modify the labels of pol.count.in and pol.count.out to
# e.g. Inside and Outside










# move the legend inside the plot area
# hint: theme -> legend.***











# add a box around the legend (to distinguish from plot)











# match the order of the color in the boxplots to the order of colors in the legend
# hint: breaks argument in the color scale defines also order












# save the plot as pdf and png







