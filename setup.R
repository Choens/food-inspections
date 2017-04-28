## #############################################################################
## SETUP
##
## Installs packages needed for the food-inspections project.
##
## #############################################################################

packages <- c("devtools",
              "choroplethr",      
              "dplyr",
              "tidyr",
              "rmarkdown",
              "RSocrata")
install.packages(packages)

## This step will take a few minutes. We have to all download a big file or three.
library(devtools)
install_github('arilamstein/choroplethrZip@v1.5.0')
