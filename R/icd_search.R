#'
#' Search the foundation component of the ICD-11
#'
#' @param q String. Text to be searched. Having the character `%` at the end will
#'   be regarded as a wild card for that word.
#' @param subtree A string or vector of strings of URIs. If provided, the
#'   search will be performed on the entities provided and their descendants.
#' @param chapter A string or vector of strings of chapter codes
#'   eg: c("01", "02") When provided, the search will be performed only on
#'   these chapters.
#' @param flexisearch Logical. Default is FALSE. Changes the search mode to
#'   flexible search. In the regular search mode, the Coding Tool will only give
#'   you results that contain all of the words that you've used in your search.
#'   It accepts different variants or synonyms of the words but essentially it
#'   searches for a result that contains all components of your search. Whereas
#'   in flexible search mode, the results do not have to contain all of the words
#'   that are typed. It would still try to find the best matching phrase but
#'   there may be words in your search that are not matched at all. It is
#'   recommended to use flexible search only when regular search does not
#'   provide a result.
#' @param flat Logical. Default is FALSE. If set to true the search result
#'   entities are provided in a nested data structure representing the
#'   ICD-11 hierarchy. Otherwise they are listed as flat list of matches.
#' @param properties A string or a vector of strings for the properties to be
#'   searched. By default the system  searches, *"Title"*, *"Synonyms"*, and
#'   *"FullySpecifiedName"*. The valid values that could be used are: *Title"*,
#'   *"Synonym"*, *"NarrowerTerm"*, *"FullySpecifiedName"*, *"Definition"*, and
#'   *"Exclusion"*.
#' @param release A string specifying the release version of the Foundation to
#'   search from. If not specified, defaults to the latest release version. See
#'   the available versions with `icd_versions`.
#' @param highlight Logical. Default is FALSE. If set to FALSE the search result
#'   highlighting is turned off and the results don't contain special tags for
#'   highlighting where the results are found within the text.
#' @param api_version Version of the API. Possible values are `v1` or `v2`.
#'   For example, if you provide value v2, the API will respond in the format of
#'   the version 2 of the API. Default is `v2`.
#' @param language ICD-API is multi-lingual. By changing this header, you may
#'   make the API respond in different languages. Languages will be available as
#'   the translations of ICD-11 completes. The values are language codes such as
#'   en, es, zh, etc. Depending on the `release_id` specified, the available
#'   languages will vary. Default is English ("en").
#' @param structure Logical. Should output be structured into a tibble? Default
#'   to TRUE.
#' @param base_url The base URL of the API. Default uses the WHO API server at
#'   https://id.who.int. If you are using a locally deployed server or hosting
#'   your own ICD API server, you should specify the URL of your instance here.
#' @param client The OAuth2 client produced through a call to `icd_oauth_client()`.
#' @param scope Scopes to be requested from the resource owner. Default is
#'   *"icdapi_access"* as specified in the ICD API documentation.
#'
#' @return A tibble of search results.
#'
#' @examples
#' icd_search_foundation("colorectal cancer")
#'
#' @rdname icd_search
#' @export
#'

icd_search_foundation <- function(q,
                                  subtree = NULL,
                                  chapter = NULL,
                                  flexisearch = FALSE,
                                  flat = TRUE,
                                  properties = NULL,
                                  release = NULL,
                                  highlight = FALSE,
                                  api_version = c("v2", "v1"),
                                  language = "en",
                                  structure = TRUE,
                                  base_url = "https://id.who.int",
                                  client = icd_oauth_client(),
                                  scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release)) icd_check_release(release)

  ## Check language ----
  if (!is.null(language)) icd_check_language(release, language)

  ## Make base request ----
  req <- httr2::request(file.path(base_url, "icd/entity/search")) |>
    httr2::req_url_query(q = q)

  ## Add query components ----

  ### Subtrees filter ----
  if (!is.null(subtree)) {
    req <- req |>
      httr2::req_url_query(subtreesFilter = paste(subtree, collapse = ","))
  }

  ### Chapters filter ----
  if (!is.null(chapter)) {
    req <- req |>
      httr2::req_url_query(chapterFilter = paste(chapter, collapse = ","))
  }

  ### Flexi search and flatResults component ----
  req <- req |>
    httr2::req_url_query(
      useFlexisearch = ifelse(flexisearch, "true", "false"),
      flatResults = ifelse(flat, "true", "false")
    )

  ### Properties ----
  if (!is.null(properties)) {
    req <- req |>
      httr2::req_url_query(
        propertiesToBeSearched = paste(properties, collapse = ",")
      )
  }

  ### Release ID ----
  if (!is.null(release)) {
    req <- req |>
      httr2::req_url_query(releaseId = release)
  }

  ### Highlighting ----
  req <- req |>
    httr2::req_url_query(
      highlightingEnabled = ifelse(highlight, "true", "false")
    )

  ## Add headers, authenticate, and perform request ----
  resp <- req |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = language
    ) |>
    icd_authenticate(client = client, scope = scope) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  ## Determine what output to return ----
  if (structure) {
    icd_structure_search(resp)
  } else {
    resp
  }
}


