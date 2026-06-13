#'
#' Autocode against the foundation component or linearizations of the ICD-11
#'
#' @param q String. Text to be searched. Having the character `%` at the end
#'   will be regarded as a wild card for that word.
#' @param subtree A string or vector of strings of URIs. If provided, the
#'   search will be performed on the entities provided and their descendants.
#' @param threshold A numeric value between 0 and 1 that indicates the
#'   similarity between the input text and the matched term. `threshold` is the
#'   minimum score to be included in the output. Default is NULL to use
#'   default value specified by API.
#' @inheritParams codigo-params linearization release api_version language tabular verbose base_url client scope timeout max_tries 
#'
#' @returns A tibble of autocode results showing the search text, the matching
#'   text, the code, URIs for the foundation and linearization entities, the
#'   matching level, the matching score, and the matching type.
#'
#' @examples
#' \donttest{
#'   icd_autocode_foundation("cholera")
#'   icd_autocode(q = "cholera")
#'   icd_autocode(q = "impairment", linearization = "icf")
#' }
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
                                    scope = "icdapi_access",
                                    timeout = 30,
                                    max_tries = 3) {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release))
    icd_check_release(release, verbose = verbose)

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(
      release = release, language = language, verbose = verbose
    )

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

  ## Add timeout ----
  req <- req |>
    icd_req_policies(timeout = timeout, max_tries = max_tries)

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


#'
#' @rdname icd_autocode
#' @export
#'
icd_autocode <- function(q,
                         linearization = c("mms", "icf"),
                         subtree = NULL,
                         release = NULL,
                         threshold = NULL,
                         api_version = c("v2", "v1"),
                         language = "en",
                         tabular = TRUE,
                         verbose = TRUE,
                         base_url = "https://id.who.int",
                         client = icd_oauth_client(),
                         scope = "icdapi_access",
                         timeout = 30,
                         max_tries = 3) {
  ## Get linearization ----
  linearization <- match.arg(linearization)

  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release))
    icd_check_release(release = release, verbose = verbose)
  else
    release <- icd_get_releases(latest = TRUE) |> dplyr::pull()

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(
      release = release, language = language, verbose = verbose
    )

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/11", release, linearization, "autocode") |>
    httr2::req_url_query(searchText = q)

  ## Add query components ----

  ### Add matchThreshold ----
  if (!is.null(threshold)) {
    ### Check that threshold is within accepted limits ----

    req <- req |>
      httr2::req_url_query(matchThreshold = threshold)
  }

  ## Add timeout ----
  req <- req |>
    icd_req_policies(timeout = timeout, max_tries = max_tries)

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

