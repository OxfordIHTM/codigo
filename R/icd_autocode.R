#'
#' Perform autocoding
#'
#' @param q String. Text to be searched. Having the character `%` at the end will
#'   be regarded as a wild card for that word.
#' @param release A string specifying the release version of the Foundation to
#'   search from. If not specified, defaults to the latest release version. See
#'   the available versions with `icd_versions`.
#' @param subtree A string or vector of strings of URIs. If provided, the
#'   search will be performed on the entities provided and their descendants.
#' @param threshold A numeric value between 0 and 1 that indicates the similarity
#'   between the input text and the matched term. `threshold` is the
#'   minimum score to be included in the output. Default is NULL to use
#'   default value specified by API.
#' @param api_version Version of the API. Possible values are `v1` or `v2`.
#'   For example, if you provide value v2, the API will respond in the format of
#'   the version 2 of the API. Default is `v2`.
#' @param language ICD-API is multi-lingual. By changing this header, you may
#'   make the API respond in different languages. Languages will be available as
#'   the translations of ICD-11 completes. The values are language codes such as
#'   en, es, zh, etc. Depending on the `release_id` specified, the available
#'   languages will vary. Default is English ("en").
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
#' @return An autocode
#'
#' @examples
#' icd_autocode_foundation("cholera")
#'
#'
#' @rdname icd_autocode
#' @export
#'
icd_autocode_foundation <- function(q,
                                    subtree = NULL,
                                    release = NULL,
                                    threshold = NULL,
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
  req <- httr2::request(file.path(base_url, "icd/entity/autocode")) |>
    httr2::req_url_query(searchText = q)

  ## Add query components ----

  ### Add releaseId ----
  if (!is.null(release)) {
    req <- req |>
      httr2::req_url_query(releaseId = release)
  }

  ### Add matchThreshold ----
  if (!is.null(threshold)) {
    ### Check that threshold is within accepted limits ----

    req <- req |>
      httr2::req_url_query(matchThreshold = threshold)
  }

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
    icd_structure_autocode(resp)
  } else {
    resp
  }
}
