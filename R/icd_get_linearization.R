#'
#' Get information on various ICD-11 linearization entities
#'
#' @inheritParams codigo-params release linearization api_version language tabular verbose base_url client scope timeout max_tries
#' @param id Unique numerical identifier for an entity.
#'
#' @returns A list with information on specified ICD 11 Foundation and top level
#'   entities.
#'
#' @examples
#' \donttest{
#'   icd_get_info()
#'   icd_get_info("icf")
#'   icd_get_chapter()
#'   icd_get_chapter("icf")
#' }
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