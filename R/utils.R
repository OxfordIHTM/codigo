#'
#' Utility functions for retrieving ICD parameters and definitions
#'
#' @param icd A character string of available ICD classifications. Currently,
#'   this can be either "icd10" or "icd11". Default is "icd11". If NULL, all ICD
#'   classifications are used (currently both "icd10" and "icd11").
#'
#' @return A tibble for ICD classification values and their corresponding
#'   release identifiers
#'
#' @examples
#' icd_get_releases()
#'
#' @rdname icd_utils
#' @export
#'

icd_get_releases <- function(icd = c("icd11", "icd10")) {
  ## Check and get value for icd ----
  if (!is.null(icd)) {
    icd <- match.arg(icd)
  } else {
    icd <- c("icd11", "icd10")
  }

  ## Get full ICD name ----
  icd <- ifelse(icd == "icd10", "ICD-10", "ICD-11")

  ## Get release identifiers for requested classification versions ----
  codigo::icd_versions[codigo::icd_versions$Classification %in% icd, ] |>
    subset(select = c("Classification", "Release ID"))
}
