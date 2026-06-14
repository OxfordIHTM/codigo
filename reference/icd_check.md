# Checks for specified parameters supplied to search, autocode, and get functions

Checks for specified parameters supplied to search, autocode, and get
functions

## Usage

``` r
icd_check_release(release, icd = c("icd11", "icd10"), verbose = TRUE)

icd_check_language(
  release = NULL,
  linearization = c("mms", "icf"),
  language,
  icd = c("icd11", "icd10"),
  verbose = TRUE
)
```

## Arguments

- release:

  A string specifying the release version to search from. If not
  specified, defaults to the latest available release version. See the
  available versions for each ICD classification with `icd_versions`.

- icd:

  A character string of available ICD classifications. Currently, this
  can be either "icd10" or "icd11". Default is "icd11".

- verbose:

  Logical. Should non-warning and non-error messages be printed? Default
  is TRUE.

- linearization:

  A character value for which linearization to search. Currently, the
  possible values are *"mms"* and *"icf"*. Default is *"mms"*.

- language:

  ICD-API is multi-lingual. Language codes such as "en", "es", "zh",
  etc. Default is English ("en").

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
#> Release `2025-01` matches a known release for ICD-11.
icd_check_language("2024-01", "mms", "ar")
#> Release `2024-01` matches a known release for ICD-11.
#> Language `ar` is available for the release specified.
#> [1] "ar"
icd_check_language("2024-01", "mms", "rr")
#> Release `2024-01` matches a known release for ICD-11.
#> Warning: Language `rr` is not available for the release specified. Returning results for`en` (default).
#> [1] "en"
try(icd_check_language("2025-01", "mms", "ar"))
#> Release `2025-01` matches a known release for ICD-11.
#> Language `ar` is available for the release specified.
#> [1] "ar"
```
