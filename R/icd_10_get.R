#'
#' Get available ICD-10 releases
#'
#' @inheritParams codigo-params release api_version language verbose base_url client scope timeout max_tries
#' @param category ICD-10 category code or for blocks, the code range.
#'
#' @returns A list with information on specified ICD 10 parameters
#'
#' @examples
#' \donttest{
#'   icd_10_get_releases()
#'   icd_10_get_chapters()
#'   icd_10_get_release_by_category(category = "A00")
#'   icd_10_get_release_by_category(category = "A00-A09")
#'   icd_10_get_info(category = "A00")
#'   icd_10_get_info(category = "A00-A09")
#' }
#'
#' @rdname icd_10_get
#' @export
#'
#'

icd_10_get_releases <- function(api_version = c("v2", "v1"),
                                base_url = "https://id.who.int",
                                client = icd_oauth_client(),
                                scope = "icdapi_access",
                                timeout = 30,
                                max_tries = 3) {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10") |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = "en"
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
#' @rdname icd_10_get
#' @export
#'

icd_10_get_chapters <- function(release = NULL,
                                api_version = c("v2", "v1"),
                                language = "en",
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
    icd_check_release(release = release, icd = "icd10", verbose = verbose)
  else
    release <- icd_get_releases(icd = "icd10", latest = TRUE) |> dplyr::pull()

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(
      release = release, language = language, icd = "icd10", verbose = verbose
    )

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10", release) |>
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
#' @rdname icd_10_get
#' @export
#'

icd_10_get_release_by_category <- function(category,
                                           api_version = c("v2", "v1"),
                                           base_url = "https://id.who.int",
                                           client = icd_oauth_client(),
                                           scope = "icdapi_access",
                                           timeout = 30,
                                           max_tries = 3) {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10", category) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = "en"
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
#' @rdname icd_10_get
#' @export
#'

icd_10_get_info <- function(category,
                            release = NULL,
                            api_version = c("v2", "v1"),
                            language = "en",
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
    icd_check_release(release = release, icd = "icd10", verbose = verbose)
  else
    release <- icd_get_releases(icd = "icd10", latest = TRUE) |> dplyr::pull()

  ## Check language ----
  if (!is.null(language))
    language <- icd_check_language(
      release = release, language = language, icd = "icd10", verbose = verbose
    )

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10", release, category) |>
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
