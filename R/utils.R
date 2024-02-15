#'
#' Utility functions for retrieving ICD parameters and definitions
#'
#' @param icd A character string of available ICD classifications. Currently,
#'   this can be either "icd10" or "icd11". Default is "icd11". If NULL, all ICD
#'   classifications are used (currently both "icd10" and "icd11").
#' @param latest Logical. If TRUE, identifier for latest release is returned.
#'   Default is FALSE.
#' @param class A character string of code classes to retrieve. This can be
#'   either "chapter", "block", or "category". If NULL (default), all
#'   classes are retrieved.
#'
#' @return A tibble for ICD classification values and their corresponding
#'   release identifiers (for `icd_get_releases()`). A names list of
#'   corresponding languages (for `icd_get_languages()`). A tibble of
#'   entities with their definitions/titles and classes
#'   (for `icd_get_entitties()`).
#'
#' @examples
#' icd_get_releases()
#' icd_get_languages()
#' icd_get_entities()
#'
#' @rdname icd_utils
#' @export
#'

icd_get_releases <- function(icd = c("icd11", "icd10"), latest = FALSE) {
  ## Check and get value for icd ----
  if (!is.null(icd)) {
    icd <- match.arg(icd)
  } else {
    icd <- c("icd11", "icd10")
    latest <- NULL
  }

  ## Get full ICD name ----
  icd <- ifelse(icd == "icd10", "ICD-10", "ICD-11")

  ## Get release identifiers for requested classification versions ----
  releases <- codigo::icd_versions[codigo::icd_versions$Classification %in% icd, ] |>
    subset(select = c("Classification", "Release ID"))

  ## Determine what to return ----
  if (latest) {
    releases[rev(order(releases$`Release ID`)), ][1, 2]
  } else {
    releases
  }
}


#'
#' @rdname icd_utils
#' @export
#'

icd_get_languages <- function(icd = c("icd11", "icd10"), latest = FALSE) {
  ## Check and get value for icd ----
  if (!is.null(icd)) {
    icd <- match.arg(icd)
  } else {
    icd <- c("icd11", "icd10")
    latest <- NULL
  }

  ## Get full ICD name ----
  icd <- ifelse(icd == "icd10", "ICD-10", "ICD-11")

  ## Get languages for requested classification versions ----
  languages <- codigo::icd_versions[codigo::icd_versions$Classification %in% icd, ] |>
    subset(select = c("Classification", "Release ID", "Languages"))

  ## Determine what to return ----
  if (latest) {
    languages[rev(order(languages$`Release ID`)), ] |>
      (\(x)
        {
          names(x$Languages) <- paste0(
            x$Classification, " - Release ", x$`Release ID`
          )
          x$Languages[1]
        }
      )()
  } else {
    languages |>
      (\(x)
       {
         names(x$Languages) <- paste0(
           x$Classification, " - Release ", x$`Release ID`
         )
         x$Languages
      }
      )()
  }
}

#'
#' @rdname icd_utils
#' @export
#'


icd_get_entities <- function(class = NULL) {
  entity_df <- with(
    codigo::icd11_simple_table_mms,
    tibble::tibble(
      entity_foundation = basename(`Foundation URI`),
      entity_mms = basename(`Linearization URI`),
      code = Code,
      title = Title,
      class = ClassKind
    )
  )

  if (!is.null(class)) entity_df |> (\(x) x[x$class %in% class, ])()
  else entity_df
}
