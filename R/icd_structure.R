#'
#' Structure ICD list outputs
#'
#' @param icd_list An `icd_list` object produced by a call to any of the `icd_get`
#'   functions
#'
#' @return An object of class `icd_tbl` which is basically a `data.frame` format
#'   of ICD outputs
#'
#' @examples
#' icd_list <- icd_get_foundation()
#' icd_tbl_foundation <- icd_structure_foundation(icd_list)
#'
#' @rdname icd_structure
#' @export
#'
icd_structure_foundation <- function(icd_list) {
  ## Structure title ----
  icd_list$title <- do.call(cbind, icd_list$title) |> data.frame()

  ## Structure availableLanguages ----
  icd_list$availableLanguages <- unlist(icd_list$availableLanguages) |>
    paste(collapse = ", ")

  ## Structure child ----
  icd_list$child <- unlist(icd_list$child) |> list()

  ## Bind columns and rename columns ----
  icd_tbl <- do.call(cbind, icd_list)
  names(icd_tbl)[3] <- "title@language"
  names(icd_tbl)[4] <- "title@value"
  names(icd_tbl)[8] <- "child"

  ## Create `icd_tbl` class object ----
  class(icd_tbl) <- "icd_tbl"

  icd_tbl
}
