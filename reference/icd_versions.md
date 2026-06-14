# Table of supported classifications and versions by the ICD API

Table of supported classifications and versions by the ICD API

## Usage

``` r
icd_versions
```

## Format

A data frame with 6 columns and 11 rows:

|  |  |
|----|----|
| **Variable** | **Description** |
| *release_id* | Release identifier for specific classification version |
| *foundation* | Logical. Does this version include the Foundation? |
| *classification* | Classification name: ICD-11 or ICD-10 |
| *linearization* | Either MMS or ICF |
| *languages* | Languages in which classification, release, and linearization is available for |

## Source

https://icd.who.int/docs/icd-api/SupportedClassifications/

## Examples

``` r
icd_versions
#> # A tibble: 22 × 5
#>    release_id foundation classification linearization language  
#>    <chr>      <lgl>      <chr>          <chr>         <list>    
#>  1 2026-01    TRUE       ICD-11         mms           <chr [15]>
#>  2 2026-01    TRUE       ICD-11         icf           <chr [15]>
#>  3 2025-01    TRUE       ICD-11         mms           <chr [14]>
#>  4 2025-01    TRUE       ICD-11         icf           <chr [6]> 
#>  5 2024-01    TRUE       ICD-11         mms           <chr [10]>
#>  6 2024-01    TRUE       ICD-11         icf           <chr [3]> 
#>  7 2023-01    TRUE       ICD-11         mms           <chr [7]> 
#>  8 2023-01    TRUE       ICD-11         icf           <NULL>    
#>  9 2022-02    TRUE       ICD-11         mms           <chr [5]> 
#> 10 2022-02    TRUE       ICD-11         icf           <NULL>    
#> # ℹ 12 more rows
```
