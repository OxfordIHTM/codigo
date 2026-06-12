# ICD-11 Mortality and Morbidity Simple Table Outputs

ICD-11 Mortality and Morbidity Simple Table Outputs

## Usage

``` r
icd11_simple_table_mms
```

## Format

A data frame with 18 columns and 36044 rows:

|  |  |
|----|----|
| **Variable** | **Description** |
| *Foundation URI* | Unique identifier for the entity that will not change |
| *Linearization (release) URI* | Unique identifier for this version of the classification. It includes the linearization name such as MMS and minor version identifier such as 2018 in it |
| *Code* | ICD-11 code for the entity. Note that the groupings do not have a code. |
| *BlockId* | Identifier for high level groupings that do not bear a code |
| *Title* | Title of the entity |
| *ClassKind* | One of the three (chapter, block, category); Chapter is top level classification entities; Blocks are high level groupings that do not bear a code; Categories are entities that has a code |
| *DepthInKind* | Depth of within the Class Kind. For example, a category with depthinkind=2 means it is category whose parent is also a category but grand parent is not |
| *IsResidual* | true if the entity is a residual category (i.e. other specified or unspecified categories) |
| *ChapterNo* | The chapter that the entity is in |
| *BrowserLink* | Direct link to this entity in ICD-11 browser |
| *IsLeaf* | true if this entity does not have any children |
| *Primary Tabulation* |  |
| *GroupingX* | Groupings that the entity is included in |
| *Version* | Date and time linearization was produced |

## Source

https://icdcdn.who.int/static/releasefiles/2024-01/SimpleTabulation-ICD-11-MMS-en.zip

## Examples

``` r
icd11_simple_table_mms
#> # A tibble: 36,044 × 18
#>    `Foundation URI`            `Linearization URI` Code  BlockId Title ClassKind
#>    <chr>                       <chr>               <chr> <chr>   <chr> <chr>    
#>  1 http://id.who.int/icd/enti… http://id.who.int/… NA    NA      Cert… chapter  
#>  2 http://id.who.int/icd/enti… http://id.who.int/… NA    BlockL… - Ga… block    
#>  3 http://id.who.int/icd/enti… http://id.who.int/… NA    BlockL… - - … block    
#>  4 http://id.who.int/icd/enti… http://id.who.int/… 1A00  NA      - - … category 
#>  5 http://id.who.int/icd/enti… http://id.who.int/… 1A01  NA      - - … category 
#>  6 http://id.who.int/icd/enti… http://id.who.int/… 1A02  NA      - - … category 
#>  7 http://id.who.int/icd/enti… http://id.who.int/… 1A03  NA      - - … category 
#>  8 http://id.who.int/icd/enti… http://id.who.int/… 1A03… NA      - - … category 
#>  9 http://id.who.int/icd/enti… http://id.who.int/… 1A03… NA      - - … category 
#> 10 http://id.who.int/icd/enti… http://id.who.int/… 1A03… NA      - - … category 
#> # ℹ 36,034 more rows
#> # ℹ 12 more variables: DepthInKind <chr>, IsResidual <chr>, ChapterNo <chr>,
#> #   BrowserLink <dbl>, isLeaf <chr>, `Primary tabulation` <chr>,
#> #   Grouping1 <chr>, Grouping2 <chr>, Grouping3 <chr>, Grouping4 <chr>,
#> #   Grouping5 <chr>, Version <chr>
```
