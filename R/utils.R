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
#' @inheritParams codigo-params linearization
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

icd_get_releases <- function(icd = c("icd11", "icd10"),
                             linearization = c("mms", "icf"),
                             latest = FALSE) {
  ## Check and get value for icd ----
  if (!is.null(icd)) {
    icd <- match.arg(icd)
  } else {
    icd <- c("icd11", "icd10")
    latest <- FALSE
  }

  ## Get full ICD name ----
  icd <- ifelse(icd == "icd10", "ICD-10", "ICD-11")

  ## Check and get value for linearization ----
  ln <- match.arg(linearization)

  ## Get release identifiers for requested classification versions ----
  if ("ICD-10" %in% icd) {
    releases <- with(
      codigo::icd_versions,
      codigo::icd_versions[
        classification %in% icd, 
        c("classification", "release_id", "linearization")
      ]
    ) |>
      (\(x) x[x$linearization == ln | is.na(x$linearization), ])()
  } else {
    releases <- with(
      codigo::icd_versions,
      codigo::icd_versions[
        classification == icd & linearization == ln, 
        c("classification", "release_id", "linearization")
      ]
    )
  }

  ## Determine what to return ----
  if (latest) {
    releases[rev(order(releases$`release_id`)), ][1, 2]
  } else {
    releases
  }
}


#'
#' @rdname icd_utils
#' @export
#'

icd_get_languages <- function(icd = c("icd11", "icd10"),
                              linearization = c("mms", "icf"), 
                              latest = FALSE) {
  ## Get linearization value ----
  linearization <- match.arg(linearization)
  
  ## Check and get value for icd ----
  if (!is.null(icd)) {
    icd <- match.arg(icd)
  } else {
    icd <- c("icd11", "icd10")
    latest <- FALSE
  }

  ## Get full ICD name ----
  icd <- ifelse(icd == "icd10", "ICD-10", "ICD-11")

  ## Get languages for requested classification versions ----
  languages <- with(
    codigo::icd_versions,
    codigo::icd_versions[
      classification == icd & linearization == linearization, 
      c("classification", "release_id", "language", "linearization")
    ]
  )

  ## Determine what to return ----
  if (latest) {
    languages[rev(order(languages$release_id)), ] |>
      (\(x)
        {
          names(x$language) <- paste0(
            x$classification, " - Release ", x$`release_id`
          )
          x$language[1]
        }
      )()
  } else {
    languages |>
      (\(x)
       {
         names(x$language) <- paste0(
           x$classification, " - Release ", x$release_id, " - ", x$linearization 
         )
         x$language
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


#'
#' Implement internal request policies for timeout and retry
#' 
#' @param req An httr2 request object.
#' @param timeout Timeout in seconds. Default is 30 seconds.
#' @param max_tries Maximum number of retry attempts. Default is 5.
#' 
#' @returns A httr2 request object with timeout and retry features.
#' 
#' @keywords internal
#' @noRd
#' 

icd_req_policies <- function(req, timeout = 30, max_tries = 5) {
  req |>
    httr2::req_timeout(seconds = timeout) |>
    httr2::req_retry(
      max_tries = max_tries,
      retry_on_failure = TRUE,
      is_transient = \(resp) httr2::resp_status(resp) %in% c(429, 500, 503)
    )
}