#'
#' Search the foundation component of the ICD-11
#'
#' @section On `flexisearch`: In the regular search mode (`flexisearch = FALSE`),
#'   the function will only give you results that contain all of the words that
#'   you've used in your search. It accepts different variants or synonyms of
#'   the words but essentially it searches for a result that contains all
#'   components of your search. Whereas in flexible search mode, the results do
#'   not have to contain all of the words that are typed. It would still try to
#'   find the best matching phrase but there may be words in your search that
#'   are not matched at all. It is recommended to use flexible search only when
#'   regular search does not provide a result.
#'
#' @section On `keyword`: If set to true, the search result will also include
#'   keyword list. If the last word provided is incomplete, keyword list
#'   includes all words that start with the incomplete word
#'   (word completion mode). If the last word is complete, the keyword list
#'   will provide suggested additional words that could be added to the search
#'   query (word suggestion mode).
#'
#' @section On `medical_mode`: When searching the classification for
#'   medical coding purposes, this should be set to TRUE (default). In this
#'   mode, the search gives results only from the entities that have a code.
#'   The system will search all index terms of an entity. i.e. *titles*,
#'   *synonyms*, *fully specified term*, all terms of other entities that are in
#'   the foundation are aggregated into this entity. By default, *chapters 26*,
#'   *V*, and *X* are not included in the search results. If `medical_mode` is
#'   set to FALSE, then the `properties` argument will need to be specified
#'   (see next section).
#'
#' @section On `properties`: In the Foundation search, by default the function
#'   searches  *"Title"*, *"Synonyms"*, and *"FullySpecifiedName"*. The valid
#'   values that could be used for properties are: *"Title"*, *"Synonym"*,
#'   *"NarrowerTerm"*, *"FullySpecifiedName"*, *"Definition"*, and
#'   *"Exclusion"*. In the MMS search, this argument is only used when
#'   `medical_mode = FALSE`. The valid values that could be used are:
#'   *"Title"*, *"FullySpecifiedName"*, *"Definition"*, *"Exclusion"*, and
#'   *"IndexTerm"*. If *"IndexTerm"* is used, the search will be performed on
#'   all *"Titles"*, *"Synonyms"*, and *"FullySpecifiedNames"* including the
#'   ones that are under shoreline (i.e Entities in the foundation but not in
#'   MMS). In such cases the results will be shown based on where the match is
#'   aggregated into in MMS.
#'
#' @section On `language`: ICD-API is multi-lingual. By setting the language,
#'   you may make the API respond in different languages. Languages will be
#'   available as the translations of ICD-11 completes. The values are language
#'   codes such as en, es, zh, etc. Depending on the `release` specified, the
#'   available languages will vary.
#'
#' @param q String. Text to be searched. Having the character `%` at the end will
#'   be regarded as a wild card for that word.
#' @param linearization A character value for which linearization to search.
#'   Currently, the only possible value for this is *"mms"*. See section on
#'   `linearization` for more details.
#' @param subtree A string or vector of strings of URIs. If provided, the
#'   search will be performed on the entities provided and their descendants.
#' @param use_foundation Logical. Default is FALSE. Should subtree filter
#'   use foundation descendants (TRUE) or linearization descendants (FALSE)?
#' @param chapter A string or vector of strings of chapter codes
#'   eg: c("01", "02") When provided, the search will be performed only on
#'   these chapters.
#' @param flexisearch Logical. Default is FALSE. Changes the search mode to
#'   flexible search (for more details, see section on flexisearch).
#' @param flat Logical. Default is FALSE. If set to true the search result
#'   entities are provided in a nested data structure representing the
#'   ICD-11 hierarchy. Otherwise they are listed as flat list of matches.
#' @param keyword Logical. Default is FALSE. Should search results show keyword
#'   list? See section on `keyword` for more details.
#' @param medical_mode Logical. Default is FALSE. Should medical coding
#'   mode be turned on?
#' @param properties A string or a vector of strings for the properties to be
#'   searched. When set to NULL (default), search is performed on a default
#'   set of properties depending on whether foundation or linearization (see
#'   section on `properties` for more details). Should be set/specified if
#'   `medical_mode = FALSE`.
#' @param release A string specifying the release version of the Foundation to
#'   search from. If not specified, defaults to the latest release version. See
#'   the available versions with `icd_versions`.
#' @param highlight Logical. Default is FALSE. If set to FALSE the search result
#'   highlighting is turned off and the results don't contain special tags for
#'   highlighting where the results are found within the text.
#' @param api_version Version of the API. Possible values are `v1` or `v2`.
#'   For example, if you provide value v2, the API will respond in the format of
#'   the version 2 of the API. Default is `v2`.
#' @param language Language code for language in which search results are to be
#'   shown. Default is English ("en"). See section on `language` for more
#'   details.
#' @param tabular Logical. Should output be structured into a tibble? Default
#'   to TRUE.
#' @param verbose Logical. Should non-warning and non-error messages be
#'   printed? Default is TRUE.
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
#' icd_search_mms("colorectal cancer")
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
                                  tabular = TRUE,
                                  verbose = TRUE,
                                  base_url = "https://id.who.int",
                                  client = icd_oauth_client(),
                                  scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release)) icd_check_release(release, verbose = verbose)

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(release, language, verbose = verbose)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/entity/search") |>
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
  if (tabular) {
    icd_structure_search(resp)
  } else {
    resp
  }
}


#'
#' @rdname icd_search
#' @export
#'
icd_search <- function(q,
                       linearization = "mms",
                       subtree = NULL,
                       use_foundation = FALSE,
                       keyword = FALSE,
                       chapter = NULL,
                       flexisearch = FALSE,
                       flat = TRUE,
                       release = NULL,
                       highlight = FALSE,
                       medical_mode = TRUE,
                       properties = NULL,
                       api_version = c("v2", "v1"),
                       language = "en",
                       tabular = TRUE,
                       verbose = TRUE,
                       base_url = "https://id.who.int",
                       client = icd_oauth_client(),
                       scope = "icdapi_access") {
  ## Get linearization to search ----
  linearization <- match.arg(linearization)

  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release))
    icd_check_release(release, verbose = verbose)
  else
    release <- icd_get_releases(latest = TRUE) |> dplyr::pull()

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(release, language, verbose = verbose)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/11", release, linearization, "search") |>
    httr2::req_url_query(q = q)

  ## Add query components ----

  ### Subtrees filter ----
  if (!is.null(subtree)) {
    req <- req |>
      httr2::req_url_query(subtreesFilter = paste(subtree, collapse = ",")) |>
      httr2::req_url_query(
        subtreeFilterUsesFoundationDescendants = ifelse(
          use_foundation, "true", "false"
        )
      )
  }

  ### Chapters filter ----
  if (!is.null(chapter)) {
    req <- req |>
      httr2::req_url_query(chapterFilter = paste(chapter, collapse = ","))
  }

  ### Flexi search, keyword, and flatResults component ----
  req <- req |>
    httr2::req_url_query(
      useFlexisearch = ifelse(flexisearch, "true", "false"),
      includeKeywordResult = ifelse(keyword, "true", "false"),
      flatResults = ifelse(flat, "true", "false")
    )

  ### Medical coding mode and Properties ----
  if (!medical_mode) {
    req <- req |>
      httr2::req_url_query(medicalCodingMode = "false")
    if (!is.null(properties)) {
      req <- req |>
        httr2::req_url_query(
          propertiesToBeSearched = paste(properties, collapse = ",")
        )
    } else {
      stop(
        "The `properties` argument needs to be specified if `medical_mode = FALSE`"
      )
    }
  } else {
    req <- req |>
      httr2::req_url_query(medicalCodingMode = "true")
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
  if (tabular) {
    icd_structure_search(resp)
  } else {
    resp
  }
}

