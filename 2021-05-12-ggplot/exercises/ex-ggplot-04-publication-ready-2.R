# create another publication ready plot


library(tidyverse)

# load data
tbl_histalp <- readRDS("00_Data/histalp-clim.rds")


# aggregate by zone and month
tbl_histalp_summ <- tbl_histalp %>% 
  group_by(zone, month) %>% 
  summarise(mean_prec = mean(prec),
            mean_temp = mean(temp),
            .groups = "drop")


# plot mean_prec versus month as bars and facet by zone
# hint: there is more than geom_bar





# make self-explaining x-axis labels
# hint: R has a built-in variable called: month.abb
# try both: you can create a new variable in the data or
#           you can modify the scale_x directly









# continue with the version where you modified the scale_x directly
# modify the theme
# make meaningful axis titles








# remove the space between bars and low panel border (the one below 0)
# hint: expand argument of the appropriate scale








# add horizontal lines for the average monthly precip (for each zone)
# and style it to your own choice
# hint: separate data?











# reorder facets by average precip (descending)
# hint: need to have the same facetting variable, if you combine different datasets










# annotate the avg_prec line with the actual amount of mm











# remove x-axis ticks
# remove background grid except for main (major) horizontal lines











# for bars you can achieve a cool effect that aids in visual interpretation
# if you draw the horizontal grid above the bars in the background (white?) color
# hint: use geom_hline













# save the plot as png
# make sure the labels can all be read (-> width and height)




