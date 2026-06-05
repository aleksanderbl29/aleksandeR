#' Get character count from `ggplot2` object.
#'
#' Counts the number of characters in visible text elements from a `ggplot2`
#' plot. This also supports plots composed with `patchwork`, including collected
#' guides.
#'
#' @param plot Input a `ggplot2` object or a `patchwork` object.
#' @param debug Logical. If `TRUE`, prints the text values that are counted.
#'
#' @returns Returns an integer with the amount of characters in the plot.
#'   Spaces are included.
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
plot_nchar <- function(plot, debug = FALSE) {
  if (inherits(plot, "patchwork")) {
    return(count_patchwork_nchar(plot, debug = debug))
  }

  count_normal_ggplot_nchar(plot, debug = debug)
}


# Clean and flatten text values ------------------------------------------------

clean_plot_text <- function(x) {
  # Flatten nested lists while preserving character values
  x <- unlist(x, use.names = TRUE)

  # Remove missing values
  x <- x[!is.na(x)]

  # Convert to character and remove empty strings
  x <- as.character(x)
  x <- x[nzchar(x)]

  return(x)
}


count_plot_text <- function(x) {
  # Count characters in cleaned text values
  x <- clean_plot_text(x)

  sum(nchar(x), na.rm = TRUE)
}


debug_plot_text <- function(x) {
  # Create a debug data frame showing each counted text value
  x <- clean_plot_text(x)

  source_names <- names(x)

  if (is.null(source_names)) {
    source_names <- rep("unnamed", length(x))
  }

  source_names[is.na(source_names) | source_names == ""] <- "unnamed"

  data.frame(
    source = source_names,
    text = unname(x),
    nchar = nchar(unname(x)),
    row.names = NULL
  )
}


print_debug_plot_text <- function(x, label = NULL) {
  # Print counted text values and their character total
  debug_data <- debug_plot_text(x)

  if (!is.null(label)) {
    message(label)
  }

  print(debug_data)

  message("Count: ", sum(debug_data$nchar, na.rm = TRUE))
}


# Count ordinary ggplot objects -------------------------------------------------

get_normal_layer_text <- function(built_plot) {
  # Extract text from geom_text() and geom_label() layers.
  # This follows the original logic and deduplicates layer vectors with unique().
  text_layers <- lapply(built_plot$data, function(layer) {
    if ("label" %in% names(layer)) {
      return(layer$label)
    }

    NULL
  }) |>
    unique()

  unlist(text_layers[!sapply(text_layers, is.null)])
}


get_normal_axis_text <- function(built_plot) {
  # Extract axis tick labels from the first panel, following the original logic.
  list(
    x_axis_text = built_plot$layout$panel_params[[1]]$x$get_labels(),
    y_axis_text = built_plot$layout$panel_params[[1]]$y$get_labels()
  )
}


get_normal_ggplot_text <- function(plot) {
  # Build plot to access layer data and axis tick labels
  built_plot <- ggplot2::ggplot_build(plot)

  # Get plot labels such as title, subtitle, and axis labels
  labels <- plot$labels

  list(
    geom_text = get_normal_layer_text(built_plot),
    title = labels$title,
    subtitle = labels$subtitle,
    x_label = labels$x,
    y_label = labels$y,
    caption = labels$caption,
    axis_text = get_normal_axis_text(built_plot)
  )
}


count_normal_ggplot_nchar <- function(plot, debug = FALSE) {
  # Count text in an ordinary ggplot using the original counting logic
  text <- get_normal_ggplot_text(plot)

  if (debug) {
    print_debug_plot_text(
      text,
      label = "Text counted for ggplot:"
    )
  }

  count_plot_text(text)
}


# Extract guide text for patchwork objects -------------------------------------

get_patchwork_guide_text_from_plot <- function(plot) {
  # Build plot to access trained scales
  built_plot <- tryCatch(
    ggplot2::ggplot_build(plot),
    error = function(e) NULL
  )

  if (is.null(built_plot)) {
    return(list())
  }

  # Use trained scales from the built plot when available
  scales <- tryCatch(
    built_plot$plot$scales$scales,
    error = function(e) plot$scales$scales
  )

  plot_labels <- tryCatch(plot$labels, error = function(e) list())

  lapply(scales, function(scale) {
    aesthetics <- tryCatch(scale$aesthetics, error = function(e) NULL)

    # Position scales are counted through axis labels instead
    is_position <- any(aesthetics %in% c(
      "x", "y", "xmin", "xmax", "ymin", "ymax"
    ))

    if (is_position) {
      return(NULL)
    }

    breaks <- tryCatch(scale$get_breaks(), error = function(e) NULL)
    labels <- tryCatch(scale$get_labels(breaks), error = function(e) NULL)

    scale_name <- tryCatch(scale$name, error = function(e) NULL)

    # If the scale has no useful name, get the guide title from labs()
    if (
      is.null(scale_name) ||
        length(scale_name) == 0 ||
        inherits(scale_name, "waiver") ||
        is.na(scale_name) ||
        identical(scale_name, "")
    ) {
      scale_name <- NULL

      for (aesthetic in aesthetics) {
        candidate <- plot_labels[[aesthetic]]

        if (!is.null(candidate) && !inherits(candidate, "waiver")) {
          scale_name <- candidate
          break
        }
      }
    }

    list(
      guide_title = scale_name,
      guide_labels = labels
    )
  })
}


get_patchwork_guide_text <- function(plots) {
  # Extract guide text from all patchwork subplots
  guide_text <- lapply(plots, get_patchwork_guide_text_from_plot)

  guide_text <- clean_plot_text(guide_text)

  # When patchwork collects guides, guide text should only be counted once
  unique(guide_text)
}


# Extract and count patchwork objects ------------------------------------------

get_patchwork_plots <- function(plot) {
  # Child plots added to the patchwork
  child_plots <- tryCatch(plot$patches$plots, error = function(e) list())

  # The root plot is not always included in plot$patches$plots
  root_plot <- plot
  class(root_plot) <- setdiff(class(root_plot), "patchwork")

  c(list(root_plot), child_plots)
}


count_patchwork_annotation_nchar <- function(plot) {
  # Extract text from patchwork::plot_annotation()
  annotation <- tryCatch(plot$patches$annotation, error = function(e) NULL)

  if (is.null(annotation)) {
    return(0)
  }

  count_plot_text(list(
    title = annotation$title,
    subtitle = annotation$subtitle,
    caption = annotation$caption,
    tag_prefix = annotation$tag_prefix,
    tag_suffix = annotation$tag_suffix,
    tag_sep = annotation$tag_sep
  ))
}


count_patchwork_nchar <- function(plot, debug = FALSE) {
  plots <- get_patchwork_plots(plot)

  # Count each subplot using the ordinary ggplot logic.
  # Guides are not counted here, because patchwork may collect them.
  plot_total <- sum(vapply(
    plots,
    count_normal_ggplot_nchar,
    numeric(1),
    debug = debug
  ))

  # Count shared patchwork guide text once
  guide_text <- get_patchwork_guide_text(plots)
  guide_total <- sum(nchar(guide_text), na.rm = TRUE)

  if (debug) {
    message("Guide text counted once:")
    print(data.frame(
      text = guide_text,
      nchar = nchar(guide_text),
      row.names = NULL
    ))
    message("Guide count: ", guide_total)
  }

  # Count patchwork-level annotations
  annotation_total <- count_patchwork_annotation_nchar(plot)

  if (debug) {
    message("Patchwork annotation count: ", annotation_total)
    message("Patchwork total: ", plot_total + guide_total + annotation_total)
  }

  plot_total + guide_total + annotation_total
}