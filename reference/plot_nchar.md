# Get character count from `ggplot2` object.

Get character count from `ggplot2` object.

## Usage

``` r
plot_nchar(plot)
```

## Arguments

- plot:

  Input a `ggplot2` object

## Value

Returns a integer with the amount of characters in the plot. This is
excluding spaces.

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
