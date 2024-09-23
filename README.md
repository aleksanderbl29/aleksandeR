
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
library(aleksandeR)
```

## Functions

The functions of this package all belong to one of the following types:

1.  Formatting/output (great for Quarto or Rmarkdown)
2.  ggplot themes
3.  Wrappers for functions from other packages that I use frequently

### Formatting and output

I currently have `format_num()` that formats numbers in a way that
conforms to nothern european number presentation standards.

### Themes for ggplot2

All my custom themes are very close to either `ggplot2::theme_minimal()`
or `cowplot::theme_cowplot()` but have my own twists and personal
defaults integrated. The themes are created for each type of plot and
can be called individually or through the aptly named
`theme_aleksander()`.

### Wrappers

I currently don’t have any functions in this category - But i plan to!

## Development

This package is built with the instructions from the great package-book
[R Packages (2e)](https://r-pkgs.org).

For the themes I try to do test-driven development. It was first
introduced to me in the great video series by [Pat
Schloss](https://www.schlosslab.org/labbies/schloss.html). Take a look
if you’re interested. [Video
link](https://www.youtube.com/watch?v=TaNvqwMmHus)
