
<!-- README.md is generated from README.Rmd. Please edit that file -->

# aleksandeR

<!-- badges: start -->

[![R-CMD-check](https://github.com/aleksanderbl29/aleksandeR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/aleksanderbl29/aleksandeR/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/aleksanderbl29/aleksandeR/graph/badge.svg?token=FIXGM13TQF)](https://codecov.io/gh/aleksanderbl29/aleksandeR)
<!-- badges: end -->

This package exists to make my personal convenience functions portable
and easy to share.

## Installation

You can install the development version of aleksandeR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aleksanderbl29/aleksandeR")
```

## Development

This package is built with the instructions from the great package-book
[R Packages (2e)](https://r-pkgs.org)

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(aleksandeR)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
