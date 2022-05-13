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
tbl_histalp_summ %>% 
  ggplot(aes(month, mean_prec))+
  geom_col()+
  facet_wrap(~ zone)

# make self-explaining x-axis labels
# hint: R has a built-in variable called: month.abb
# try both: you can create a new variable in the data or
#           you can modify the scale_x directly
tbl_histalp_summ %>% 
  mutate(month_fct = factor(month, levels = 1:12, labels = month.abb)) %>% 
  
  ggplot(aes(month_fct, mean_prec))+
  geom_col()+
  facet_wrap(~ zone)

tbl_histalp_summ %>% 
  ggplot(aes(month, mean_prec))+
  geom_col()+
  facet_wrap(~ zone)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)

# continue with the version where you modified the scale_x directly
# modify the theme
# make meaningful axis titles
tbl_histalp_summ %>% 
  ggplot(aes(month, mean_prec))+
  geom_col()+
  facet_wrap(~ zone)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)+
  theme_bw()+
  xlab(NULL)+
  ylab("Precipitation in mm")

# remove the space between bars and low panel border (the one below 0)
# hint: expand argument of the appropriate scale
tbl_histalp_summ %>% 
  ggplot(aes(month, mean_prec))+
  geom_col()+
  facet_wrap(~ zone)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)+
  theme_bw()+
  xlab(NULL)+
  ylab("Precipitation in mm")+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 220))


# add horizontal lines for the average monthly precip (for each zone)
# and style it to your own choice
# hint: separate data?
tbl_histalp_summ_avg <- 
  tbl_histalp_summ %>% 
  group_by(zone) %>% 
  summarise(avg_prec = mean(mean_prec))

tbl_histalp_summ %>% 
  ggplot(aes(month, mean_prec))+
  geom_hline(data = tbl_histalp_summ_avg,
             aes(yintercept = avg_prec), 
             colour = "darkblue", size = 1.5, linetype = "dashed")+ # arbitrary
  geom_col()+
  facet_wrap(~ zone)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)+
  theme_bw()+
  xlab(NULL)+
  ylab("Precipitation in mm")+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 220))



# reorder facets by average precip (descending)
# hint: need to have the same facetting variable, if you combine different datasets
tbl_histalp_summ_avg2 <- tbl_histalp_summ_avg %>% 
  mutate(zone_fct = fct_reorder(zone, avg_prec, .desc = T))

tbl_histalp_summ %>% 
  mutate(zone_fct = factor(zone,
                           levels = levels(tbl_histalp_summ_avg2$zone_fct))) %>% # get order from the summary
  
  ggplot(aes(month, mean_prec))+
  geom_hline(data = tbl_histalp_summ_avg2,
             aes(yintercept = avg_prec), 
             colour = "darkblue", size = 1.5, linetype = "dashed")+
  geom_col()+
  facet_wrap(~ zone_fct)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)+
  theme_bw()+
  xlab(NULL)+
  ylab("Precipitation in mm")+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 220))


# annotate the avg_prec line with the actual amount of mm
tbl_histalp_summ %>% 
  mutate(zone_fct = factor(zone,
                           levels = levels(tbl_histalp_summ_avg2$zone_fct))) %>% 
  
  ggplot(aes(month, mean_prec))+
  geom_hline(data = tbl_histalp_summ_avg2,
             aes(yintercept = avg_prec), 
             colour = "darkblue", size = 1.5, linetype = "dashed")+
  geom_text(data = tbl_histalp_summ_avg2,
            aes(x = 0.5, y = avg_prec, label = paste0(round(avg_prec), " mm")),
            colour = "darkblue", hjust = 0, vjust = -0.5, size = 5)+
  geom_col()+
  facet_wrap(~ zone_fct)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)+
  theme_bw()+
  xlab(NULL)+
  ylab("Precipitation in mm")+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 220))

# remove x-axis ticks
# remove background grid except for main (major) horizontal lines
tbl_histalp_summ %>% 
  mutate(zone_fct = factor(zone,
                           levels = levels(tbl_histalp_summ_avg2$zone_fct))) %>% 
  
  ggplot(aes(month, mean_prec))+
  geom_hline(data = tbl_histalp_summ_avg2,
             aes(yintercept = avg_prec), 
             colour = "darkblue", size = 1.5, linetype = "dashed")+
  geom_text(data = tbl_histalp_summ_avg2,
            aes(x = 0.5, y = avg_prec, label = paste0(round(avg_prec), " mm")),
            colour = "darkblue", hjust = 0, vjust = -0.5, size = 5)+
  geom_col()+
  facet_wrap(~ zone_fct)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)+
  theme_bw()+
  xlab(NULL)+
  ylab("Precipitation in mm")+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 220))+
  theme(axis.ticks.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank())



# for bars you can achieve a cool effect that aids in visual interpretation
# if you draw the horizontal grid above the bars in the background (white?) color
# hint: use geom_hline
tbl_histalp_summ %>% 
  mutate(zone_fct = factor(zone,
                           levels = levels(tbl_histalp_summ_avg2$zone_fct))) %>% 
  
  ggplot(aes(month, mean_prec))+
  geom_hline(data = tbl_histalp_summ_avg2,
             aes(yintercept = avg_prec), 
             colour = "darkblue", size = 1.5, linetype = "dashed")+
  geom_col()+
  geom_hline(yintercept = seq(50, 200, by = 50),
             colour = "white")+
  geom_text(data = tbl_histalp_summ_avg2,
            aes(x = 0.5, y = avg_prec, label = paste0(round(avg_prec), " mm")),
            colour = "darkblue", hjust = 0, vjust = -0.5, size = 5)+
  facet_wrap(~ zone_fct)+
  scale_x_continuous(breaks = 1:12, labels = month.abb)+
  theme_bw()+
  xlab(NULL)+
  ylab("Precipitation in mm")+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 220))+
  theme(axis.ticks.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank())


# save the plot as png
# make sure the labels can all be read (-> width and height)
ggsave(filename = "ready-02.png",
       width = 12, height = 6)

