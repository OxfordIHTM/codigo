# Get started with codigo

This article takes a quick tour of the main features of `codigo`.

## Authenticating with the ICD API

The ICD API uses [OAuth2](https://httr2.r-lib.org/articles/oauth.html)
for authentication. The package has a set of utility functions that
support the ICD API authentication specifications leading to the
generation of an OAuth2 token. The
[`icd_oauth_client()`](https://oxford-ihtm.io/codigo/reference/icd_authenticate.md)
function is the downstream and user-facing function that creates an ICD
OAuth2 client that can be used for token retrieval by future functions
that wrap ICD API for entity and linearization information retrieval.

An ICD OAuth2 client can be generated as follows:

``` r

icd_oauth_client()
```

This function uses a built in OAuth2 client created for light use and
for purposes of package development and testing.

It is recommended that those intending to use this package for
programmatically performing high volume of calls to the ICD API to
create their own **access keys** (`client id` and `client secret`) using
[these
instructions](https://icd.who.int/docs/icd-api/API-Authentication/).

Then, with your access keys, perform the following commands:

``` r

## Create your own OAuth client ----
my_oauth_client <- icd_oauth_client(
  id = "YOUR_CLIENT_ID",
  token_url = "https://icdaccessmanagement.who.int/connect/token",
  secret = "YOUR_CLIENT_SECRET",
  name = "NAME_OF_YOUR_APP"
)
```

This OAuth2 client can now be used to the various functions in the
package that require an OAuth2 client for authentication for making
requests to the ICD API.

## Performing a basic search

A feature of the ICD API is the ability to search ICD 11 Foundation and
ICD 11 Linearization for information regarding an illness/disease. This
feature is captured by the `icd_search` functions. For example, if
*colorectal cancer* is the disease of interest and information available
from ICD 11 is needed, the following call can be made:

``` r

icd_search("colorectal cancer", client = my_oauth_client)
```

which gives the following output:

    #> Release `2024-01` matches a known release for ICD-11.
    #> Language `en` is available for the release specified.
    #> # A tibble: 18 × 19
    #>    id                   title stemId isLeaf postcoordinationAvai…¹ hasCodingNote
    #>  * <chr>                <chr> <chr>  <lgl>                   <int> <lgl>        
    #>  1 http://id.who.int/i… Mali… http:… TRUE                        1 FALSE        
    #>  2 http://id.who.int/i… Mali… http:… TRUE                        1 FALSE        
    #>  3 http://id.who.int/i… Mali… http:… TRUE                        1 FALSE        
    #>  4 http://id.who.int/i… Mali… http:… TRUE                        1 FALSE        
    #>  5 http://id.who.int/i… Mali… http:… TRUE                        1 FALSE        
    #>  6 http://id.who.int/i… Mali… http:… TRUE                        1 FALSE        
    #>  7 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #>  8 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #>  9 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 10 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 11 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 12 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 13 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 14 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 15 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 16 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 17 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> 18 http://id.who.int/i… Othe… http:… TRUE                        1 FALSE        
    #> # ℹ abbreviated name: ¹​postcoordinationAvailability
    #> # ℹ 13 more variables: hasMaternalChapterLink <lgl>,
    #> #   hasPerinatalChapterLink <lgl>, matchingPVs <named list>,
    #> #   propertiesTruncated <lgl>, isResidualOther <lgl>,
    #> #   isResidualUnspecified <lgl>, chapter <chr>, theCode <chr>, score <dbl>,
    #> #   titleIsASearchResult <lgl>, titleIsTopScore <lgl>, entityType <int>,
    #> #   important <lgl>

The output is a tibble created from parsed JSON body text of the HTTP
response from the ICD API. If you prefer the output to remain as the
parsed JSON body text of the HTTP response from the ICD API, set the
argument `tabular = FALSE`

``` r

icd_search("colorectal cancer", tabular = FALSE, client = my_oauth_client)
```

which gives the following output:

    #> Release `2024-01` matches a known release for ICD-11.
    #> Language `en` is available for the release specified.
    #> $destinationEntities
    #> $destinationEntities[[1]]
    #> $destinationEntities[[1]]$id
    #> [1] "http://id.who.int/icd/release/11/2024-01/mms/774170412/unspecified"
    #> 
    #> $destinationEntities[[1]]$title
    #> [1] "Malignant neoplasms of rectosigmoid junction, unspecified"
    #> 
    #> $destinationEntities[[1]]$stemId
    #> [1] "http://id.who.int/icd/release/11/2024-01/mms/774170412/unspecified"
    #> 
    #> $destinationEntities[[1]]$isLeaf
    #> [1] TRUE
    #> 
    #> $destinationEntities[[1]]$postcoordinationAvailability
    #> [1] 1
    #> 
    #> $destinationEntities[[1]]$hasCodingNote
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$hasMaternalChapterLink
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$hasPerinatalChapterLink
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$matchingPVs
    #> $destinationEntities[[1]]$matchingPVs[[1]]
    #> $destinationEntities[[1]]$matchingPVs[[1]]$propertyId
    #> [1] "Synonym"
    #> 
    #> $destinationEntities[[1]]$matchingPVs[[1]]$label
    #> [1] "Colorectal Cancer NOS"
    #> 
    #> $destinationEntities[[1]]$matchingPVs[[1]]$score
    #> [1] 1
    #> 
    #> $destinationEntities[[1]]$matchingPVs[[1]]$important
    #> [1] TRUE
    #> 
    #> $destinationEntities[[1]]$matchingPVs[[1]]$foundationUri
    #> [1] "http://id.who.int/icd/entity/774170412"
    #> 
    #> $destinationEntities[[1]]$matchingPVs[[1]]$propertyValueType
    #> [1] 0
    #> 
    #> 
    #> 
    #> $destinationEntities[[1]]$propertiesTruncated
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$isResidualOther
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$isResidualUnspecified
    #> [1] TRUE
    #> 
    #> $destinationEntities[[1]]$chapter
    #> [1] "02"
    #> 
    #> $destinationEntities[[1]]$theCode
    #> [1] "2B91.Z"
    #> 
    #> $destinationEntities[[1]]$score
    #> [1] 1
    #> 
    #> $destinationEntities[[1]]$titleIsASearchResult
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$titleIsTopScore
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$entityType
    #> [1] 0
    #> 
    #> $destinationEntities[[1]]$important
    #> [1] FALSE
    #> 
    #> $destinationEntities[[1]]$descendants
    #> list()
    #> 
    #> 
    #> $destinationEntities[[2]]
    #> $destinationEntities[[2]]$id
    #> [1] "http://id.who.int/icd/release/11/2024-01/mms/1265576634/other"
    #> 
    #> $destinationEntities[[2]]$title
    #> [1] "Other specified malignant neoplasms of colon"
    #> 
    #> $destinationEntities[[2]]$stemId
    #> [1] "http://id.who.int/icd/release/11/2024-01/mms/1265576634/other"
    #> 
    #> $destinationEntities[[2]]$isLeaf
    #> [1] TRUE
    #> 
    #> $destinationEntities[[2]]$postcoordinationAvailability
    #> [1] 1
    #> 
    #> $destinationEntities[[2]]$hasCodingNote
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$hasMaternalChapterLink
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$hasPerinatalChapterLink
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$matchingPVs
    #> $destinationEntities[[2]]$matchingPVs[[1]]
    #> $destinationEntities[[2]]$matchingPVs[[1]]$propertyId
    #> [1] "Title"
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[1]]$label
    #> [1] "Familial nonpolyposis colorectal cancer"
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[1]]$score
    #> [1] 0.5544255
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[1]]$important
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[1]]$foundationUri
    #> [1] "http://id.who.int/icd/entity/545664807"
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[1]]$propertyValueType
    #> [1] 1
    #> 
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[2]]
    #> $destinationEntities[[2]]$matchingPVs[[2]]$propertyId
    #> [1] "Title"
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[2]]$label
    #> [1] "Hereditary nonpolyposis colorectal cancer"
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[2]]$score
    #> [1] 0.5423688
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[2]]$important
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[2]]$foundationUri
    #> [1] "http://id.who.int/icd/entity/8113015"
    #> 
    #> $destinationEntities[[2]]$matchingPVs[[2]]$propertyValueType
    #> [1] 1
    #> 
    #> 
    #> 
    #> $destinationEntities[[2]]$propertiesTruncated
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$isResidualOther
    #> [1] TRUE
    #> 
    #> $destinationEntities[[2]]$isResidualUnspecified
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$chapter
    #> [1] "02"
    #> 
    #> $destinationEntities[[2]]$theCode
    #> [1] "2B90.Y"
    #> 
    #> $destinationEntities[[2]]$score
    #> [1] 0.5544255
    #> 
    #> $destinationEntities[[2]]$titleIsASearchResult
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$titleIsTopScore
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$entityType
    #> [1] 0
    #> 
    #> $destinationEntities[[2]]$important
    #> [1] FALSE
    #> 
    #> $destinationEntities[[2]]$descendants
    #> list()
    #> 
    #> 
    #> 
    #> $error
    #> [1] FALSE
    #> 
    #> $errorMessage
    #> NULL
    #> 
    #> $resultChopped
    #> [1] FALSE
    #> 
    #> $wordSuggestionsChopped
    #> [1] FALSE
    #> 
    #> $guessType
    #> [1] 2
    #> 
    #> $uniqueSearchId
    #> [1] "6d012b1e-d555-4cda-be26-0f037cc6954c"
    #> 
    #> $words
    #> NULL

## Autocoding

Autocoding is a focused search that returns results based on the closest
match from ICD-11. Autocoding using the ICD Linearization component API
endpoint can be done as follows:

``` r

icd_autocode("colorectal cancer", client = my_oauth_client)
```

which gives the following results

    #> Release `2024-01` matches a known release for ICD-11.
    #> Language `en` is available for the release specified.
    #> # A tibble: 1 × 5
    #>   searchText        matchLevel matchScore matchType isTitle
    #>   <chr>                  <int>      <int>     <int> <lgl>  
    #> 1 colorectal cancer          3          0         0 FALSE

## Converting ICD-10 codes to ICD-11 and vice versa

If you are working with data that used ICD-10 codes and need these codes
to be converted to ICD-11 codes, the
[`icd_map()`](https://oxford-ihtm.io/codigo/reference/icd_map.md)
function assists in performing this. The following code will provide
information on what the *A00* ICD0-10 code including its ICD-11
counterpart.

``` r

icd_map(code = "A00")
#> # A tibble: 1 × 12
#>   icd10_class_kind icd10_depth icd10_code icd10_chapter icd10_title
#>   <chr>            <chr>       <chr>      <chr>         <chr>      
#> 1 category         1           A00        I             Cholera    
#> # ℹ 7 more variables: icd11_class_kind <chr>, icd11_depth <chr>,
#> #   icd11_foundation_uri <chr>, icd11_linearization_uri <chr>,
#> #   icd11_code <chr>, icd11_chapter <chr>, icd11_title <chr>
```
