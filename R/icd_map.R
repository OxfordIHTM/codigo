#'
#' Map ICD codes between versions
#'
#' @param from The ICD version to map from. Either *icd10* or *icd11*.
#'   Default to *icd10*.
#' @param to A character value of either *multiple* or *one* to map ICD-10
#'   to ICD-11 accordingly. Only relevant if `from` is *icd10*. Ignored when
#'   `from` is *icd11*. Default to *one*.
#' @param code Corresponding ICD code in version specified in `from` to map
#'   to the other version.
#'
#' @returns A tibble of information for specified `code` mapped based on
#'   `from`
#'
#' @examples
#' icd_map(code = "A00")
#'
#' @rdname icd_map
#' @export
#'

icd_map <- function(from = c("icd10", "icd11"), to = c("one", "multiple"),
                    code) {
  from <- match.arg(from)

  if (from == "icd10") {
    dat <- paste0("ten_map_to_", to, "_eleven")
    query <- paste0("icd10_code %in% '", code, "'")
  } else {
    dat <- "eleven_map_to_one_ten"
    query <- paste0("icd11_code %in% '", code, "'")
  }

  df <- eval(parse(text = dat)) |>
    dplyr::filter(eval(parse(text = query)))

  df
}
