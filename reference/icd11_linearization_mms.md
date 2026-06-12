# ICD-11 Mortality and Morbidity Linearization Outputs

ICD-11 Mortality and Morbidity Linearization Outputs

## Usage

``` r
icd11_linearization_mms
```

## Format

A data frame with 21 columns and 36753 rows:

|                               |                                          |
|-------------------------------|------------------------------------------|
| **Variable**                  | **Description**                          |
| *Foundation URI*              | Foundation URI                           |
| *Linearization (release) URI* | Linearization release URI                |
| *Code*                        | ICD-11 Code                              |
| *BlockId*                     | Block identifier                         |
| *Title*                       | Title                                    |
| *ClassKind*                   | Class                                    |
| *DepthInKind*                 | Depth                                    |
| *IsResidual*                  | Is residual?                             |
| *PrimaryLocation*             | Primary location                         |
| *ChapterNo*                   | Chapter number                           |
| *BrowserLink*                 | Browser link                             |
| *iCatLink*                    | Category link                            |
| *isLeaf*                      | Is leaf?                                 |
| *noOfNonResidualChildren*     | Number of non-residual children          |
| *Primary tabulation*          | Primary tabulation                       |
| *Version*                     | Date and time linearization was produced |

## Source

https://icd.who.int/dev11/Downloads/Download?fileName=LinearizationMiniOutput-MMS-en.zip

## Examples

``` r
icd11_linearization_mms
#> # A tibble: 36,753 × 21
#>    `Foundation URI`         Linearization (relea…¹ Code  BlockId Title ClassKind
#>    <chr>                    <chr>                  <chr> <chr>   <chr> <chr>    
#>  1 http://id.who.int/icd/e… http://id.who.int/icd… NA    NA      Cert… chapter  
#>  2 http://id.who.int/icd/e… http://id.who.int/icd… NA    BlockL… - Ga… block    
#>  3 http://id.who.int/icd/e… http://id.who.int/icd… NA    BlockL… - - … block    
#>  4 http://id.who.int/icd/e… http://id.who.int/icd… 1A00  NA      - - … category 
#>  5 http://id.who.int/icd/e… http://id.who.int/icd… 1A01  NA      - - … category 
#>  6 http://id.who.int/icd/e… http://id.who.int/icd… 1A02  NA      - - … category 
#>  7 http://id.who.int/icd/e… http://id.who.int/icd… 1A03  NA      - - … category 
#>  8 http://id.who.int/icd/e… http://id.who.int/icd… 1A03… NA      - - … category 
#>  9 http://id.who.int/icd/e… http://id.who.int/icd… 1A03… NA      - - … category 
#> 10 http://id.who.int/icd/e… http://id.who.int/icd… 1A03… NA      - - … category 
#> # ℹ 36,743 more rows
#> # ℹ abbreviated name: ¹​`Linearization (release) URI`
#> # ℹ 15 more variables: DepthInKind <chr>, IsResidual <chr>,
#> #   PrimaryLocation <chr>, ChapterNo <chr>, BrowserLink <dbl>, iCatLink <dbl>,
#> #   isLeaf <chr>, noOfNonResidualChildren <chr>, `Primary tabulation` <chr>,
#> #   Grouping1 <chr>, Grouping2 <chr>, Grouping3 <chr>, Grouping4 <chr>,
#> #   Grouping5 <chr>, Version <chr>
```
