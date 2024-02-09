
<!-- README.md is generated from README.Rmd. Please edit that file -->

# icd: Interface to the International Classification of Diseases (ICD) API

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The [International Classification of Diseases
(ICD)](https://www.who.int/standards/classifications/classification-of-diseases)
serves a broad range of uses globally and provides critical knowledge on
the extent, causes and consequences of human disease and death worldwide
via data that is reported and coded with the ICD. [ICD
API](https://icd.who.int/icdapi) allows programmatic access to the ICD.
It is an HTTP based REST API. This package provides functions that
interface with the ICD API.

## What does `icd` do?

## Installation

`icd` is not yet on CRAN.

You can install the development version of `icd` from
[GitHub](https://github.com/OxfordIHTM/icd) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("OxfordIHTM/icd")
```

then load `icd`

``` r
# load package
library(icd)
```

## Usage

## Citation

If you find the `icd` package useful please cite using the suggested
citation provided by a call to the `citation()` function as follows:

``` r
citation("icd")
#> To cite icd in publications use:
#> 
#>   Anita Makori and Ernest Guevarra (2024). icd: Interface to the
#>   International Classification of Diseases (ICD) API. R package version
#>   0.0.9000. URL https://oxford-ihtm.io/icd/
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {icd: Interface to the International Classification of Diseases (ICD) API},
#>     author = {{Anita Makori} and {Ernest Guevarra}},
#>     year = {2024},
#>     note = {R package version 0.0.9000},
#>     url = {https://oxford-ihtm.io/icd/},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/OxfordIHTM/icd/issues). If you
would like to contribute to the package, please see our [contributing
guidelines](https://oxford-ihtm.io/icd/CONTRIBUTING.html).

This project is released with a [Contributor Code of
Conduct](https://OxfordIHTM/codeditr/CODE_OF_CONDUCT.html). By
participating in this project you agree to abide by its terms.
