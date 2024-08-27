#' @export
project_init <- function(packages = NULL) {
  # renv::init()
  install.packages(c(
    packages,
    "tidyverse",
    "marginaleffects",
    "modelsummary",
    "pak"
  ))
  pak::pak("aleksanderbl29/dawaR")
  # pak::pak("aleksanderbl29/aleksandeR")
  pak::pak("gadenbuie/rsthemes")
}
