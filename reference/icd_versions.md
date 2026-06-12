# Table of supported classifications and versions by the ICD API

Table of supported classifications and versions by the ICD API

## Usage

``` r
icd_versions
```

## Format

A data frame with 6 columns and 11 rows:

|                  |                                                         |
|------------------|---------------------------------------------------------|
| **Variable**     | **Description**                                         |
| *Classification* | Version of classification. Either ICD-11 or ICD-10      |
| *Release ID*     | Release identifier for specific classification version  |
| *Foundation*     | Logical. Does this version include the Foundation?      |
| *MMS*            | Logical. Does this version include the MMS information? |
| *ICF*            | Logical. Does this version include the ICF?             |
| *Languages*      | Languages in which version and release is available for |

For logical fields that specify NA, this indicates that for that
particular version and release, the particular field was not applicable
or relevant.

## Source

https://icd.who.int/docs/icd-api/SupportedClassifications/

## Examples

``` r
icd_versions
#> # A tibble: 11 × 6
#>    Classification `Release ID` Foundation MMS   ICF   Languages 
#>    <chr>          <chr>        <lgl>      <lgl> <lgl> <list>    
#>  1 ICD-11         2024-01      TRUE       TRUE  TRUE  <chr [10]>
#>  2 ICD-11         2023-01      TRUE       TRUE  FALSE <chr [7]> 
#>  3 ICD-11         2022-02      TRUE       TRUE  FALSE <chr [5]> 
#>  4 ICD-11         2021-05      TRUE       TRUE  FALSE <chr [4]> 
#>  5 ICD-11         2020-09      TRUE       TRUE  FALSE <chr [3]> 
#>  6 ICD-11         2019-04      TRUE       TRUE  FALSE <chr [1]> 
#>  7 ICD-11         2018         TRUE       TRUE  FALSE <chr [1]> 
#>  8 ICD-10         2019         NA         NA    NA    <chr [1]> 
#>  9 ICD-10         2016         NA         NA    NA    <chr [1]> 
#> 10 ICD-10         2010         NA         NA    NA    <chr [1]> 
#> 11 ICD-10         2008         NA         NA    NA    <chr [2]> 
```
