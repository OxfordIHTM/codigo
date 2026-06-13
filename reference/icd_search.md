# Search the foundation component or linearizations of the ICD-11

Search the foundation component or linearizations of the ICD-11

## Usage

``` r
icd_search_foundation(
  q,
  subtree = NULL,
  chapter = NULL,
  flexisearch = FALSE,
  flat = TRUE,
  properties = NULL,
  release = NULL,
  highlight = FALSE,
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

icd_search(
  q,
  linearization = c("mms", "icf"),
  subtree = NULL,
  use_foundation = FALSE,
  keyword = FALSE,
  chapter = NULL,
  flexisearch = FALSE,
  flat = TRUE,
  release = NULL,
  highlight = FALSE,
  medical_mode = TRUE,
  properties = NULL,
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

- chapter:

  A string or vector of strings of chapter codes eg: c("01", "02") When
  provided, the search will be performed only on these chapters.

- flexisearch:

  Logical. Default is FALSE. Changes the search mode to flexible search
  (for more details, see section on flexisearch).

- flat:

  Logical. Default is FALSE. If set to true the search result entities
  are provided in a nested data structure representing the ICD-11
  hierarchy. Otherwise they are listed as flat list of matches.

- properties:

  A string or a vector of strings for the properties to be searched.
  When set to NULL (default), search is performed on a default set of
  properties depending on whether foundation or linearization (see
  section on `properties` for more details). Should be set/specified if
  `medical_mode = FALSE`.

- release:

  A string specifying the release version to search from. If not
  specified, defaults to the latest available release version. See the
  available versions for each ICD classification with `icd_versions`.

- highlight:

  Logical. Default is FALSE. If set to FALSE the search result
  highlighting is turned off and the results don't contain special tags
  for highlighting where the results are found within the text.

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

- use_foundation:

  Logical. Default is FALSE. Should subtree filter use foundation
  descendants (TRUE) or linearization descendants (FALSE)?

- keyword:

  Logical. Default is FALSE. Should search results show keyword list?
  See section on `keyword` for more details.

- medical_mode:

  Logical. Default is FALSE. Should medical coding mode be turned on?

## Value

A tibble of search results.

## On `flexisearch`

In the regular search mode (`flexisearch = FALSE`), the function will
only give you results that contain all of the words that you've used in
your search. It accepts different variants or synonyms of the words but
essentially it searches for a result that contains all components of
your search. Whereas in flexible search mode, the results do not have to
contain all of the words that are typed. It would still try to find the
best matching phrase but there may be words in your search that are not
matched at all. It is recommended to use flexible search only when
regular search does not provide a result.

## On `keyword`

If set to true, the search result will also include keyword list. If the
last word provided is incomplete, keyword list includes all words that
start with the incomplete word (word completion mode). If the last word
is complete, the keyword list will provide suggested additional words
that could be added to the search query (word suggestion mode).

## On `medical_mode`

When searching the classification for medical coding purposes, this
should be set to TRUE (default). In this mode, the search gives results
only from the entities that have a code. The system will search all
index terms of an entity. i.e. *titles*, *synonyms*, *fully specified
term*, all terms of other entities that are in the foundation are
aggregated into this entity. By default, *chapters 26*, *V*, and *X* are
not included in the search results. If `medical_mode` is set to FALSE,
then the `properties` argument will need to be specified (see next
section).

## On `properties`

In the Foundation search, by default the function searches *"Title"*,
*"Synonyms"*, and *"FullySpecifiedName"*. The valid values that could be
used for properties are: *"Title"*, *"Synonym"*, *"NarrowerTerm"*,
*"FullySpecifiedName"*, *"Definition"*, and *"Exclusion"*. In the MMS
search, this argument is only used when `medical_mode = FALSE`. The
valid values that could be used are: *"Title"*, *"FullySpecifiedName"*,
*"Definition"*, *"Exclusion"*, and *"IndexTerm"*. If *"IndexTerm"* is
used, the search will be performed on all *"Titles"*, *"Synonyms"*, and
*"FullySpecifiedNames"* including the ones that are under shoreline (i.e
Entities in the foundation but not in MMS). In such cases the results
will be shown based on where the match is aggregated into in MMS.

## On `language`

ICD-API is multi-lingual. By setting the language, you may make the API
respond in different languages. Languages will be available as the
translations of ICD-11 completes. The values are language codes such as
en, es, zh, etc. Depending on the `release` specified, the available
languages will vary.

## Examples

``` r
icd_search_foundation("colorectal cancer")
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 4 × 27
#>   id                    title stemId isLeaf postcoordinationAvai…¹ hasCodingNote
#>   <chr>                 <chr> <chr>  <lgl>                   <int> <lgl>        
#> 1 http://id.who.int/ic… Mali… http:… FALSE                       0 FALSE        
#> 2 http://id.who.int/ic… Fami… http:… FALSE                       0 FALSE        
#> 3 http://id.who.int/ic… Here… http:… FALSE                       0 FALSE        
#> 4 http://id.who.int/ic… Meta… http:… TRUE                        0 FALSE        
#> # ℹ abbreviated name: ¹​postcoordinationAvailability
#> # ℹ 21 more variables: hasMaternalChapterLink <lgl>,
#> #   hasPerinatalChapterLink <lgl>, matchingPVs <list>,
#> #   propertiesTruncated <lgl>, isResidualOther <lgl>,
#> #   isResidualUnspecified <lgl>, chapter <chr>, theCode <lgl>, score <dbl>,
#> #   titleIsASearchResult <lgl>, titleIsTopScore <lgl>, entityType <int>,
#> #   important <lgl>, descendants <lgl>, error <lgl>, errorMessage <lgl>, …
icd_search("colorectal cancer")
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 2 × 27
#>   id                    title stemId isLeaf postcoordinationAvai…¹ hasCodingNote
#>   <chr>                 <chr> <chr>  <lgl>                   <int> <lgl>        
#> 1 http://id.who.int/ic… Mali… http:… TRUE                        1 FALSE        
#> 2 http://id.who.int/ic… Othe… http:… TRUE                        1 FALSE        
#> # ℹ abbreviated name: ¹​postcoordinationAvailability
#> # ℹ 21 more variables: hasMaternalChapterLink <lgl>,
#> #   hasPerinatalChapterLink <lgl>, matchingPVs <list>,
#> #   propertiesTruncated <lgl>, isResidualOther <lgl>,
#> #   isResidualUnspecified <lgl>, chapter <chr>, theCode <chr>, score <dbl>,
#> #   titleIsASearchResult <lgl>, titleIsTopScore <lgl>, entityType <int>,
#> #   important <lgl>, descendants <lgl>, error <lgl>, errorMessage <lgl>, …
icd_search("impairment", linearization = "icf")
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 7 × 27
#>   id                    title stemId isLeaf postcoordinationAvai…¹ hasCodingNote
#>   <chr>                 <chr> <chr>  <lgl>                   <int> <lgl>        
#> 1 http://id.who.int/ic… Seei… http:… TRUE                        0 FALSE        
#> 2 http://id.who.int/ic… Swal… http:… TRUE                        0 FALSE        
#> 3 http://id.who.int/ic… COMP… http:… TRUE                        0 FALSE        
#> 4 http://id.who.int/ic… MILD… http:… TRUE                        0 FALSE        
#> 5 http://id.who.int/ic… SEVE… http:… TRUE                        0 FALSE        
#> 6 http://id.who.int/ic… MODE… http:… TRUE                        0 FALSE        
#> 7 http://id.who.int/ic… NO i… http:… TRUE                        0 FALSE        
#> # ℹ abbreviated name: ¹​postcoordinationAvailability
#> # ℹ 21 more variables: hasMaternalChapterLink <lgl>,
#> #   hasPerinatalChapterLink <lgl>, matchingPVs <list>,
#> #   propertiesTruncated <lgl>, isResidualOther <lgl>,
#> #   isResidualUnspecified <lgl>, chapter <chr>, theCode <chr>, score <dbl>,
#> #   titleIsASearchResult <lgl>, titleIsTopScore <lgl>, entityType <int>,
#> #   important <lgl>, descendants <lgl>, error <lgl>, errorMessage <lgl>, …
```
