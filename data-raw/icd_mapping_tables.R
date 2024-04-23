# Download and process ICD-10 to ICD-11 mapping tables -------------------------

## Load libraries ----
library(openxlsx2)
library(readxl)
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

## ICD 10 map to many ICD 11 ----

ten_map_to_multiple_eleven <- readxl::read_excel(
  path = "data-raw/icd-mapping/10To11MapToMultipleCategories.xlsx", sheet = 1
) |>
  dplyr::select(!last_col())

names(ten_map_to_multiple_eleven) <- c(
  "icd10_class_kind", "icd10_depth", "icd10_code", "icd10_chapter", "icd10_title",
  "icd11_class_kind", "icd11_depth", "icd11_foundation_uri", "icd11_linearization_uri",
  "icd11_code", "icd11_chapter", "icd11_title"
)

usethis::use_data(ten_map_to_multiple_eleven, overwrite = TRUE, compress = "xz")

## ICD 10 map to one ICD 11 ----

ten_map_to_one_eleven <- readxl::read_excel(
  path = "data-raw/icd-mapping/10To11MapToOneCategory.xlsx", sheet = 1
) |>
  dplyr::select(!last_col())

names(ten_map_to_one_eleven) <- c(
  "icd10_class_kind", "icd10_depth", "icd10_code", "icd10_chapter", "icd10_title",
  "icd11_class_kind", "icd11_depth", "icd11_foundation_uri", "icd11_linearization_uri",
  "icd11_code", "icd11_chapter", "icd11_title"
)

usethis::use_data(ten_map_to_one_eleven, overwrite = TRUE, compress = "xz")

## ICD 11 map to one ICD 10 ----

eleven_map_to_one_ten <- readxl::read_excel(
  path = "data-raw/icd-mapping/11To10MapToOneCategory.xlsx", sheet = 1
) |>
  dplyr::select(!last_col())

names(eleven_map_to_one_ten) <- c(
  "icd11_linearization_uri", "icd11_code", "icd11_chapter", "icd11_title",
  "icd10_code", "icd10_chapter", "icd10_title"
)

usethis::use_data(eleven_map_to_one_ten, overwrite = TRUE, compress = "xz")
