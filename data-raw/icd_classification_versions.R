# Retrieve supported classifications and versions by the API -------------------

page_url <- "https://icd.who.int/docs/icd-api/SupportedClassifications/"

icd_session <- rvest::session(page_url)

icd_versions <- icd_session |>
  rvest::read_html() |>
  rvest::html_elements(".section") |>
  rvest::html_table() |>
  dplyr::bind_rows() |>
  (\(x) x[1:9, ])() |>
  stats::setNames(nm = c("release_id", "foundation", "mms", "icf"))

usethis::use_data(icd_versions, overwrite = TRUE)
