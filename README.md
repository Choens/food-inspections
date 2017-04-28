# README

New York State, like other states, regularly inspects establishments
which serve food to the public. This is the most recent collection of
Food Service Establishment Inspections.

## Research Questions:

- Which county has the most violations?
- Which county has the highest violation rate?
- Include an Appendix with all Violations, aggregated by county.

## How to run this project:

The following instructions assume you have previously installed R. If
you haven't, you may install R from the website here:
https://cran.r-project.org/

- Download the zip file containing the code: TODO
- Run [setup.R](setup.R) to make sure your computer has all the necessary
  packages installed.
- Acquire an APP TOKEN from New York State Open Data:
  https://data.ny.gov/profile/app_tokens
- Open [data-raw/inspections.R](data-raw/inspections.R).
    - In the `GET DATA` section, find the `read.socrata` function.
    - Replace `YOURAPPTOKENHERE` with your actual app token.
- Running [data-raw/inspections.R](data-raw/inspections.R) creates a data
  frame called inspections which is stored in the [data](data) folder.
- The R scripts in this folder all use this data frame. After creating
  inspections.Rda in [data](data), the R scripts in this folder may be
  run in any order.
- The report, report.Rmd is also based on this local data set.

## Data:

The data frame inspections is downloaded from Open Data New York via the
RSocrata package. To run this code, you must have an active APP TOKEN
from the State of New York. To see more about the Food Service
Inspections data:
https://dev.socrata.com/foundry/health.data.ny.gov/f285-x9ha

## Additional Links

- To learn more about Socrata: https://socrata.com/
- To learn more about using the Socrata API:
  https://dev.socrata.com/foundry/health.data.ny.gov/f285-x9ha
- To learn more about the RSocrata package:
  https://cran.r-project.org/web/packages/RSocrata/index.html
- To see the RSocrata source code: https://github.com/Chicago/RSocrata
