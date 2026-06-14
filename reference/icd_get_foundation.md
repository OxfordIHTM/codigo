# Get information on various ICD-11 foundation entities

Get information on various ICD-11 foundation entities

## Usage

``` r
icd_get_foundation(
  release = NULL,
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

icd_get_foundation_entity(
  id,
  release = NULL,
  include = NULL,
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

- release:

  A string specifying the release version to search from. If not
  specified, defaults to the latest available release version. See the
  available versions for each ICD classification with `icd_versions`.

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

- id:

  Unique numerical identifier for an entity.

- include:

  A string or a vector of strings for optional property values to be
  included in the response. The property values that can be included are
  *"ancestor"*, *"descendant"*, or *"diagnosticCriteria"*. If not
  specified, these properties are not included in the response.

## Value

A list with information on specified ICD 11 Foundation and top level
entities.

## Examples

``` r
# \donttest{
  icd_get_foundation()
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 11
#>   `@context`        `@id` `title_@language` `title_@value` releaseId releaseDate
#>   <chr>             <chr> <chr>             <chr>          <chr>     <chr>      
#> 1 http://id.who.in… http… en                WHO Family of… 2026-01   2026-01-17 
#> # ℹ 5 more variables: availableLanguages <list>, allReleases <list>,
#> #   includedLinearizations <list>, child <list>, browserUrl <chr>
  icd_get_foundation_entity(id = "1435254666")     ## chapter
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 10
#>   `@context`       `@id` parent child  browserUrl `title@language` `title@value`
#>   <chr>            <chr> <list> <list> <chr>      <chr>            <chr>        
#> 1 http://id.who.i… http… <list> <list> https://i… en               Certain infe…
#> # ℹ 3 more variables: synonym <list>, definition <list>, exclusion <list>
  icd_get_foundation_entity(id = "588616678")      ## block; depth 1
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 7
#>   `@context`       `@id` parent child  browserUrl `title@language` `title@value`
#>   <chr>            <chr> <list> <list> <chr>      <chr>            <chr>        
#> 1 http://id.who.i… http… <list> <list> https://i… en               Gastroenteri…
  icd_get_foundation_entity(id = "1465325727")     ## category; depth 1
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 10
#>   `@context`      `@id` parent browserUrl `title@language` `title@value` synonym
#>   <chr>           <chr> <list> <chr>      <chr>            <chr>         <list> 
#> 1 http://id.who.… http… <list> https://i… en               Enteritis du… <list> 
#> # ℹ 3 more variables: definition <list>, longDefinition <list>,
#> #   relatedEntitiesInPerinatalChapter <list>
# }
```
