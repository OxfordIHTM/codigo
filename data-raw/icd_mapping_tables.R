# Download and process ICD-10 to ICD-11 mapping tables -------------------------

## Load libraries ----
library(openxlsx2)
library(stringr)


## Download mapping tables ----

download.file(
  url = "https://icdcdn.who.int/static/releasefiles/2024-01/mapping.zip",
  destfile = "data-raw/icd-mapping.zip"
)

unzip(
  zipfile = "data-raw/icd-mapping.zip",
  overwrite = TRUE,
  exdir = "data-raw/icd-mapping"
)
