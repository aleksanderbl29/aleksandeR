# Format a number for presentation

Format a number for presentation

## Usage

``` r
format_num(
  x,
  decimals = 2,
  rounding = TRUE,
  big_mark = ".",
  decimal_mark = ","
)
```

## Arguments

- x:

  An integer/double value.

- decimals:

  The amount of decimals the input x should be rounded to.

- rounding:

  Whether or not the input x should be rounded. Excludes the use of the
  decimals argument.

- big_mark:

  The thousand separator.

- decimal_mark:

  The decimal separator.

## Value

A number formatted correctly with two (default) decimals, a comma as the
decimal separator and a period as the thousand-separator. The type is
*characther*.

## Examples

``` r
x <- pi
format_num(x)
#> [1] "3,14"

format_num(x, 1)
#> [1] "3,1"

format_num(x, rounding = FALSE)
#> [1] "3,141593"
```
