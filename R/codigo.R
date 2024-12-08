#'
#' Interface to the International Classification of Diseases (ICD) API
#'
#' The International Classification of Diseases (ICD) serves a broad range of
#' uses globally and provides critical knowledge on the extent, causes and
#' consequences of human disease and death worldwide via data that is reported
#' and coded with the ICD. ICD API allows programmatic access to the ICD. It is
#' an HTTP based REST API. This package provides functions that interface with
#' the ICD API.
#'
#' @docType package
#' @keywords internal
#' @name codigo
#' @importFrom httr2 oauth_client request req_url_query req_headers
#'   req_oauth_client_credentials req_perform resp_body_json req_url_path
#' @importFrom tibble tibble
#' @importFrom dplyr bind_cols bind_rows pull filter
#' @importFrom tidyr unnest
#' @importFrom rlang .data
#' @importFrom utils head
#'
"_PACKAGE"
