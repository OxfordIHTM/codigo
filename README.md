
<!-- README.md is generated from README.Rmd. Please edit that file -->

# codigo: Interface to the International Classification of Diseases (ICD) API <img src="man/figures/logo.png" width="200" align="right" />

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/OxfordIHTM/icd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/OxfordIHTM/icd/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/OxfordIHTM/icd/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/OxfordIHTM/icd/actions/workflows/test-coverage.yaml)
[![Codecov test
coverage](https://codecov.io/gh/OxfordIHTM/codigo/branch/main/graph/badge.svg)](https://app.codecov.io/gh/OxfordIHTM/codigo?branch=main)
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

Please note that `codigo` is still experimental but is nearing a stable
release. It is possible that some functionalities described below and in
the rest of the package documentation may change interface or approach
but these changes will likely be minor.

Currently, the package provides functions for:

  - Authenticating with the ICD API (*stable*);
  - Performing a search of ICD-11 foundation and linearization
    components (*stable*);
  - Performing autocoding of causes of death using the ICD-11 foundation
    and linearization components (*stable*);
  - Getting information on various ICD-11 foundation and linearization
    entities (*experimental*);
  - Converting ICD-10 codes to ICD-11 codes and vice versa (*stable*);
    and,
  - Determining the underlying cause of death based on reported
    information on a death certificate (*experimental*).

## Installation

`codigo` is not yet on CRAN but can be installed from the [Oxford
iHealth R Universe](https://oxfordihtm.r-universe.dev) as follows:

``` r
install.packages(
  "codigo",
  repos = c('https://oxfordihtm.r-universe.dev', 'https://cloud.r-project.org')
)
```

and then can be loaded into an R session

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
  name = "NAME_OF_YOUR_APP"
)
```

This OAuth2 client can now be used to the various functions in the
package that require an OAuth2 client for authentication for making
requests to the ICD API.

### Performing a basic search

The main feature of the ICD API is the ability to search ICD 11
Foundation and ICD 11 Linearization for information regarding an
illness/disease. This feature is captured by the `icd_search` functions.
For example, if *colorectal cancer* is the disease of interest and
information available from ICD 11 is needed, the following call can be
made:

``` r
icd_search("colorectal cancer", client = my_oauth_client)
```

which gives the following output:

    #> Release `2024-01` matches a known release for ICD-11.
    #> Language `en` is available for the release specified.
    #> # A tibble: 18 × 19
    #>    id                title stemId isLeaf postcoordinationAvai…¹ hasCodingNote
    #>  * <chr>             <chr> <chr>  <lgl>                   <int> <lgl>        
    #>  1 http://id.who.in… Mali… http:… TRUE                        1 FALSE        
    #>  2 http://id.who.in… Mali… http:… TRUE                        1 FALSE        
    #>  3 http://id.who.in… Mali… http:… TRUE                        1 FALSE        
    #>  4 http://id.who.in… Mali… http:… TRUE                        1 FALSE        
    #>  5 http://id.who.in… Mali… http:… TRUE                        1 FALSE        
    #>  6 http://id.who.in… Mali… http:… TRUE                        1 FALSE        
    #>  7 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #>  8 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #>  9 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 10 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 11 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 12 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 13 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 14 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 15 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 16 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 17 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> 18 http://id.who.in… Othe… http:… TRUE                        1 FALSE        
    #> # ℹ abbreviated name: ¹​postcoordinationAvailability
    #> # ℹ 13 more variables: hasMaternalChapterLink <lgl>,
    #> #   hasPerinatalChapterLink <lgl>, matchingPVs <named list>,
    #> #   propertiesTruncated <lgl>, isResidualOther <lgl>,
    #> #   isResidualUnspecified <lgl>, chapter <chr>, theCode <chr>, score <dbl>,
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
#>   Anita Makori, Ernest Guevarra (2024). _codigo: Interface to the
#>   International Classification of Diseases (ICD) API_. R package
#>   version 0.0.9000, <https://oxford-ihtm.io/codigo/>.
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
