#'
#' Structure ICD list and ICD search outputs
#'
#' @param icd_list An object produced by a call to any of the `icd_get`
#'   functions
#' @param icd_search An object produced by a call to any of the `icd_search`
#'   functions
#' @param icd_autocode An object produced by a call to any of the `icd_autocode`
#'   functions
#'
#' @return A tibble of structured ICD outputs.
#'
#' @details These functions are meant to be helper functions and are used
#'   within the `icd_get`, `icd_search`, and `icd_autocode` functions to
#'   structure the output responses.
#'
#' @examples
#' \donttest{
#'   icd_list <- icd_get_foundation(tabular = FALSE)
#'   icd_tbl_foundation <- icd_structure_foundation(icd_list)
#'   icd_structure_search(icd_search_foundation("cholera", tabular = FALSE))
#'   icd_structure_autocode(icd_autocode_foundation("cholera"))
#' }
#'
#' @rdname icd_structure
#' @export
#'
icd_structure_foundation <- function(icd_list) {
  tibble::tibble("entity" = list(icd_list)) |>
    tidyr::unnest_wider(col = .data$entity) |>
    tidyr::unnest_wider(col = .data$title, names_sep = "_")
}

#'
#' @rdname icd_structure
#' @export
#'

icd_structure_search <- function(icd_search) {
  search_results <- tibble::tibble("entity" = list(icd_search)) |>
    tidyr::unnest_wider(col = .data$entity) |>
    tidyr::unnest_longer(col = .data$destinationEntities)

  if (nrow(search_results) == 1 && is.na(search_results$destinationEntities[1])) {
    search_results
  } else {
    search_results <- search_results |>
      tidyr::unnest_wider(col = .data$destinationEntities)
  }

  ## Return search results
  search_results
}


#'
#' @rdname icd_structure
#' @export
#'
icd_structure_autocode <- function(icd_autocode) {
  dplyr::bind_cols(icd_autocode)
}
