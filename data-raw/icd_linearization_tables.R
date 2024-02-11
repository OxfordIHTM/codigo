# Download and process ICD-11 linearizations -----------------------------------

## Load libraries ----
library(openxlsx2)
library(stringr)


## Download data ----

### Linearization MMS from ICD-11 download page ----
### https://icd.who.int/dev11/downloads

download_url <- "https://icd.who.int/dev11/Downloads/Download?fileName=LinearizationMiniOutput-MMS-en.zip"

download.file(
  url = download_url,
  destfile = "data-raw/linear-mms.zip"
)

unzip(
  zipfile = "data-raw/linear-mms.zip",
  overwrite = TRUE,
  exdir = "data-raw/linear-mms"
)

icd11_linearization_mms <- read_xlsx(
  file = "data-raw/linear-mms/LinearizationMiniOutput-MMS-en.xlsx",
  sheet = 1, data_only = TRUE
)

header_values <- names(icd11_linearization_mms)[ncol(icd11_linearization_mms)] |>
  stringr::str_split(pattern = ":", simplify = TRUE)

names(icd11_linearization_mms)[ncol(icd11_linearization_mms)] <- header_values |>
  (\(x) x[1])()

icd11_linearization_mms$Version <- header_values |>
  (\(x) x[2:3])() |>
  paste(collapse = ":")

icd11_linearization_mms <- icd11_linearization_mms |>
  tibble::tibble()

usethis::use_data(icd11_linearization_mms, overwrite = TRUE, compress = "xz")

### Simple Table MMS ----

download_url <- "https://icdcdn.who.int/static/releasefiles/2024-01/SimpleTabulation-ICD-11-MMS-en.zip"

download.file(
  url = download_url,
  destfile = "data-raw/simple-tab-icd11-mms.zip"
)

unzip(
  zipfile = "data-raw/simple-tab-icd11-mms.zip",
  overwrite = TRUE,
  exdir = "data-raw/simple-tab-icd11-mms"
)

icd11_simple_table_mms <- read_xlsx(
  file = "data-raw/simple-tab-icd11-mms/SimpleTabulation-ICD-11-MMS-en.xlsx",
  sheet = 1, data_only = TRUE
)

icd11_simple_table_mms |>
  tibble::tibble()

usethis::use_data(icd11_simple_table_mms, overwrite = TRUE, compress = "xz")
