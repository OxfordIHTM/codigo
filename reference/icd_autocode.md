# Autocode against the foundation component or linearizations of the ICD-11

Autocode against the foundation component or linearizations of the
ICD-11

## Usage

``` r
icd_autocode_foundation(
  q,
  subtree = NULL,
  release = NULL,
  threshold = NULL,
  api_version = c("v2", "v1"),
  language = "en",
  tabular = TRUE,
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access",
  timeout = 30,
  max_tries = 3
)

icd_autocode(
  q,
  linearization = c("mms", "icf"),
  subtree = NULL,
  release = NULL,
  threshold = NULL,
  api_version = c("v2", "v1"),
  language = "en",
  tabular = TRUE,
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access",
  timeout = 30,
  max_tries = 3
)
```

## Arguments

- q:

  String. Text to be searched. Having the character `%` at the end will
  be regarded as a wild card for that word.

- subtree:

  A string or vector of strings of URIs. If provided, the search will be
  performed on the entities provided and their descendants.

- release:

  A string specifying the release version to search from. If not
  specified, defaults to the latest available release version. See the
  available versions for each ICD classification with `icd_versions`.

- threshold:

  A numeric value between 0 and 1 that indicates the similarity between
  the input text and the matched term. `threshold` is the minimum score
  to be included in the output. Default is NULL to use default value
  specified by API.

- api_version:

  Version of the API. Possible values are `v1` or `v2`. Default is `v2`.

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

- linearization:

  A character value for which linearization to search. Currently, the
  possible values are *"mms"* and *"icf"*. Default is *"mms"*.

## Value

A tibble of autocode results showing the search text, the matching text,
the code, URIs for the foundation and linearization entities, the
matching level, the matching score, and the matching type.

## Examples

``` r
# \donttest{
  icd_autocode_foundation("cholera")
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 5
#>   searchText matchLevel matchScore matchType isTitle
#>   <chr>           <int>      <int>     <int> <lgl>  
#> 1 cholera             3          0         0 FALSE  
  icd_autocode(q = "cholera")
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 5
#>   searchText matchLevel matchScore matchType isTitle
#>   <chr>           <int>      <int>     <int> <lgl>  
#> 1 cholera             3          0         0 FALSE  
  icd_autocode(q = "impairment", linearization = "icf")
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 9
#>   searchText matchingText      theCode foundationURI linearizationURI matchLevel
#>   <chr>      <chr>             <chr>   <chr>         <chr>                 <int>
#> 1 impairment impaired adaptab… b2109   http://id.wh… http://id.who.i…          1
#> # ℹ 3 more variables: matchScore <dbl>, matchType <int>, isTitle <lgl>
# }
```
