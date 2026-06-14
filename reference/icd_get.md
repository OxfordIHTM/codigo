# Get information on various ICD-11 foundation and linearization entities

Get information on various ICD-11 foundation and linearization entities

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

icd_get_entity(
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

icd_get_info(
  linearization = c("mms", "icf"),
  api_version = c("v2", "v1"),
  language = "en",
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access",
  timeout = 30,
  max_tries = 3
)

icd_get_chapter(
  linearization = c("mms", "icf"),
  release = NULL,
  api_version = c("v2", "v1"),
  language = "en",
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

- linearization:

  A character value for which linearization to search. Currently, the
  possible values are *"mms"* and *"icf"*. Default is *"mms"*.

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
  icd_get_entity(id = "1435254666")     ## chapter
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 10
#>   `@context`       `@id` parent child  browserUrl `title@language` `title@value`
#>   <chr>            <chr> <list> <list> <chr>      <chr>            <chr>        
#> 1 http://id.who.i… http… <list> <list> https://i… en               Certain infe…
#> # ℹ 3 more variables: synonym <list>, definition <list>, exclusion <list>
  icd_get_entity(id = "588616678")      ## block; depth 1
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 7
#>   `@context`       `@id` parent child  browserUrl `title@language` `title@value`
#>   <chr>            <chr> <list> <list> <chr>      <chr>            <chr>        
#> 1 http://id.who.i… http… <list> <list> https://i… en               Gastroenteri…
  icd_get_entity(id = "1465325727")     ## category; depth 1
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 10
#>   `@context`      `@id` parent browserUrl `title@language` `title@value` synonym
#>   <chr>           <chr> <list> <chr>      <chr>            <chr>         <list> 
#> 1 http://id.who.… http… <list> https://i… en               Enteritis du… <list> 
#> # ℹ 3 more variables: definition <list>, longDefinition <list>,
#> #   relatedEntitiesInPerinatalChapter <list>
  icd_get_info()
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForMultiVersion.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/mms"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "ICD-11 for Mortality and Morbidity Statistics"
#> 
#> 
#> $latestRelease
#> [1] "http://id.who.int/icd/release/11/2026-01/mms"
#> 
#> $release
#> $release[[1]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms"
#> 
#> $release[[2]]
#> [1] "http://id.who.int/icd/release/11/2025-01/mms"
#> 
#> $release[[3]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms"
#> 
#> $release[[4]]
#> [1] "http://id.who.int/icd/release/11/2023-01/mms"
#> 
#> $release[[5]]
#> [1] "http://id.who.int/icd/release/11/2022-02/mms"
#> 
#> $release[[6]]
#> [1] "http://id.who.int/icd/release/11/2021-05/mms"
#> 
#> $release[[7]]
#> [1] "http://id.who.int/icd/release/11/2020-09/mms"
#> 
#> $release[[8]]
#> [1] "http://id.who.int/icd/release/11/2019-04/mms"
#> 
#> $release[[9]]
#> [1] "http://id.who.int/icd/release/11/2018/mms"
#> 
#> 
  icd_get_info("icf")
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForMultiVersion.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/icf"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "International Classification of Functioning, Disability and Health (ICF)"
#> 
#> 
#> $latestRelease
#> [1] "http://id.who.int/icd/release/11/2026-01/icf"
#> 
#> $release
#> $release[[1]]
#> [1] "http://id.who.int/icd/release/11/2026-01/icf"
#> 
#> $release[[2]]
#> [1] "http://id.who.int/icd/release/11/2025-01/icf"
#> 
#> $release[[3]]
#> [1] "http://id.who.int/icd/release/11/2024-01/icf"
#> 
#> 
  icd_get_chapter()
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForTopLevel.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/2026-01/mms"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "ICD-11 for Mortality and Morbidity Statistics"
#> 
#> 
#> $releaseId
#> [1] "2026-01"
#> 
#> $releaseDate
#> [1] "2026-01-17"
#> 
#> $availableLanguages
#> $availableLanguages[[1]]
#> [1] "ar"
#> 
#> $availableLanguages[[2]]
#> [1] "cs"
#> 
#> $availableLanguages[[3]]
#> [1] "de"
#> 
#> $availableLanguages[[4]]
#> [1] "en"
#> 
#> $availableLanguages[[5]]
#> [1] "es"
#> 
#> $availableLanguages[[6]]
#> [1] "fr"
#> 
#> $availableLanguages[[7]]
#> [1] "kk"
#> 
#> $availableLanguages[[8]]
#> [1] "la"
#> 
#> $availableLanguages[[9]]
#> [1] "pt"
#> 
#> $availableLanguages[[10]]
#> [1] "ru"
#> 
#> $availableLanguages[[11]]
#> [1] "sk"
#> 
#> $availableLanguages[[12]]
#> [1] "sv"
#> 
#> $availableLanguages[[13]]
#> [1] "tr"
#> 
#> $availableLanguages[[14]]
#> [1] "uz"
#> 
#> $availableLanguages[[15]]
#> [1] "zh"
#> 
#> 
#> $prereleaseLanguages
#> $prereleaseLanguages[[1]]
#> [1] "de"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1435254666"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1630407678"
#> 
#> $child[[3]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1766440644"
#> 
#> $child[[4]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1954798891"
#> 
#> $child[[5]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/21500692"
#> 
#> $child[[6]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/334423054"
#> 
#> $child[[7]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/274880002"
#> 
#> $child[[8]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1296093776"
#> 
#> $child[[9]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/868865918"
#> 
#> $child[[10]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1218729044"
#> 
#> $child[[11]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/426429380"
#> 
#> $child[[12]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/197934298"
#> 
#> $child[[13]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1256772020"
#> 
#> $child[[14]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1639304259"
#> 
#> $child[[15]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1473673350"
#> 
#> $child[[16]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/30659757"
#> 
#> $child[[17]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/577470983"
#> 
#> $child[[18]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/714000734"
#> 
#> $child[[19]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1306203631"
#> 
#> $child[[20]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/223744320"
#> 
#> $child[[21]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1843895818"
#> 
#> $child[[22]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/435227771"
#> 
#> $child[[23]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/850137482"
#> 
#> $child[[24]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1249056269"
#> 
#> $child[[25]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/1596590595"
#> 
#> $child[[26]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/718687701"
#> 
#> $child[[27]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/231358748"
#> 
#> $child[[28]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms/979408586"
#> 
#> 
#> $browserUrl
#> [1] "https://icd.who.int/browse/2026-01/mms/en"
#> 
  icd_get_chapter("icf")
#> Release `2026-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForTopLevel.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/2026-01/icf"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "International Classification of Functioning, Disability and Health (ICF)"
#> 
#> 
#> $releaseId
#> [1] "2026-01"
#> 
#> $releaseDate
#> [1] "2026-01-17"
#> 
#> $availableLanguages
#> $availableLanguages[[1]]
#> [1] "cs"
#> 
#> $availableLanguages[[2]]
#> [1] "en"
#> 
#> $availableLanguages[[3]]
#> [1] "es"
#> 
#> $availableLanguages[[4]]
#> [1] "et"
#> 
#> $availableLanguages[[5]]
#> [1] "fi"
#> 
#> $availableLanguages[[6]]
#> [1] "fr"
#> 
#> $availableLanguages[[7]]
#> [1] "hy"
#> 
#> $availableLanguages[[8]]
#> [1] "it"
#> 
#> $availableLanguages[[9]]
#> [1] "mn"
#> 
#> $availableLanguages[[10]]
#> [1] "pt"
#> 
#> $availableLanguages[[11]]
#> [1] "ru"
#> 
#> $availableLanguages[[12]]
#> [1] "sk"
#> 
#> $availableLanguages[[13]]
#> [1] "tr"
#> 
#> $availableLanguages[[14]]
#> [1] "uk"
#> 
#> $availableLanguages[[15]]
#> [1] "zh"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/release/11/2026-01/icf/619527855"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/release/11/2026-01/icf/423829389"
#> 
#> 
#> $browserUrl
#> [1] "https://icd.who.int/browse/2026-01/icf/en"
#> 
# }
```
