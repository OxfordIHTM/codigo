# Common parameters used across codigo functions

Common parameters used across codigo functions

## Arguments

- api_version:

  Version of the API. Possible values are `v1` or `v2`. Default is `v2`.

- release:

  A string specifying the release version to search from. If not
  specified, defaults to the latest available release version. See the
  available versions for each ICD classification with `icd_versions`.

- linearization:

  A character value for which linearization to search. Currently, the
  possible values are *"mms"* and *"icf"*. Default is *"mms"*.

- language:

  ICD-API is multi-lingual. Language codes such as "en", "es", "zh",
  etc. Default is English ("en").

- tabular:

  Logical. Should output be structured into a tibble? Default is TRUE.

- verbose:

  Logical. Should non-warning and non-error messages be printed? Default
  is TRUE.

- base_url:

  The base URL of the API. Default uses the WHO API server at
  https://id.who.int.

- client:

  The OAuth2 client produced through a call to
  [`icd_oauth_client()`](https://oxford-ihtm.io/codigo/reference/icd_authenticate.md).

- scope:

  Scopes to be requested from the resource owner. Default is
  *"icdapi_access"* as specified in the ICD API documentation.

- timeout:

  The maximum time to wait for a response from the API server in
  seconds. Default is 30 seconds.

- max_tries:

  Maximum number of times to retry a request if it fails with a
  transient error (e.g. 429, 500, 503). Default is 3.
