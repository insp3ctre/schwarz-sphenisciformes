install.packages("spocc")
install.packages("maptools") 
install.packages("tidyverse")

library("spocc")
library("maptools") 
library("tidyverse")

# max and min latitude
max.lat <- ceiling(max(penguinData$latitude))
min.lat <- floor(min(penguinData$latitude))

# max and min longitude
max.lon <- ceiling(max(penguinData$longitude))
min.lon <- floor(min(penguinData$longitude))

# save as jpg
jpeg(file="output/penguins.jpg")

# load spatial polygons
data(wrld_simpl)

# plot base map
plot(wrld_simpl, 
     xlim = c(min.lon, max.lon), # sets upper/lower x
     ylim = c(min.lat, max.lat), # sets upper/lower y
     axes = TRUE, 
     col = "grey95",
     main="Penguins",  # title
     sub="Penguins" # caption
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