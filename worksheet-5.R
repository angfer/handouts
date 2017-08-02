## Getting started

library(dplyr)
library(ggplot2)
#animals <- read.csv("data/animals.csv,na.strings = "")
animals <- read.csv('data/animals.csv', na.strings = '') %>%
  filter(!is.na(species_id), !is.na(sex), !is.na(weight))

#%>% tkaes the result of the read csv, sends directly into filter. replaces the first argument of filter
#with the data frame 
## Constructing layered graphics in ggplot

ggplot(data=animals, aes(x=species_id, y=weight))+ geom_point()
#aes tells ggplot how you want to map the variables in the data frame, geom_ options 

ggplot(data = animals,
       aes(x = species_id, y = weight)) + geom_boxplot()

ggplot(data = animals,
       aes(x = species_id, y = weight, color=species_id)) +
  geom_boxplot() +
  geom_point(stat='summary',
             fun.y='mean',
             color='cyan')

ggplot(data = animals,
       aes(x = species_id, y = weight, )) +
  geom_boxplot() +
  geom_point(stat = 'summary',
             fun.y = 'mean')

## Exercise 1

#only look at animal species DM, look at the changing weight of males and females over time 
animals_DM <- filter(animals,
                            species_id=='DM')
ggplot(data = animals_DM,
       aes(x = year, y = weight, color=sex)) +
  geom_point(stat='summary',
             fun.y='mean')

ggplot(data = animals_DM,
       aes(x = year, y = weight, color=sex)) +
  geom_line(stat='summary',
             fun.y='mean')

## Adding a regression line

levels(animals$sex) <- c('Female', 'Male')
ggplot(data=animals_DM,
       aes(x = year, y = weight)) +
  geom_point(aes(shape=sex),
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(method="lm")

ggplot(data = animals_DM,
       aes(x = year, y = weight)) + 
  geom_point(aes(shape = sex),
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(aes(group=sex),method="lm")
#research methods for statistics for these data 

ggplot(data = animals_DM,
       aes(x=year,y=weight,color=sex))
          + 
  geom_point(aes(shape = sex),
             size = 3,
	           stat = 'summary',
	           fun.y = 'mean') +
  geom_smooth(method = "lm")
#above didnt work, not sure why 

# Storing and re-plotting

year_wgt <- ggplot(data = animals_DM,
                   aes(x = year,
                       y = weight,
                       color = sex)) +
  geom_point(aes(shape = sex),
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(method = 'lm')

year_wgt +
  scale_color_manual(values=c("dark blue", "orange"))
                     
year_wgt <- year_wgt +
  scale_color_manual(values=c("dark blue", "orange"))

year_wgt

## Exercise 2

ggplot(data = animals_DM,
       aes(x=weight,fill=sex))+ 
geom_histogram(binwidth =1)
#binwidth shows the count at every gram. gives you an x scaling 
ggplot(data = animals_DM,
       aes(x=weight,fill=sex))+ 
  geom_histogram(binwidth =5)

## Axes, labels and themes

histo <- ggplot(data = animals_DM,
                aes(x = weight, fill = sex)) +
  geom_histogram(binwidth =5, color="white")
histo

histo <- histo +
  labs(title = 'Dipodomys merriami weight distribution',
       x = 'Weight (g)',
       y = 'Count') +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60))
#scale gives you the x interval 
histo
#colors of the graphs and stuff are goverend by themes 

histo <- histo +
  theme_bw() +
  theme(legend.position = c(0.2, 0.5),
        plot.title = element_text(face="bold", vjust=2),
        axis.title.x = element_text(size=13,vjust=1),
        axis.title.y = element_text(size = 13, vjust = 0))


histo

## Facets. this is if you want to make different plots in the same plot space 

animals_common <- filter(animals, species_id %in% c("DM", "PP", "DO"))
ggplot(data = animals_common,
       aes(x=weight)) +
  geom_histogram(binwidth = 5) +
  facet_wrap(~species_id)+
  labs(title = "Weight of most common species",
       x = "Count",
       y = "Weight (g)")
#would love to see how these graphs compare to the entire distribution
#will make two layers of histogram, an unfaceted and a faceted 

ggplot(data = animals_common,
       aes(x = weight)) +
  geom_histogram(data=select(animals_common, -species_id),
                 alpha=0.2) +
  geom_histogram() +
  facet_wrap( ~ species_id) +
  labs(title = "Weight of most common species",
       x = "weight (g)",
       y = "count")

#..density is an argument within ggplot does a density calculation on the data y= density 
ggplot(data = animals_common,
       aes(x = weight, fill=species_id)) +
  geom_histogram(aes(y=..density..)) +
  facet_wrap( ~ species_id) +
  labs(title = "Weight of most common species",
       x = "weight (g)",
       y = "count") +
  guides(fill = FALSE)		

## Exercise 3
ggplot(data = animals_common,
       aes(x = weight, fill=species_id:sex)) +
  geom_histogram() +
  facet_grid(sex ~ species_id) +
  labs(title = 'Weight of common species by sex',
       x = 'Count',
       y = 'Weight (g)')


