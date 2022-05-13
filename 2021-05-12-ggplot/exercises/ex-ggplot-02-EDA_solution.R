# EDA exercises

# NOTE ON SOLUTIONS:
# these are just examples. 
# often there is more than one way to visualize the same.
# even more often, there are different ways to examine relationships.

library(tidyverse)

# read data
tbl_pollen <- readRDS("00_Data/pollen.rds")

# overview of data
tbl_pollen %>% glimpse

# check if rooms, orientation, and ventilation are balanced
table(tbl_pollen$room, tbl_pollen$orientation)
table(tbl_pollen$room, tbl_pollen$ventilation)
table(tbl_pollen$ventilation, tbl_pollen$orientation)


# make a boxplot of pol.count.in by ventilation
ggplot(tbl_pollen, aes(ventilation, pol.count.in))+
  geom_boxplot()


# add a fill aesthetic for orientation
ggplot(tbl_pollen, aes(ventilation, pol.count.in, fill = orientation))+
  geom_boxplot()


# plot a histogram of pol.count.inout and facet by ventilation and orientation
ggplot(tbl_pollen, aes(pol.count.inout))+
  geom_histogram()+
  facet_grid(ventilation ~ orientation) # can also be orientation ~ ventilation

# or
ggplot(tbl_pollen, aes(pol.count.inout))+
  geom_histogram()+
  facet_wrap(~ ventilation + orientation) 

# examine the dependency of pol.count.inout on temperature
# group by orient.vent (try with aesthetics or facets)
ggplot(tbl_pollen, aes(temp, pol.count.inout))+
  geom_point()+
  facet_wrap(~ orient.vent) 

ggplot(tbl_pollen, aes(temp, pol.count.inout, 
                       colour = orient.vent, shape = orient.vent))+
  geom_point()






