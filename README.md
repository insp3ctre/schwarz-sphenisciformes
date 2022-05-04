# Schwarz Sphenisciformes

## Structure

-   #### data: directory containing necessary data
    -   cmip5: forecast climate data from [WorldClim](http://www.worldclim.org) (*not in version control*)
    -   penguins.csv: data harvested from [GBIF](https://www.gbif.org/) for Adélie, Chinstrap, and Gentoo penguins
    -   wc2-5: climate data from [WorldClim](http://www.worldclim.org) (*not in version control*)
-   #### output: directory containing image outputs
    - occurrenceMap.jpg: occurrence map
    - penguins-single-future-prediction.pdf: SDF with both current and future data
    - penguins-single-prediction.pdf: SDF with both current and future data
    - occurrence_map.jpg: occurrence map 
    - sdf.jpg: screenshot of SDF for report
    - sdm.jpg: screenshot of SDM for report
-   #### src: directory containing R scripts for gathering occurrence data, running forecast models, and creating map outputs.
    -   functions.R: contains commonly used functions
    -   future-sdm-single.R: create an SDF
    -   main.R: creates an occurrence map, SDM, and SDF
    -   penguins-sdm-single.R: create an SDM
    -   schwarz-proposal.R: original proposal for project
    -   sdm-functions.R: required functions for creating SDMs
    -   setup.R: load packages and run setup for creating SDMs and SDFs


## Running the Code

1.  Copy the URL to this Github repository by clicking on the green "Code" button above 
2.  Clone the repository by opening a "New Project from Git Repository" in RStudio or [rstudio.cloud](rstudio.cloud) and pasting the URL

3.  Open main.R
4.  Run the following lines in order to run the necessary setup

-   `source("src/setup.R")`
-   `source("src/functions.R")`

3.  Run the following line in order to query and clean the data

-   `penguinData <- query()`

4.  To create an occurrence map, run `occurrenceMap()`
5.  To create either an SDM, run:
-   `source("src/penguins-sdm-single.R")`
-   `source("src/future-sdm-single.R")`
