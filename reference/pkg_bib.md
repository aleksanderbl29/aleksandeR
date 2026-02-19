# Create bibliography of `{renv}`-installed packages

This was inspired by https://github.com/rstudio/renv/issues/340

## Usage

``` r
pkg_bib(dependencies = FALSE, filename = "packages.bib", targets = FALSE)
```

## Arguments

- dependencies:

  Boolean to define how many packages are cited.

- filename:

  Specify a filename/path for the `.bib`.

- targets:

  Boolean to define if the bibliography should be created based on the
  packages defined in a targets pipeline and saved to
  `_targets_packages.R` by the function `targets::tar_renv()`

## Value

Usually called for its side effect of a `.bib` written to the provided
paths. Also outputs the package names in the console.
