
<!-- README.md is generated from README.Rmd. Please edit that file -->

# codigo: Interface to the International Classification of Diseases (ICD) API <img src="man/figures/logo.png" width="200" align="right" />

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/OxfordIHTM/icd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/OxfordIHTM/icd/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/OxfordIHTM/codigo/branch/main/graph/badge.svg)](https://app.codecov.io/gh/OxfordIHTM/codigo?branch=main)
[![test-coverage](https://github.com/OxfordIHTM/icd/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/OxfordIHTM/icd/actions/workflows/test-coverage.yaml)
[![CodeFactor](https://www.codefactor.io/repository/github/oxfordihtm/codigo/badge)](https://www.codefactor.io/repository/github/oxfordihtm/codigo)
<!-- badges: end -->

The [International Classification of Diseases
(ICD)](https://www.who.int/standards/classifications/classification-of-diseases)
serves a broad range of uses globally and provides critical knowledge on
the extent, causes and consequences of human disease and death worldwide
via data that is reported and coded with the ICD. [ICD
API](https://icd.who.int/icdapi) allows programmatic access to the ICD.
It is an HTTP based REST API. This package provides functions that
interface with the ICD API.

## What does `codigo` do?

Please note that `codigo` is still highly experimental and is undergoing
a lot of development. Hence, any functionalities described below have a
high likelihood of changing interface or approach as we aim for a stable
working version.

Currently, the package provides functions for authenticating with the
ICD API. From here, the plan is to develop functions that wrap the
various available [API
endpoints](https://id.who.int/swagger/index.html).

## Installation

`codigo` is not yet on CRAN.

You can install the development version of `codigo` from
[GitHub](https://github.com/OxfordIHTM/codigo) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("OxfordIHTM/codigo")
```

then load `codigo`

``` r
# load package
library(codigo)
```

## Usage

### Authenticating with the ICD API

The ICD API uses OAuth2 for authentication. The package has a set of
utility functions that support the ICD API authentication specifications
leading to the generation of an OAuth2 token. The `icd_oauth_client()`
function is the downstream and user-facing function that creates an ICD
OAuth2 client that can be used for token retrieval by future functions
that wrap ICD API for entity and linearization information retrieval.

An ICD OAuth2 client can be generated as follows:

``` r
icd_oauth_client()
```

This function uses a built in OAuth2 client created for light use and
for purposes of package development and testing.

It is recommended that those intending to use this package for
programmatically performing high volume of calls to the ICD API to
create their own **access keys** (`client id` and `client secret`) using
[these
instructions](https://icd.who.int/docs/icd-api/API-Authentication/).

Then, with your access keys, perform the following commands:

``` r
## Create your own OAuth client ----
my_oauth_client <- icd_oauth_client(
  id = "YOUR_CLIENT_ID",
  token_url = "https://icdaccessmanagement.who.int/connect/token",
  secret = "YOUR_CLIENT_SECRET",
  name = "NAME_OF_YOUR_APP
)
```

This OAuth2 client can now be used to the various functions in the
package that require an OAuth2 client for authentication for making
requests to the ICD API.

### Performing a basic search

The main feature of the ICD API is the ability to search ICD 11
Foundation and ICD 11 Linearization for information regarding an
illness/disease. This feature is captured by the
`icd_search_foundation()` function. For example, if *colorectal cancer*
is the disease of interest and information available from ICD 11 is
needed, the following call can be made:

``` r
icd_search_foundation("colorectal cancer", client = my_oauth_client)
```

which gives the following output:

    #> Release `2024-01` matches a known release for ICD-11.
    #> Language `en` is available for the release specified.
    #> # A tibble: 8 × 18
    #>   id                    title stemId isLeaf postcoordinationAvai…¹ hasCodingNote
    #> * <chr>                 <chr> <chr>  <lgl>                   <int> <lgl>        
    #> 1 http://id.who.int/ic… Mali… http:… FALSE                       0 FALSE        
    #> 2 http://id.who.int/ic… Mali… http:… FALSE                       0 FALSE        
    #> 3 http://id.who.int/ic… Mali… http:… FALSE                       0 FALSE        
    #> 4 http://id.who.int/ic… Mali… http:… FALSE                       0 FALSE        
    #> 5 http://id.who.int/ic… Mali… http:… FALSE                       0 FALSE        
    #> 6 http://id.who.int/ic… Mali… http:… FALSE                       0 FALSE        
    #> 7 http://id.who.int/ic… Fami… http:… FALSE                       0 FALSE        
    #> 8 http://id.who.int/ic… Here… http:… FALSE                       0 FALSE        
    #> # ℹ abbreviated name: ¹​postcoordinationAvailability
    #> # ℹ 12 more variables: hasMaternalChapterLink <lgl>,
    #> #   hasPerinatalChapterLink <lgl>, matchingPVs <named list>,
    #> #   propertiesTruncated <lgl>, isResidualOther <lgl>,
    #> #   isResidualUnspecified <lgl>, chapter <chr>, score <dbl>,
    #> #   titleIsASearchResult <lgl>, titleIsTopScore <lgl>, entityType <int>,
    #> #   important <lgl>

The output is a tibble created from parsed JSON body text of the HTTP
response from the ICD API.

## Citation

If you find the `codigo` package useful please cite using the suggested
citation provided by a call to the `citation()` function as follows:

``` r
citation("codigo")
#> To cite codigo in publications use:
#> 
#>   Anita Makori and Ernest Guevarra (2024). codigo: Interface to the
#>   International Classification of Diseases (ICD) API. R package version
#>   0.0.9000. URL https://oxford-ihtm.io/codigo/
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {codigo: Interface to the International Classification of Diseases (ICD) API},
#>     author = {{Anita Makori} and {Ernest Guevarra}},
#>     year = {2024},
#>     note = {R package version 0.0.9000},
#>     url = {https://oxford-ihtm.io/codigo/},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/OxfordIHTM/codigo/issues). If you
would like to contribute to the package, please see our [contributing
guidelines](https://oxford-ihtm.io/codigo/CONTRIBUTING.html).

This project is released with a [Contributor Code of
Conduct](https://oxford-ihtm.io/codigo/CODE_OF_CONDUCT.html). By
participating in this project you agree to abide by its terms.
