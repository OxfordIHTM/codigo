# Checks for specified parameters supplied to search, autocode, and get functions

Checks for specified parameters supplied to search, autocode, and get
functions

## Usage

``` r
icd_check_release(release, icd = c("icd11", "icd10"), verbose = TRUE)

icd_check_language(
  release = NULL,
  language,
  icd = c("icd11", "icd10"),
  verbose = TRUE
)
```

## Arguments

- release:

  A string specifying the release version of the ICD-11.

- icd:

  A character string of available ICD classifications. Currently, this
  can be either "icd10" or "icd11". Default is "icd11".

- verbose:

  Logical. Should non-warning and non-error messages be printed? Default
  is TRUE.

- language:

  language codes such as en, es, zh, etc.

## Value

A message or an error if `release` provided is recognised or not. A
message or a warning if `language` requested is available or not for
`release` provided. For `icd_check_language()`, returns a character
value or a character vector of acceptable language codes.

## Examples

``` r
icd_check_release("2024-01")
#> Release `2024-01` matches a known release for ICD-11.
try(icd_check_release("2025-01"))
#> Error in icd_check_release("2025-01") : 
#>   Release `2025-01` does not match any known release for ICD-11. Please check`icd_versions`.
icd_check_language("2024-01", "ar")
#> Release `2024-01` matches a known release for ICD-11.
#> Language `ar` is available for the release specified.
#> [1] "ar"
icd_check_language("2024-01", "rr")
#> Release `2024-01` matches a known release for ICD-11.
#> Warning: Language `rr` is not available for the release specified. Returning results for`en` (default).
#> [1] "en"
try(icd_check_language("2025-01", "ar"))
#> Error in icd_check_release(release = release, icd = icd, verbose = verbose) : 
#>   Release `2025-01` does not match any known release for ICD-11. Please check`icd_versions`.
```
