## Tidy data concept

response <- data.frame(
  trial = 1:3,
  treatment = c(0.22, 0.58, 0.31),
  control = c(0.42, 0.19, 0.40)
)

## Reshaping multiple columns in category/value pairs

library(tidyr)

df <- gather(response, key='factor',value='response',-trial)

counts <- data.frame(
  site = rep(1:3,each=2),
  species = rep(c('lynx','hare'),3),
  n = c(2, 341, 7, 42, 0, 289)
)

counts_spread <- spread(counts,
			key=species,
			value=n)

## Exercise 1

#getting rid of 0 lynxline , then putting it back in 
df2<-counts[-5, ]
spread(df2,key=species,value=n)
spread(counts[-5, ], key = species, value = n, fill = 0)
spread(counts, key = species, value = n, fill = 0)
## Read comma-separated-value (CSV) files

animals <- ...
#species id didnt read in right to this data 
animals <- read.csv('data/animals.csv',na.strings = "")


library(dplyr)


con <- ...(..., host = 'localhost', dbname = 'portal')
animals_db <- ...
animals <- ...
dbDisconnect(...)

## Subsetting and sorting

library(dplyr)
#filtering to only year 1990
#double equal means HAS TO

animals_1990_winter <- filter(animals,
                              year==1990,
                              month %in% 1:3)
#we are going to change this data set even further and overwrite it to
#get rid of year column
animals_1990_winter <- select(animals_1990_winter, -year)

#what if we wanted to re-arrange our data frame to make it easier to 
#look at 
#using the helper funciton desc for descending 

sorted <- arrange(animals_1990_winter,
              desc(species_id),weight)
#to see it, type 
View(sorted)
## Exercise 2

animals_kanga_rat <- filter(animals,
                              species_id=='RO')
animals_kanga_rat <- select(animals_kanga_rat, -year, -day,-month, -hindfoot_length)
animals_kanga_rat <- select(animals_kanga_rat, id, sex, weight)
## Chainning with pipes

sorted_pipe <- animals %>%
    ... # filter to the first 3 months of 1990
    ... # select all columns but year
    ... # sort with descening species_id and weight

## Grouping and aggregation

counts_1990_winter <- animals_1990_winter %>%
    group_by(...) %>%
    ...

weight_1990_winter <- animals_1990_winter %>%
    ...
    summarize(avg_weight = mean(...))

## Exercise 3

...

## Transformation of variables

prop_1990_winter <- counts_1990_winter %>%
    mutate(...)

## Exercise 4

...

## Database Connection

library(...)

con <- ...(PostgreSQL(), host = 'localhost', dbname = 'portal')
animals_db <- ...

species_month_prop <- ...
    group_by(species_id, month) %>%
    summarize(count = n()) %>%
    mutate(prop = count / sum(count)) %>%
    select(-count)

pivot <- ...
  spread(month, prop, fill = 0)

dbDisconnect(con)
