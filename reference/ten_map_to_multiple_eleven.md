# ICD 10 code or categories mapped to multiple ICD 11 categories

ICD 10 code or categories mapped to multiple ICD 11 categories

## Usage

``` r
ten_map_to_multiple_eleven
```

## Format

A data.frame with 15658 rows and 12 columns:

|  |  |
|----|----|
| **Variable** | **Description** |
| *icd10_class_kind* | ICD 10 class or kind: either chapter, block, category, or modifiedcategory |
| *icd10_depth* | ICD 10 depth level |
| *icd10_code* | ICD 10 code (for class chapter) or block of codes (for class block) |
| *icd10_chapter* | ICD 10 chapter |
| *icd10_title* | ICD 10 class or kind: either category or code |
| *icd11_class_kind* | ICD 11 class or kind: either block, category, or chapter |
| *icd11_depth* | ICD 11 depth level |
| *icd11_foundation_uri* | ICD 11 foundation URI |
| *icd11_linearization_uri* | ICD 11 linearization URI |
| *icd11_code* | ICD 11 code |
| *icd11_chapter* | ICD 11 chapter |
| *icd11_title* | ICD 11 title |

## Source

https://icdcdn.who.int/static/releasefiles/2024-01/mapping.zip

## Examples

``` r
ten_map_to_multiple_eleven
#> # A tibble: 15,658 × 12
#>    icd10_class_kind icd10_depth icd10_code icd10_chapter icd10_title            
#>    <chr>            <chr>       <chr>      <chr>         <chr>                  
#>  1 chapter          1           I          I             Certain infectious and…
#>  2 block            1           A00-A09    I             Intestinal infectious …
#>  3 block            1           A00-A09    I             Intestinal infectious …
#>  4 block            1           A00-A09    I             Intestinal infectious …
#>  5 block            1           A00-A09    I             Intestinal infectious …
#>  6 block            1           A00-A09    I             Intestinal infectious …
#>  7 block            1           A00-A09    I             Intestinal infectious …
#>  8 block            1           A00-A09    I             Intestinal infectious …
#>  9 block            1           A00-A09    I             Intestinal infectious …
#> 10 block            1           A00-A09    I             Intestinal infectious …
#> # ℹ 15,648 more rows
#> # ℹ 7 more variables: icd11_class_kind <chr>, icd11_depth <chr>,
#> #   icd11_foundation_uri <chr>, icd11_linearization_uri <chr>,
#> #   icd11_code <chr>, icd11_chapter <chr>, icd11_title <chr>
```
