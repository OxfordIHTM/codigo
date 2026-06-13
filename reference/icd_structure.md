# Structure ICD list and ICD search outputs

Structure ICD list and ICD search outputs

## Usage

``` r
icd_structure_foundation(icd_list)

icd_structure_search(icd_search)

icd_structure_autocode(icd_autocode)
```

## Arguments

- icd_list:

  An object produced by a call to any of the `icd_get` functions

- icd_search:

  An object produced by a call to any of the `icd_search` functions

- icd_autocode:

  An object produced by a call to any of the `icd_autocode` functions

## Value

A tibble of structured ICD outputs.

## Details

These functions are meant to be helper functions and are used within the
`icd_get`, `icd_search`, and `icd_autocode` functions to structure the
output responses.

## Examples

``` r
icd_list <- icd_get_foundation(tabular = FALSE)
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
icd_tbl_foundation <- icd_structure_foundation(icd_list)
#> New names:
#> • `` -> `...8`
#> • `` -> `...9`
#> • `` -> `...10`
#> • `` -> `...11`
#> • `` -> `...12`
#> • `` -> `...13`
#> • `` -> `...14`
#> • `` -> `...15`
#> • `` -> `...16`
#> • `` -> `...17`
#> • `` -> `...18`
#> • `` -> `...19`
icd_structure_search(icd_search_foundation("cholera", tabular = FALSE))
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 103 × 18
#>    id                   title stemId isLeaf postcoordinationAvai…¹ hasCodingNote
#>  * <chr>                <chr> <chr>  <lgl>                   <int> <lgl>        
#>  1 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  2 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  3 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  4 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  5 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  6 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  7 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  8 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#>  9 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#> 10 http://id.who.int/i… Chol… http:… FALSE                       0 FALSE        
#> # ℹ 93 more rows
#> # ℹ abbreviated name: ¹​postcoordinationAvailability
#> # ℹ 12 more variables: hasMaternalChapterLink <lgl>,
#> #   hasPerinatalChapterLink <lgl>, matchingPVs <named list>,
#> #   propertiesTruncated <lgl>, isResidualOther <lgl>,
#> #   isResidualUnspecified <lgl>, chapter <chr>, score <dbl>,
#> #   titleIsASearchResult <lgl>, titleIsTopScore <lgl>, entityType <int>, …
icd_structure_autocode(icd_autocode_foundation("cholera"))
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 7
#>   searchText matchingText foundationURI  matchLevel matchScore matchType isTitle
#>   <chr>      <chr>        <chr>               <int>      <int>     <int> <lgl>  
#> 1 cholera    Cholera      http://id.who…          0          1         0 TRUE   
```
