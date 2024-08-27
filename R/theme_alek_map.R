#' A theme made for maps from  `ggplot2::geom_map()`.
#'
#' This theme is made specifically for maps made with. A color-ready version exists as `theme_map_color()`.
#'
#' @inheritParams ggplot2::theme_grey
#'
#' @importFrom ggplot2 %+replace% element_blank unit theme theme_bw
#'
#' @export
theme_map <- function(base_size = 9, base_family = "") {
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank(),
      panel.grid = element_blank(),
      panel.spacing = unit(0, "lines"),
      plot.background = element_blank(),
      legend.justification = c(0, 0),
      legend.position = c(0, 0)
    )
}

#' A color-ready theme made for maps from `ggplot2::geom_map()`.
#'
#' This theme is made color-ready specifically for maps.
#'
#' @inheritParams ggplot2::theme_grey
#' @param color The primary color of the `theme_map_color()` plot. "Default is
#'   "green".
#' @param secondary_color The secondary color of the `theme_map_color()` plot.
#'   Default is "pink".
#' @param background_color The primary color of the `theme_map_color()` plot.
#'   Defaults is "black".
#'
#' @importFrom ggplot2 %+replace% element_blank unit theme theme_bw
#'
#' @export
theme_map_color <- function(color = "green",
                              secondary_color = "pink",
                              background_color = "black",
                              base_size = 9, base_family = "") {
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank(),
      panel.grid = element_blank(),
      panel.spacing = unit(0, "lines"),
      plot.background = element_blank(),
      legend.justification = c(0, 0),
      legend.position = c(0, 0)
    )
}

