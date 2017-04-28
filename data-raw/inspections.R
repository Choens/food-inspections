## =============================================================================
## INSPECTIONS
##
## - Most recent NYS Food Safety Inspections.
## - Does not include NYS, Suffolk County, or Erie County.
##
## =============================================================================


## INIT ========================================================================
library(dplyr)
library(pander)
library(RSocrata)
library(tidyr)

## GET DATA ====================================================================
## To learn more about using th Socrata API with this data set:
## https://dev.socrata.com/foundry/health.data.ny.gov/f285-x9ha
## This takes a second or two to download. R may appear to freeze. Just wait.
inspections <- read.socrata("https://health.data.ny.gov/resource/f285-x9ha.json?$$app_token=YOU_APP_TOKEN")



## DATA MUNGING ================================================================

## These need to be numeric columns.
inspections$total_crit_not_corrected <- as.numeric(inspections$total_crit_not_corrected)
inspections$total_critical_violations <- as.numeric(inspections$total_critical_violations)
inspections$total_noncritical_violations <- as.numeric(inspections$total_noncritical_violations)
inspections$total_violations <- inspections$total_critical_violations + inspections$total_noncritical_violations

## When we do the mapping, it will be easier if these are all lower case.
inspections$county <- tolower(inspections$county)

## The data has the FULL zip (10 digit). We only need the first six today.
inspections$zip_5 <- substr(inspections$zip_code, 1, 5)

## This adds the date run to the data. Nice to know when data was created.
inspections$data_date <- Sys.Date()


## REVIEW DATA ==================================================================
## Again, some more feedback for the analyst.
if ( interactive() ){
    str(inspections)
}



## SAVE ========================================================================
save(inspections, file="data/inspections.Rda")
message("Inspections data downloaded and saved.")
