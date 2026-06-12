# ICD 10 code or categories mapped to one ICD 11 category

ICD 10 code or categories mapped to one ICD 11 category

## Usage

``` r
ten_map_to_one_eleven
```

## Format

A data.frame with 12597 rows and 12 columns:

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
ten_map_to_one_eleven
#> # A tibble: 12,597 × 12
#>    icd10_class_kind icd10_depth icd10_code icd10_chapter icd10_title            
#>    <chr>            <chr>       <chr>      <chr>         <chr>                  
#>  1 chapter          1           I          I             Certain infectious and…
#>  2 block            1           A00-A09    I             Intestinal infectious …
#>  3 category         1           A00        I             Cholera                
#>  4 category         2           A00.0      I             Cholera due to Vibrio …
#>  5 category         2           A00.1      I             Cholera due to Vibrio …
#>  6 category         2           A00.9      I             Cholera, unspecified   
#>  7 category         1           A01        I             Typhoid and paratyphoi…
#>  8 category         2           A01.0      I             Typhoid fever          
#>  9 category         2           A01.1      I             Paratyphoid fever A    
#> 10 category         2           A01.2      I             Paratyphoid fever B    
#> # ℹ 12,587 more rows
#> # ℹ 7 more variables: icd11_class_kind <chr>, icd11_depth <chr>,
#> #   icd11_foundation_uri <chr>, icd11_linearization_uri <chr>,
#> #   icd11_code <chr>, icd11_chapter <chr>, icd11_title <chr>
```
