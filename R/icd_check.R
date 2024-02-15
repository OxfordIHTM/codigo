#'
#' Checks for specified parameters supplied to search, autocode, and get
#' functions
#'
#' @param release A string specifying the release version of the ICD-11.
#' @param language language codes such as en, es, zh, etc.
#'
#' @return A message or an error if `release` provided is recognised or not. A
#'   message or a warning if `language` requested is available or not for
#'   `release` provided.
#'
#' @examples
#' icd_check_release("2024-01")
#' try(icd_check_release("2025-01"))
#' icd_check_language("2024-01", "ar")
#' icd_check_language("2024-01", "rr")
#' try(icd_check_language("2025-01", "ar"))
#'
#' @rdname icd_check
#' @export
#'
icd_check_release <- function(release) {
  release_check <- release %in% codigo::icd_versions$`Release ID`

  icd_set <- with(codigo::icd_versions, Classification[`Release ID` == release])

  if (release_check) {
    message(
      paste0(
        "Release identifier provided matches a known release for ",
        icd_set, "."
      )
    )
  } else {
    stop(
      "Release identifier provided does not match any known release for ICD-11
       or ICD-10. Please verify and check with `icd_versions` and try again."
    )
  }
}


#'
#' @rdname icd_check
#' @export
#'
icd_check_language <- function(release = NULL, language) {
  ## Check if release is NULL ----
  if (is.null(release)) release <- codigo::icd_versions$`Release ID`[1]

  ## Check whether release is specified correctly ----
  icd_check_release(release)

  ## Get languages available for release provided ----
  languages_available <- with(
    codigo::icd_versions, Languages[`Release ID` == release]
  )

  if (length(language) == 1) {
    if (language %in% languages_available) {
      message(
        paste0("`", language, "` is available for the release specified.")
      )
    } else {
      warning(
        paste0("`", language, "` is not available for the release specified.
                Returning results for `en` (default).")
      )
    }
  }

  if (length(language) > 1) {
    if (any(language %in% languages_available)) {

      language_result <- language[language %in% languages_available]

      message(
        paste0("The following languages requested are available for the release
                specified: ", language_result, ".")
      )
    } else {
      warning(
        paste0("None of the languages requested are available for the release
                specified. Returning results for `en` (default).")
      )
    }
  }
}
