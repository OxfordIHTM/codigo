# Retrieve supported classifications and versions by the API -------------------

page_url <- "https://icd.who.int/docs/icd-api/SupportedClassifications/"

icd_session <- rvest::session(page_url)

icd_versions <- icd_session |>
  rvest::read_html() |>
  rvest::html_elements(".section") |>
  rvest::html_table() |>
  dplyr::bind_rows() |>
  (\(x) x[c(1:7, 9:12), ])() |>
  dplyr::mutate(
    Classification = c(rep("ICD-11", 7), rep("ICD-10", 4)),
    Foundation = c(rep(TRUE, 7), rep(NA, 4)),
    MMS = c(rep(TRUE, 7), rep(NA, 4)),
    ICF = c(TRUE, rep(FALSE, 6), rep(NA, 4)),
    Languages = ifelse(Classification == "ICD-10", `ICD-11 MMS`, `Available Languages 2`) |>
      stringr::str_split(pattern = ", ")
  ) |>
  dplyr::rename(`Release ID` = `Release Id 1`) |>
  dplyr::select(`Classification`, `Release ID`, Foundation, MMS, ICF, Languages)

usethis::use_data(icd_versions, overwrite = TRUE)
