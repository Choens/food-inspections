## #############################################################################
## ANALYSIS
##
## Research Questions
## - Are the New York State Lottery Take-Five Numbers normally distributed?
##
## #############################################################################



## INIT ========================================================================
## With great power comes GREAT complexity.
## The order these are loaded in is important.
## The choroplethr package will over-write dplyr with plyr and break this
## everything, unless you carefull load dplyr AFTER choroplethr.
library(choroplethr)
library(choroplethrZip)
library(dplyr)
library(pander)



## DATA ========================================================================
load("data/inspections.Rda")



## INSPECTIONS ===================================================================
str(inspections)



## USEFUL ======================================================================

## We will discuss this command.
## - The %>% is a "pipe". It prevents us from having to make multiple temporary tables
##   when we need to do a multi-step transfortmation.
## - This similar to SQL. If you know SQL (or SAS PROC SQL), this should be familiar.
## - The command pander takes a data frame (and other objects) and makes a pretty
##   markdown compaditble table out of it.
##
## This calculates the number of inspections, the total number of violations,
## and the percentage of inspections with one or more violations.
##
## Note: I may never eat out again.
##
inspections_by_county <-
    inspections %>%
    group_by(county) %>%
    summarize(n_insp          = n(),
              tot_violations = sum(total_violations),
              avg_violations  = round(mean(total_violations),1),
              rate_violations  = round(100*sum(total_violations > 1) / n(),2)
              ) %>%
    arrange(desc(rate_violations))

pander(inspections_by_county)


## GIS =========================================================================
## Yes, it is possible to do GIS work with R!
## Today, a choroplethr map.
## This will only work if you were able to load the choroplether data package.

## Two intermediate steps.
## The gis_data is a simple join between the inspections data and the
## zip data.
data(zip.regions)
zip.regions <- filter(zip.regions, state.name == "new york")
gis_data <- inner_join(inspections,
                      zip.regions,
                      by=c("zip_5"="region", "county"="county.name"))


## We dupe a few rows, but I'm not going to fix that now.
nrow(gis_data)
nrow(inspections)

## The chor_data data frame is what actually gets mapped. The column names
## MUST be region and value. Nothing else is allowed.
chor_data <-
    gis_data %>%
    dplyr::group_by(region = zip_5) %>%
    dplyr::summarize( value = sum(total_violations, na.rm=TRUE) )

## This produces the actual map.
zip_choropleth(chor_data, 
               state_zoom = "new york",
               title = "Distribution of Food Inspection Violations",
               legend = "Violations")
