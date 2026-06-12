# ICD 11 code or categories mapped to one ICD 10 category

ICD 11 code or categories mapped to one ICD 10 category

## Usage

``` r
eleven_map_to_one_ten
```

## Format

A data.frame with 17908 rows and 7 columns:

|  |  |
|----|----|
| **Variable** | **Description** |
| *icd11_linearization_uri* | ICD 11 linearization URI |
| *icd11_code* | ICD 11 code |
| *icd11_chapter* | ICD 11 chapter |
| *icd11_title* | ICD 11 title |
| *icd10_code* | ICD 10 code (for class chapter) or block of codes (for class block) |
| *icd10_chapter* | ICD 10 chapter |
| *icd10_title* | ICD 10 class or kind: either category or code |

## Source

https://icdcdn.who.int/static/releasefiles/2024-01/mapping.zip

## Examples

``` r
eleven_map_to_one_ten
#> # A tibble: 17,908 × 7
#>    icd11_linearization_uri       icd11_code icd11_chapter icd11_title icd10_code
#>    <chr>                         <chr>      <chr>         <chr>       <chr>     
#>  1 http://id.who.int/icd/releas… 01         01            Certain in… I         
#>  2 http://id.who.int/icd/releas… NA         01            Gastroente… I         
#>  3 http://id.who.int/icd/releas… NA         01            Bacterial … A04.9     
#>  4 http://id.who.int/icd/releas… 1A00       01            Cholera     A00.9     
#>  5 http://id.who.int/icd/releas… 1A01       01            Intestinal… A04       
#>  6 http://id.who.int/icd/releas… 1A02       01            Intestinal… A03.9     
#>  7 http://id.who.int/icd/releas… 1A03       01            Intestinal… A04       
#>  8 http://id.who.int/icd/releas… 1A03.0     01            Enteropath… A04.0     
#>  9 http://id.who.int/icd/releas… 1A03.1     01            Enterotoxi… A04.1     
#> 10 http://id.who.int/icd/releas… 1A03.2     01            Enteroinva… A04.2     
#> # ℹ 17,898 more rows
#> # ℹ 2 more variables: icd10_chapter <chr>, icd10_title <chr>
```
