cleanData <- function(df) {
  df <- df %>% 
    filter(individualCount != 0) %>% # count above zero
    filter(occurrenceStatus == 'PRESENT') %>% # present
    filter(latitude != 'NA') %>% # not missing latitude
    filter(longitude != 'NA') %>% # not missing longitude
    select(name, latitude, longitude, individualCount, year, month, day) # only the important variables
  return(df)
}

query <- function() {
  chinstrapData <- occ(query="Pygoscelis antarcticus", from='gbif')
  chinstrapData <- chinstrapData$gbif$data$Pygoscelis_antarcticus
  
  # query gentoo from gbif
  gentooData <- occ(query="Pygoscelis papua", from='gbif')
  gentooData <- gentooData$gbif$data$Pygoscelis_papua
  
  # query adelie from gbif
  adelieData <- occ(query="Pygoscelis adeliae", from='gbif')
  adelieData <- adelieData$gbif$data$Pygoscelis_adeliae
  
  # clean chinstrap
  chinstrapData <- cleanData(chinstrapData)
  
  # clean gentoo
  gentooData <- cleanData(gentooData)
  
  # clean adelie
  adelieData <- cleanData(adelieData)
  
  # combine species
  penguinData <- bind_rows(chinstrapData, gentooData, adelieData)
  
  # rename name
  penguinData <- penguinData %>% mutate(name = case_when(name == 'Pygoscelis antarcticus (J.R.Forster, 1781)' ~ 'Chinstrap',
                                                         name == 'Pygoscelis papua (J.R.Forster, 1781)' ~ 'Gentoo',
                                                         TRUE ~ 'Adelie'))
  
  penguinData <- penguinData %>% filter(longitude < 0, longitude > -100) # limit longitude
  penguinData <- penguinData %>% filter(latitude > -80, latitude < -50) # limit latitude
  
  return(penguinData)
}

occurrenceMap <- function() {
  # max and min latitude
  max.lat <- ceiling(max(penguinData$latitude))
  min.lat <- floor(min(penguinData$latitude))
  
  # max and min longitude
  max.lon <- ceiling(max(penguinData$longitude))
  min.lon <- floor(min(penguinData$longitude))
  
  # save as jpg
  jpeg(file="output/penguinsZoomed.jpg")
  
  # load spatial polygons
  data(wrld_simpl)
  
  # plot base map
  plot(wrld_simpl, 
       xlim = c(min.lon, max.lon), # sets upper/lower x
       ylim = c(min.lat, max.lat), # sets upper/lower y
       axes = TRUE, 
       col = "grey95",
       main="Occurrence Map of Adelie, Chinstrap, and Gentoo Penguins",  # title
       sub="990 Occurrences", # caption
       xlab = "Longitude",
       ylab = "Latitude"
  )
  
  penguinData$name <- factor(penguinData$name)
  
  # add the points for individual observation
  points(x = penguinData$longitude, 
         y = penguinData$latitude, 
         col = c("#ff8400", "#be43cc", "#04838a"), 
         pch = 20, 
         cex = 0.75,
         lwd = 0.5)
  
  legend(x="bottomright", 
         legend=c("Gentoo", "Chinstrap", "Adelie"), 
         col=c("#04838a","#be43cc","#ff8400"), 
         pch=20, merge=FALSE )
  
  # draw a little box around the graph
  box()
  # stop mapping
  dev.off()
  # 
}