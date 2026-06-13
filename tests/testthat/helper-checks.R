skip_if_no_icd_api <- function() {
  testthat::skip_on_cran()
  testthat::skip_if_offline("id.who.int")
}