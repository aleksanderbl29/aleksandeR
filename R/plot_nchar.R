#' Get character count from `ggplot2` object.
#'
#' @param plot Input a `ggplot2` object
#'
#' @returns Returns a integer with the amount of characters in the plot
#' @export
#'
#' @examples
#' plot <- data.frame(
#'   x = seq(1, 10),
#'   y = seq(10, 1),
#'   label = rep(seq(1, 10, 2), 2)
#'   ) |>
#'   ggplot2::ggplot(ggplot2::aes(x = x, y = y, label = label)) +
#'   ggplot2::geom_text(nudge_y = 3)
#'
#' plot_nchar(plot)
plot_nchar <- function(plot) {
  # Extract built plot
  built_plot <- ggplot2::ggplot_build(plot)

  # Get text from geom_text/geom_label layers
  text_layers <- lapply(built_plot$data, function(layer) {
    if("label" %in% names(layer)) {
      return(layer$label)
    }
    NULL
  }) |> unique()

  text_layers <- unlist(text_layers[!sapply(text_layers, is.null)])

  # Get plot labels (title, axis labels, etc)
  labels <- plot$labels

  # Get axis text
  x_text <- built_plot$layout$panel_params[[1]]$x$get_labels()
  y_text <- built_plot$layout$panel_params[[1]]$y$get_labels()

  # Combine all text elements
  all_text <- list(
    geom_text = text_layers,
    title = labels$title,
    subtitle = labels$subtitle,
    x_label = labels$x,
    y_label = labels$y,
    caption = labels$caption,
    x_axis_text = x_text,
    y_axis_text = y_text
  ) |>
    unlist() |>
    nchar() |>
    sum(na.rm = TRUE)

  return(all_text)
}
