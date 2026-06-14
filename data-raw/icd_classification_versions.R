# Retrieve supported classifications and versions by the API -------------------

page_url <- "https://icd.who.int/docs/icd-api/SupportedClassifications/"

icd_session <- rvest::session(page_url)

icd_versions <- icd_session |>
  rvest::read_html() |>
  rvest::html_elements(".section") |>
  rvest::html_table() |>
  dplyr::bind_rows() |>
  (\(x) x[c(1:9, 11:14), ])() |>
  dplyr::mutate(
    Classification = c(rep("ICD-11", 9), rep("ICD-10", 4)),
    Foundation2 = ifelse(Foundation2 == "✔", TRUE, NA),
    #mms = c(rep(TRUE, 9), rep(NA, 4)),
    #icf = c(rep(TRUE, 3), rep(FALSE, 6), rep(NA, 4)),
    mms_language = list(
      c("ar", "zh", "cs", "en", "fr", "de", "kk", "la", "pt", "ru", "sk", "es", "sv", "tr", "uz"),
      c("ar", "zh", "cs", "en", "fr", "kk", "la", "pt", "ru", "sk", "es", "sv", "tr", "uz"),
      c("ar", "zh", "cs", "en", "fr", "pt", "ru", "es", "tr", "uz"),
      c("ar", "zh", "en", "fr", "ru", "es", "tr"), c("ar", "zh", "en", "fr", "es"),
      c("ar", "zh", "en", "es"), c("ar", "en", "es"), "en", "en",
      NULL, NULL, NULL, NULL
    ),
    icf_language = list(
      c("hy", "zh", "cs", "en", "et", "fi", "fr", "it", "mn", "pt", "ru", "sk", "es", "tr", "uk"),
      c("zh", "cs", "en", "fr", "es", "tr"),
      c("cs", "en", "tr"),
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    ),
    x_language = list(
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
      "en", "en", "en", c("en", "fr")
    )
  ) |>
  dplyr::select(-`ICD-11 MMS`, -ICF) |>
  stats::setNames(
    nm = c(
      "release_id", "foundation", "classification",
      "mms", "icf", "x"
    )
  ) |>
  tidyr::pivot_longer(
    cols = c("mms", "icf", "x"),
    names_to = "linearization",
    values_to = "language"
  ) |>
  dplyr::mutate(
    foundation = ifelse(is.na(foundation), FALSE, foundation),
    linearization = ifelse(linearization == "x", NA_character_, linearization)
  ) |>
  dplyr::filter(
    classification == "ICD-11" & !is.na(linearization) |
      classification == "ICD-10" & is.na(linearization)
  )

usethis::use_data(icd_versions, overwrite = TRUE)
