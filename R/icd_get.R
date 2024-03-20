#'
#' Get information on various ICD 11 Foundation entities
#'
#' @param id Unique numerical identifier for an entity.
#' @param release A string specifying the release version of the Foundation to
#'   search from. If not specified, defaults to the latest release version. See
#'   the available versions with `icd_versions`.
#' @param include A string or a vector of strings for optional property values
#'   to be included in the response. The property values that can be included
#'   are *"ancestor"*, *"descendant"*, or *"diagnosticCriteria"*. If not
#'   specified, these properties are not included in the response.
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
#' @return A list with information on specified ICD 11 Foundation and top level
#'   entities.
#'
#' @examples
#' icd_get_foundation()
#' icd_get_entity(id = "1435254666")     ## chapter
#' icd_get_entity(id = "588616678")      ## block; depth 1
#' icd_get_entity(id = "1465325727")     ## category; depth 1
#' icd_get_mms_release()
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
                               scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check release identifier ----
  if (!is.null(release)) icd_check_release(release, verbose = verbose)

  ## Check language ----
  if (!is.null(language)) icd_check_language(release, language, verbose = verbose)

  ## Make base request ----
  req <- httr2::request(file.path(base_url, "icd/entity"))

  ## Add optional query components ----

  ### Add releaseId ----
  if (!is.null(release)) {
    req <- req |>
      httr2::req_url_query(releaseId = release)
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
icd_get_mms_release <- function(api_version = c("v2", "v1"),
                                language = "en",
                                base_url = "https://id.who.int",
                                client = icd_oauth_client(),
                                scope = "icdapi_access") {
  ## Get API version to use ----
  api_version <- match.arg(api_version)

  ## Check language ----
  if (!is.null(language))
    icd_check_language(
      release = icd_get_releases(latest = TRUE) |> dplyr::pull(),
      language
    )

  ## Make base request ----
  req <- httr2::request(base_url) |>
    httr2::req_url_path("icd/release/11/mms") |>
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
