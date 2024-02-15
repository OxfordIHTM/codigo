#'
#' Structure ICD list and ICD search outputs
#'
#' @param icd_list An `icd_list` object produced by a call to any of the
#'   `icd_get` functions
#' @param icd_search An `icd_search` object produced by a call to any of the
#'    `icd_search` functions
#'
#' @return A tibble of structured ICD outputs.
#'
#' @examples
#' icd_list <- icd_get_foundation()
#' icd_tbl_foundation <- icd_structure_foundation(icd_list)
#' icd_structure_search(icd_search_foundation("cholera", structure = FALSE))
#'
#' @rdname icd_structure
#' @export
#'
icd_structure_foundation <- function(icd_list) {
  ## Structure title ----
  icd_list$title <- dplyr::bind_cols(icd_list$title)

  ## Structure availableLanguages ----
  icd_list$availableLanguages <- unlist(icd_list$availableLanguages) |>
    paste(collapse = ", ")

  ## Structure child ----
  icd_list$child <- unlist(icd_list$child) |> list()

  ## Bind columns and rename columns ----
  icd_tbl <- dplyr::bind_cols(icd_list)
  names(icd_tbl)[3] <- "title@language"
  names(icd_tbl)[4] <- "title@value"
  names(icd_tbl)[8] <- "child"

  ## Return output ----
  icd_tbl
}

#'
#' @rdname icd_structure
#' @export
#'

icd_structure_search <- function(icd_search) {
  ## Process search metadata ----
  meta <- lapply(
    X = icd_search[1:7],
    FUN = function(x) ifelse(is.null(x), NA, x)
  ) |>
    dplyr::bind_cols()

  ## Standardise classes of metadata fields ----
  meta <- within(
    meta,
    {
      error <- ifelse(is.logical(error), error, as.logical(error))
      errorMessage <- ifelse(
        is.character(errorMessage), errorMessage, as.character(errorMessage)
      )
      resultChopped <- ifelse(
        is.logical(resultChopped), resultChopped, as.logical(resultChopped)
      )
      wordSuggestionsChopped <- ifelse(
        is.logical(wordSuggestionsChopped),
        wordSuggestionsChopped,
        as.logical(wordSuggestionsChopped)
      )
      guessType <- ifelse(is.integer(guessType), guessType, as.integer(guessType))
      uniqueSearchId <- ifelse(
        is.character(uniqueSearchId), uniqueSearchId, as.character(uniqueSearchId)
      )
      words <- ifelse(is.character(words), words, as.character(words))
    }
  )

  ## Process search results ----
  search_results <- lapply(
    X = icd_search$destinationEntities,
    FUN = function(x) do.call(cbind, x) |>
      data.frame() |>
      tidyr::unnest(cols = dplyr::everything())
  ) |>
    dplyr::bind_rows()

  ## Set attributes for search metadata ----
  attributes(search_results)$metadata <- meta

  ## Return search results
  search_results
}
