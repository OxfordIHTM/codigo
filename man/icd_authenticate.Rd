% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/icd_authenticate.R
\name{icd_oauth_client}
\alias{icd_oauth_client}
\alias{icd_authenticate}
\title{OAuth2 authentication to ICD API}
\usage{
icd_oauth_client(
  id = "6fc8a1e4-4da9-43a8-bd0c-c164c0cb0ebd_3c7e272e-2f4b-46de-b127-df7454e36be8",
  token_url = "https://icdaccessmanagement.who.int/connect/token",
  secret = "OGIly8mTatQ2ILuhBTbviIp2FofWiQR3fj4HaPiGseE=",
  name = "icd_client",
  ...
)

icd_authenticate(
  req,
  client = icd_oauth_client(),
  scope = "icdapi_access",
  ...
)
}
\arguments{
\item{id}{Consumer key, also sometimes called the client ID.}

\item{token_url}{url used to exchange unauthenticated for authenticated token.}

\item{secret}{Consumer secret, also sometimes called the client secret.
Despite its name, this does not necessarily need to be protected like a
password, i.e. the user still has to authenticate themselves and grant the
app permission to access resources on their behalf.}

\item{name}{Name of the application. This is not used for OAuth, but is
used to make it easier to identify different applications.}

\item{...}{Other parameters/arguments to be passed onto \code{httr2::oauth_client()}
or to \code{httr2::req_oauth_client_credentials()}}

\item{req}{A request}

\item{client}{An OAuth2 client. Default is a call to \code{icd_oauth_client()}.}

\item{scope}{Scopes to be requested from the resource owner. Default is
\emph{"icdapi_access"} as specified in the ICD API documentation.}
}
\value{
An \code{httr2_oauth_client} class object.
}
\description{
OAuth2 authentication to ICD API
}
\examples{
icd_oauth_client()

}
