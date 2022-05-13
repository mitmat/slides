# Introduction exercises



# load packages
library(tidyverse)



# geoms and aes -------------------------------------------------------------------

# read data
tbl_pollen <- readRDS("00_Data/pollen.rds")

# overview of data
tbl_pollen %>% glimpse

# create a simple scatter of temp (x) versus relhum (y)





# additionally colour by room




# change the shape of ALL points to solid triangles
# hint: ?pch (gives you the needed code)




# now modify the code, so that the shape varies by room





# plot a histogram of pol.count.inout




# change binwidth to 0.01




# plot a boxplot of pol.count.in by room





# layering ----------------------------------------------------------------


# read in histalp data
tbl_histalp <- readRDS("00_Data/histalp-clim.rds")

# work with the table
tbl_histalp

# summarise mean precipitation by month and zone
tbl_histalp_meanprec <- tbl_histalp %>% 
  group_by(month, zone) %>% 
  summarise(mean_prec = mean(prec), .groups = "drop") 

# plot precip (y) by month (x), and distinguish by zone
# use both points and lines
# try different aesthetics





# modify the following plot such that:
# - it has a horizontal line with the median precipitation (over all months and zones)
# - make the line larger than the others and in another color
# - the mean line should be below the points but above the lines

ggplot(tbl_histalp_meanprec,
       aes(month, mean_prec, linetype = zone, shape = zone))+ 
  geom_point(size = 2)+
  geom_line()

  



# inheritance of layers ---------------------------------------------------

# plot precip (y) by month (x), and distinguish by zone
# use shape for points (all black) and colour for lines
# try to use inheritance of aes()




# reproduce the above plot using the following code
# BUT: you're not allowed to modify the first two lines
#      (i.e. without modifying the aes() in the main ggplot() call)
ggplot(tbl_histalp_meanprec,
       aes(month, mean_prec, colour = zone, shape = zone))+ 
  geom_line()+
  geom_point()






# facets ------------------------------------------------------------------

# back to the pollen data
# merge date and time.interval to create a datetime column
tbl_pollen2 <- tbl_pollen %>% 
  separate(time.interval, into = c("time_start", "time_end"), sep = "-", remove = F) %>% # split time.interval
  mutate(datetime = lubridate::ymd_hm(paste0(date, " ", time_start)), # use lubridate's awesome functionality
         .before = date) # add it as first column

# check if it worked
tbl_pollen2


# plot temp (as y) versus the newly created datetime (x) and facet_wrap by room
# use points



# kind of little space for datetime
# -> arrange the wrapping in one column



# try to have similar plot using facet_grid



# add lines to the above plot



# geom_line connects all points, which is somehow problematic here
# since it misses the fact that the observations are sparse
# add "aes(group = date)" to the geom_line layer to solve this



# plot the same x and y, 
# use facet_grid with room in rows, and date (the original) as columns
# allow the scales to be free for date




# now add lines to the plot
# do you need to group here, or not?








