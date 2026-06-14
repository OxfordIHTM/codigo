#'
#' Get information on various ICD-11 foundation and linearization entities
#'
#' @inheritParams codigo-params release linearization api_version language tabular verbose base_url client scope timeout max_tries
#' @param id Unique numerical identifier for an entity.
#' @param include A string or a vector of strings for optional property values
#'   to be included in the response. The property values that can be included
#'   are *"ancestor"*, *"descendant"*, or *"diagnosticCriteria"*. If not
#'   specified, these properties are not included in the response.
#'
#' @returns A list with information on specified ICD 11 Foundation and top level
#'   entities.
#'
#' @examples
#' \donttest{
#'   icd_get_foundation()
#'   icd_get_entity(id = "1435254666")     ## chapter
#'   icd_get_entity(id = "588616678")      ## block; depth 1
#'   icd_get_entity(id = "1465325727")     ## category; depth 1
#'   icd_get_info()
#'   icd_get_info("icf")
#'   icd_get_chapter()
#'   icd_get_chapter("icf")
#' }
#'
#' @rdname icd_get
#' @export
#'
icd_get_foundation <- function(release = NULL,
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
  if (!is.null(release)) icd_check_release(release = release, verbose = verbose)

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(
      release = release, language = language, verbose = verbose
    )

  ## Make base request ----
  req <- httr2::request(file.path(base_url, "icd/entity"))

  ## Add optional query components ----

  ### Add releaseId ----
  if (!is.null(release)) {
    req <- req |>
      httr2::req_url_query(releaseId = release)
  }

  ## Add timeout and max_tries ----
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
    icd_structure_foundation(resp)
  } else {
    resp
  }
}


#'
#' @rdname icd_get
#' @export
#'
icd_get_entity <- function(id,
                           release = NULL,
                           include = NULL,
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
    icd_check_release(release = release, verbose = verbose)

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(
      release = release, language = language, verbose = verbose
    )

  ## Make base request ----
  req <- httr2::request(file.path(base_url, "icd/entity", id)) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = language
    )

  ## Add optional queries ----

  ### Add releaseId ----
  if (!is.null(release)) {
    req <- req |>
      httr2::req_url_query(releaseId = release)
  }

  ### Add include ----
  if (!is.null(include)) {
    include <- paste(include, collapse = ",")

    req <- req |>
      httr2::req_url_query(include = include)
  }

  ## Add timeout and max_tries ----
  req <- req |>
    icd_req_policies(timeout = timeout, max_tries = max_tries)

  ## Authenticate and perform request ----
  resp <- req |>
    icd_authenticate(client = client, scope = scope) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  ## Return response ----
  if (tabular) {
    icd_structure_entity(icd_entity = resp)
  } else {
    resp
  }
}


#'
#' @rdname icd_get
#' @export
#'
icd_get_info <- function(linearization = c("mms", "icf"),
                         api_version = c("v2", "v1"),
                         language = "en",
                         verbose = TRUE,
                         base_url = "https://id.who.int",
                         client = icd_oauth_client(),
                         scope = "icdapi_access",
                         timeout = 30,
                         max_tries = 3) {
  ## Get linearization to search ----
  linearization <- match.arg(linearization)

  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(
      release = icd_get_releases(latest = TRUE) |> dplyr::pull(),
      language = language,
      verbose = verbose
    )

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/11", linearization) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = language
    ) |>
    icd_req_policies(timeout = timeout, max_tries = max_tries)
  
  ## Authenticate and perform request ----
  resp <- req |>
    icd_authenticate(client = client, scope = scope) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  ## Return response ----
  resp
}


#'
#' @rdname icd_get
#' @export
#'
icd_get_chapter <- function(linearization = c("mms", "icf"),
                            release = NULL,
                            api_version = c("v2", "v1"),
                            language = "en",
                            verbose = TRUE,
                            base_url = "https://id.who.int",
                            client = icd_oauth_client(),
                            scope = "icdapi_access",
                            timeout = 30,
                            max_tries = 3) {
  ## Get linearization to search ----
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
    httr2::req_url_path("icd/release/11", release, linearization) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = language
    ) |>
    icd_req_policies(timeout = timeout, max_tries = max_tries)

  ## Authenticate and perform request ----
  resp <- req |>
    icd_authenticate(client = client, scope = scope) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  ## Return response ----
  resp
}



