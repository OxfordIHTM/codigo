#'
#' OAuth2 authentication to ICD API
#'
#' @param id Consumer key, also sometimes called the client ID.
#' @param token_url url used to exchange unauthenticated for authenticated token.
#' @param secret Consumer secret, also sometimes called the client secret.
#'   Despite its name, this does not necessarily need to be protected like a
#'   password, i.e. the user still has to authenticate themselves and grant the
#'   app permission to access resources on their behalf.
#' @param name Name of the application. This is not used for OAuth, but is
#'   used to make it easier to identify different applications.
#' @param ... Other parameters/arguments to be passed onto `httr2::oauth_client()`
#'
#' @return An `httr2_oauth_client` class (RC) object.
#'
#' @examples
#' icd_oauth_client()
#'
#' @rdname icd_authenticate
#'
#' @export
#'
icd_oauth_client <- function(id = "6fc8a1e4-4da9-43a8-bd0c-c164c0cb0ebd_3c7e272e-2f4b-46de-b127-df7454e36be8",
                             token_url = "https://icdaccessmanagement.who.int/connect/token",
                             secret = "OGIly8mTatQ2ILuhBTbviIp2FofWiQR3fj4HaPiGseE=",
                             name = "icd_client",
                             ...) {
  httr2::oauth_client(
    id = id,
    token_url = token_url,
    secret = secret,
    auth = "header",
    name = name
  )
}


