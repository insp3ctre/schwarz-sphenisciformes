# INSTRUCTIONS #
# 1. Run the initial setup files
# 2. Query the data
# 3. Produce graphs:
#   a. create an occurrence map
#   b. create a species distribution map
#   c. create a species forecast model

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
