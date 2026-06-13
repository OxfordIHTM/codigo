# OAuth2 authentication to ICD API

OAuth2 authentication to ICD API

## Usage

``` r
icd_oauth_client(
  id = Sys.getenv("ICD_CLIENT_ID"),
  token_url = "https://icdaccessmanagement.who.int/connect/token",
  secret = Sys.getenv("ICD_CLIENT_SECRET"),
  name = "icd_client",
  ...
)

icd_authenticate(
  req,
  client = icd_oauth_client(),
  scope = "icdapi_access",
  ...
)
```

## Arguments

- id:

  Consumer key, also sometimes called the client ID.

- token_url:

  url used to exchange unauthenticated for authenticated token.

- secret:

  Consumer secret, also sometimes called the client secret. Despite its
  name, this does not necessarily need to be protected like a password,
  i.e. the user still has to authenticate themselves and grant the app
  permission to access resources on their behalf.

- name:

  Name of the application. This is not used for OAuth, but is used to
  make it easier to identify different applications.

- ...:

  Other parameters/arguments to be passed onto
  [`httr2::oauth_client()`](https://httr2.r-lib.org/reference/oauth_client.html)
  or to
  [`httr2::req_oauth_client_credentials()`](https://httr2.r-lib.org/reference/req_oauth_client_credentials.html)

- req:

  A request

- client:

  The OAuth2 client produced through a call to `icd_oauth_client()`.

- scope:

  Scopes to be requested from the resource owner. Default is
  *"icdapi_access"* as specified in the ICD API documentation.

## Value

An `httr2_oauth_client` class object.

## Examples

``` r
icd_oauth_client()
#> <httr2_oauth_client>
#> * name     : "icd_client"
#> * id       : "6fc8a1e4-4da9-43a8-bd0c-c164c0cb0ebd_3c7e272e-2f4b-46de-b127-df7454e36be8"
#> * secret   : <REDACTED>
#> * token_url: "https://icdaccessmanagement.who.int/connect/token"
#> * auth     : "oauth_client_req_auth_header"
```
