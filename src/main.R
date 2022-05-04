# initial setup
source("src/setup.R")
source("src/functions.R")

# query data
penguinData <- query()

# occurrence map
occurrenceMap()

# species distribution map
source("src/penguins-sdm-single.R")

# species forecast model
source("src/future-sdm-single.R")
