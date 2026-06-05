test_that("plot_nchar correctly extracts text for normal plots", {
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
    ggplot2::annotate(
      "text",
      x = c(3, 8),
      y = c(3, 8),
      label = c("Hej", "Farvel til dig")
    )
  expect_equal(61, plot_nchar(plot))
})

test_that("plot_nchar correctly extracts text for advanced patchwork plots", {
  df_1 <- data.frame(
    x = c("Formand", "Næstformand", "Kommissær"),
    y = c(0.25, 0.50, 0.75),
    group = c("Neutral", "Rasende", "Neutral"),
    label = c("Lav", "Middel", "Høj")
  )

  df_2 <- data.frame(
    x = c("Formand", "Næstformand", "Kommissær"),
    y = c(2000, 4000, 6000),
    group = c("Neutral", "Rasende", "Neutral"),
    label = c("A", "B", "C")
  )

  plot_1 <- df_1 |>
    ggplot2::ggplot(
      ggplot2::aes(
        x = x,
        y = y,
        fill = group,
        label = label
      )
    ) +
    ggplot2::geom_col() +
    ggplot2::geom_text(nudge_y = 0.05) +
    ggplot2::scale_y_continuous(
      labels = scales::percent,
      breaks = c(0, 0.25, 0.50, 0.75, 1)
    ) +
    ggplot2::labs(
      x = NULL,
      y = "Andel taler",
      fill = "Retorisk kategori"
    )

  plot_2 <- df_2 |>
    ggplot2::ggplot(
      ggplot2::aes(
        x = x,
        y = y,
        fill = group,
        label = label
      )
    ) +
    ggplot2::geom_col() +
    ggplot2::geom_text(nudge_y = 300) +
    ggplot2::scale_y_continuous(
      breaks = c(0, 2000, 4000, 6000)
    ) +
    ggplot2::labs(
      x = NULL,
      y = "Antal taler",
      fill = "Retorisk kategori"
    )

  plot <- plot_1 + plot_2 +
    patchwork::plot_layout(guides = "collect") +
    patchwork::plot_annotation(
      title = "Samlet figur",
      subtitle = "Fordelt på rolle",
      caption = "Kilde: test"
    )

  expect_equal(185, plot_nchar(plot))
})

#"Samlet figurFordelt på rolle75%50%25%0%Andel talerLavHøjMiddelACBAntal taler0200040006000FormandKommissærNæstformandFormandKommissærNæstformandKilde: testRetorisk kategoriNeutralRasende" |> nchar()