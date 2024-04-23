#'
#' Get available ICD-10 releases
#'
#' @param release A string specifying the release version of ICD-10 to search
#'   from. If not specified, defaults to the latest release version. See
#'   the available versions with `icd_versions`.
#' @param api_version Version of the API. Possible values are `v1` or `v2`.
#'   For example, if you provide value v2, the API will respond in the format of
#'   the version 2 of the API. Default is `v2`.
#' @param language ICD-API is multi-lingual. By changing this header, you may
#'   make the API respond in different languages. Languages will be available as
#'   the translations of ICD-11 completes. The values are language codes such as
#'   en, es, zh, etc. Depending on the `release_id` specified, the available
#'   languages will vary. Default is English ("en"). Note that language support
#'   for ICD-10 is limited to English (`en`).
#' @param category ICD-10 category code or for blocks, the code range.
#' @param base_url The base URL of the API. Default uses the WHO API server at
#'   https://id.who.int. If you are using a locally deployed server or hosting
#'   your own ICD API server, you should specify the URL of your instance here.
#' @param client The OAuth2 client produced through a call to
#'   `icd_oauth_client()`.
#' @param scope Scopes to be requested from the resource owner. Default is
#'   *"icdapi_access"* as specified in the ICD API documentation.
#'
#' @returns A list with information on specified ICD 10 parameters
#'
#' @examples
#' icd_10_get_releases()
#' icd_10_get_chapters()
#' icd_10_get_release_by_category(category = "A00")
#' icd_10_get_release_by_category(category = "A00-A09")
#' icd_10_get_info(category = "A00")
#' icd_10_get_info(category = "A00-A09")
#'
#' @rdname icd_10_get
#' @export
#'
#'

icd_10_get_releases <- function(api_version = c("v2", "v1"),
                                base_url = "https://id.who.int",
                                client = icd_oauth_client(),
                                scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10") |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = "en"
    )

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
                                base_url = "https://id.who.int",
                                client = icd_oauth_client(),
                                scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release))
    icd_check_release(release)
  else
    release <- icd_get_releases(icd = "icd10", latest = TRUE) |> dplyr::pull()

  ## Check language ----
  if (!is.null(language))
    icd_check_language(release = release, language = language)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10", release) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = language
    )

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
                                           scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10", category) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = "en"
    )

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

icd_10_get_info <- function(release = NULL,
                            category,
                            api_version = c("v2", "v1"),
                            language = "en",
                            base_url = "https://id.who.int",
                            client = icd_oauth_client(),
                            scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release))
    icd_check_release(release)
  else
    release <- icd_get_releases(icd = "icd10", latest = TRUE) |> dplyr::pull()

  ## Check language ----
  if (!is.null(language))
    icd_check_language(release = release, language = language)

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/10", release, category) |>
    httr2::req_headers(
      Accept = "application/json",
      "API-Version" = api_version,
      "Accept-Language" = language
    )

  ## Authenticate and perform request ----
  resp <- req |>
    icd_authenticate(client = client, scope = scope) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  ## Return response ----
  resp
}
