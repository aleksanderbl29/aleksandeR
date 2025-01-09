test_that("plot_nchar correctly extracts text", {
  df_1 <- data.frame(
    x = seq(20, 11),
    y = seq(11, 20),
    label = rep(seq(11, 15), 2)
  )

  plot <- data.frame(
    x = seq(1, 10),
    y = seq(10, 1),
    label = rep(seq(1, 10, 2), 2)
  ) |>
    ggplot2::ggplot(ggplot2::aes(x = x, y = y, label = label)) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::geom_text(nudge_y = 3) +
    ggplot2::geom_text(data = df_1) +
    ggplot2::annotate("text", x = c(3, 8), y = c(3, 8),
                      label = c("Hej", "Farvel til dig"))
  expect_equal(63, plot_nchar(plot))
})
