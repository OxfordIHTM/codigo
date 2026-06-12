# Map ICD codes between versions

Map ICD codes between versions

## Usage

``` r
icd_map(from = c("icd10", "icd11"), to = c("one", "multiple"), code)
```

## Arguments

- from:

  The ICD version to map from. Either *icd10* or *icd11*. Default to
  *icd10*.

- to:

  A character value of either *multiple* or *one* to map ICD-10 to
  ICD-11 accordingly. Only relevant if `from` is *icd10*. Ignored when
  `from` is *icd11*. Default to *one*.

- code:

  Corresponding ICD code in version specified in `from` to map to the
  other version.

## Value

A tibble of information for specified `code` mapped based on `from`

## Examples

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
