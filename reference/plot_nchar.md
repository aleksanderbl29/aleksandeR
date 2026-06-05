# Get character count from `ggplot2` object.

Counts the number of characters in visible text elements from a
`ggplot2` plot. This also supports plots composed with `patchwork`,
including collected guides.

## Usage

``` r
plot_nchar(plot, debug = FALSE)
```

## Arguments

- plot:

  Input a `ggplot2` object or a `patchwork` object.

- debug:

  Logical. If `TRUE`, prints the text values that are counted.

## Value

Returns an integer with the amount of characters in the plot. Spaces are
included.

## Examples

``` r
plot <- data.frame(
  x = seq(1, 10),
  y = seq(10, 1),
  label = rep(seq(1, 10, 2), 2)
  ) |>
  ggplot2::ggplot(ggplot2::aes(x = x, y = y, label = label)) +
  ggplot2::geom_text(nudge_y = 3)

plot_nchar(plot)
#> [1] 30
```
