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




# add a fill aesthetic for orientation





# plot a histogram of pol.count.inout and facet by ventilation and orientation







# examine the dependency of pol.count.inout on temperature
# group by orient.vent (try with aesthetics or facets)









