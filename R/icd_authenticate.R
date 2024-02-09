#'
#' OAuth2 authentication to ICD API
#'
#' @param authorize url to send client to for authorisation. Set to NULL if not
#'   needed.
#' @param access url used to exchange unauthenticated for authenticated token.
#' @param endpoint OAuth endpoint for the ICD API, created by `icd_endpoint()`
#' @param app An OAuth consumer application, created by `icd_oauth_app()` by
#'   default.
#' @param scope ICD API scope to request. Default is "icdapi_access".
#' @param as_header If TRUE, the default, configures the token to add itself to
#'   the bearer header of subsequent requests. If FALSE, configures the token to
#'   add itself as a url parameter of subsequent requests.
#' @param client_credentials Default to FALSE. Set to TRUE to use Client
#'   Credentials Grant instead of Authorization Code Grant. See
#'   https://www.rfc-editor.org/rfc/rfc6749#section-4.4.
#' @param ... Other parameters/arguments to be passed onto `httr::oauth2.0_token()`
#' @param appname Name of the application. This is not used for OAuth, but is
#'   used to make it easier to identify different applications.
#' @param key Consumer key, also sometimes called the client ID.
#' @param secret Consumer secret, also sometimes called the client secret.
#'   Despite its name, this does not necessarily need to be protected like a
#'   password, i.e. the user still has to authenticate themselves and grant the
#'   app permission to access resources on their behalf.
#'
#' @return For `icd_token()`, a Token2.0 reference class (RC) object.
#'
#' @examples
#' icd_endpoint()
#' icd_token()
#' icd_oauth_app()
#'
#' @rdname icd_authenticate
#'
#' @export
#'

icd_endpoint <- function(authorize = NULL,
                         access = "https://icdaccessmanagement.who.int/connect/token") {
  httr::oauth_endpoint(authorize = authorize, access = access)
}

#'
#' @rdname icd_authenticate
#' @export
#'

icd_token <- function(endpoint = icd_endpoint(),
                      app = icd_oauth_app(),
                      scope = "icdapi_access",
                      #use_oob = TRUE,
                      as_header = TRUE,
                      client_credentials = TRUE, ...) {
  httr::oauth2.0_token(
    endpoint = endpoint,
    app = app,
    scope = scope,
    #use_oob = use_oob,
    as_header = as_header,
    client_credentials = client_credentials,
    ...
  )
}

#'
#' @rdname icd_authenticate
#' @export
#'

icd_oauth_app <- function(appname = "icd_app",
                          key = "6fc8a1e4-4da9-43a8-bd0c-c164c0cb0ebd_3c7e272e-2f4b-46de-b127-df7454e36be8",
                          secret = "OGIly8mTatQ2ILuhBTbviIp2FofWiQR3fj4HaPiGseE=") {
  httr::oauth_app(
    appname = appname,
    key = key,
    secret = secret
  )
}

