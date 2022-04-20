# Adam Schwarz
# Project Proposal
# schwarz-sphenisciformes

# install required packages
install.packages("spocc")
install.packages("tidyverse")

# load required packages
library(spocc)
library(tidyverse)

# query chinstrap from gbif
chinstrapData <- occ(query="Pygoscelis antarcticus", from='gbif')
chinstrapData <- chinstrapData$gbif$data$Pygoscelis_antarcticus

# query gentoo from gbif
gentooData <- occ(query="Pygoscelis papua", from='gbif')
gentooData <- gentooData$gbif$data$Pygoscelis_papua

# query adelie from gbif
adelieData <- occ(query="Pygoscelis adeliae", from='gbif')
adelieData <- adelieData$gbif$data$Pygoscelis_adeliae

# function to clean data ~RUN THIS BLOCK BEFORE PROCEEDING~
cleanData <- function(df) {
  df <- df %>% 
    filter(individualCount != 0) %>% # count above zero
    filter(occurrenceStatus == 'PRESENT') %>% # present
    filter(latitude != 'NA') %>% # not missing latitude
    filter(longitude != 'NA') %>% # not missing longitude
    select(name, latitude, longitude, individualCount, year, month, day) # only the important variables
  return(df)
}

# clean chinstrap
chinstrapData <- cleanData(chinstrapData)

# clean gentoo
gentooData <- cleanData(gentooData)

# clean adelie
adelieData <- cleanData(adelieData)

# combine species
penguinData <- bind_rows(chinstrapData, gentooData, adelieData)

# rename name
penguinData <- penguinData %>% mutate(name = case_when(name == 'Pygoscelis antarcticus (J.R.Forster, 1781)' ~ 'chinstrap',
                                                       name == 'Pygoscelis papua (J.R.Forster, 1781)' ~ 'gentoo',
                                                       TRUE ~ 'adelie'))

saveSpace <- penguinData # save penguin data to not requery every time

penguinData <- saveSpace

penguinData <- penguinData %>% filter(longitude < 0, longitude > -100) # limit longitude?
penguinData <- penguinData %>% filter(latitude > -80, latitude < -50) # limit latitude?

# count number of species
penguinData %>% count(name)

# view data
View(penguinData)
