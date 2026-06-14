# Utility functions for retrieving ICD parameters and definitions

Utility functions for retrieving ICD parameters and definitions

## Usage

``` r
icd_get_releases(
  icd = c("icd11", "icd10"),
  linearization = c("mms", "icf"),
  latest = FALSE
)

icd_get_languages(
  icd = c("icd11", "icd10"),
  linearization = c("mms", "icf"),
  latest = FALSE
)

icd_get_entities(class = NULL)
```

## Arguments

- icd:

  A character string of available ICD classifications. Currently, this
  can be either "icd10" or "icd11". Default is "icd11". If NULL, all ICD
  classifications are used (currently both "icd10" and "icd11").

- linearization:

  A character value for which linearization to search. Currently, the
  possible values are *"mms"* and *"icf"*. Default is *"mms"*.

- latest:

  Logical. If TRUE, identifier for latest release is returned. Default
  is FALSE.

- class:

  A character string of code classes to retrieve. This can be either
  "chapter", "block", or "category". If NULL (default), all classes are
  retrieved.

## Value

A tibble for ICD classification values and their corresponding release
identifiers (for `icd_get_releases()`). A names list of corresponding
languages (for `icd_get_languages()`). A tibble of entities with their
definitions/titles and classes (for `icd_get_entitties()`).

## Examples

``` r
icd_get_releases()
#> # A tibble: 9 × 3
#>   classification release_id linearization
#>   <chr>          <chr>      <chr>        
#> 1 ICD-11         2026-01    mms          
#> 2 ICD-11         2025-01    mms          
#> 3 ICD-11         2024-01    mms          
#> 4 ICD-11         2023-01    mms          
#> 5 ICD-11         2022-02    mms          
#> 6 ICD-11         2021-05    mms          
#> 7 ICD-11         2020-09    mms          
#> 8 ICD-11         2019-04    mms          
#> 9 ICD-11         2018       mms          
icd_get_languages()
#> $`ICD-11 - Release 2026-01 - mms`
#>  [1] "ar" "zh" "cs" "en" "fr" "de" "kk" "la" "pt" "ru" "sk" "es" "sv" "tr" "uz"
#> 
#> $`ICD-11 - Release 2026-01 - icf`
#>  [1] "hy" "zh" "cs" "en" "et" "fi" "fr" "it" "mn" "pt" "ru" "sk" "es" "tr" "uk"
#> 
#> $`ICD-11 - Release 2025-01 - mms`
#>  [1] "ar" "zh" "cs" "en" "fr" "kk" "la" "pt" "ru" "sk" "es" "sv" "tr" "uz"
#> 
#> $`ICD-11 - Release 2025-01 - icf`
#> [1] "zh" "cs" "en" "fr" "es" "tr"
#> 
#> $`ICD-11 - Release 2024-01 - mms`
#>  [1] "ar" "zh" "cs" "en" "fr" "pt" "ru" "es" "tr" "uz"
#> 
#> $`ICD-11 - Release 2024-01 - icf`
#> [1] "cs" "en" "tr"
#> 
#> $`ICD-11 - Release 2023-01 - mms`
#> [1] "ar" "zh" "en" "fr" "ru" "es" "tr"
#> 
#> $`ICD-11 - Release 2023-01 - icf`
#> NULL
#> 
#> $`ICD-11 - Release 2022-02 - mms`
#> [1] "ar" "zh" "en" "fr" "es"
#> 
#> $`ICD-11 - Release 2022-02 - icf`
#> NULL
#> 
#> $`ICD-11 - Release 2021-05 - mms`
#> [1] "ar" "zh" "en" "es"
#> 
#> $`ICD-11 - Release 2021-05 - icf`
#> NULL
#> 
#> $`ICD-11 - Release 2020-09 - mms`
#> [1] "ar" "en" "es"
#> 
#> $`ICD-11 - Release 2020-09 - icf`
#> NULL
#> 
#> $`ICD-11 - Release 2019-04 - mms`
#> [1] "en"
#> 
#> $`ICD-11 - Release 2019-04 - icf`
#> NULL
#> 
#> $`ICD-11 - Release 2018 - mms`
#> [1] "en"
#> 
#> $`ICD-11 - Release 2018 - icf`
#> NULL
#> 
icd_get_entities()
#> # A tibble: 36,044 × 5
#>    entity_foundation entity_mms code   title                               class
#>    <chr>             <chr>      <chr>  <chr>                               <chr>
#>  1 1435254666        1435254666 NA     Certain infectious or parasitic di… chap…
#>  2 588616678         588616678  NA     - Gastroenteritis or colitis of in… block
#>  3 135352227         135352227  NA     - - Bacterial intestinal infections block
#>  4 257068234         257068234  1A00   - - - Cholera                       cate…
#>  5 416025325         416025325  1A01   - - - Intestinal infection due to … cate…
#>  6 2080365623        2080365623 1A02   - - - Intestinal infections due to… cate…
#>  7 344162786         344162786  1A03   - - - Intestinal infections due to… cate…
#>  8 2099226249        2099226249 1A03.0 - - - - Enteropathogenic Escherich… cate…
#>  9 408185629         408185629  1A03.1 - - - - Enterotoxigenic Escherichi… cate…
#> 10 1828273122        1828273122 1A03.2 - - - - Enteroinvasive Escherichia… cate…
#> # ℹ 36,034 more rows
```
