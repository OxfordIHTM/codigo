#'
#' Search the foundation component of the ICD-11
#'
#' @param base_url The base URL of the API. Default uses the WHO API server at
#'   https://id.who.int/icd/entity
#' @param client The OAuth2 client produced through a call to `icd_oauth_client()`
#' @param q String. Text to be searched. Having the character `%` at the end will
#'   be regarded as a wild card for that word
#' @param flexisearch Logical. Default is FALSE. Changes the search mode to
#'   flexible search. In the regular search mode, the Coding Tool will only give
#'   you results that contain all of the words that you've used in your search.
#'   It accepts different variants or synonyms of the words but essentially it
#'   searches for a result that contains all components of your search. Whereas
#'   in flexible search mode, the results do not have to contain all of the words
#'   that are typed. It would still try to find the best matching phrase but
#'   there may be words in your search that are not matched at all. It is
#'   recommended to use flexible search only when regular search does not
#'   provide a result
#' @param flat Logical. Default is FALSE. If set to true the search result
#'   entities are provided in a nested data structure representing the
#'   ICD-11 hierarchy. Otherwise they are listed as flat list of matches
#' @param highlight Logical. Default is FALSE. If set to FALSE the search result
#'   highlighting is turned off and the results don't contain special tags for
#'   highlighting where the results are found within the text
#' @param api_version Version of the API. Possible values are `v1` or `v2`.
#'   For example, if you provide value v2, the API will respond in the format of
#'   the version 2 of the API. Default is `v2`
#' @param language ICD-API is multi-lingual. By changing this header, you may
#'   make the API respond in different languages. Languages will be available as
#'   the translations of ICD-11 completes. The values are language codes such as
#'   en, es, zh, etc. Depending on the `release_id` specified, the available
#'   languages will vary. Default is English ("en").
#'
#' @return An `httr2_response` object
#'
#' @examples
#' icd_search_foundation(q = "cholera")
#'
#' @export
#'

icd_search_foundation <- function(base_url = "https://id.who.int/icd",
                                  client = icd_oauth_client(),
                                  q = NULL,
                                  flexisearch = FALSE,
                                  flat = TRUE,
                                  highlight = FALSE,
                                  api_version = c("v2", "v1"),
                                  language = "en") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  httr2::request(file.path(base_url, "entity/search")) |>
    httr2::req_url_query(
      q = q,
      useFlexisearch = ifelse(flexisearch, "true", "false"),
      flatResults = ifelse(flat, "true", "false"),
      highlightingEnabled = ifelse(highlight, "true", "false")
    ) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = language
    ) |>
    httr2::req_oauth_client_credentials(
      client = client,
      scope = "icdapi_access"
    ) |>
    httr2::req_perform()
}


