#' @export
project_init <- function(packages = NULL) {
  # renv::init()
  install.packages(c(
    packages,
    "tidyverse",
    "pak"
  ))
  pak::pak("aleksanderbl29/dawaR")
  # pak::pak("aleksanderbl29/aleksandeR")
  pak::pak("gadenbuie/rsthemes")
}

#' @export
install_basic_packages <- function(additional_packages = NULL) {

  # Vector of package names
  packages <- c(
    "tidyverse",
    "marginaleffects",
    "modelsummary",
    "wesanderson",
    "here",
    "foghorn",
    additional_packages)

  # Loop through the vector, check if installed, and install if missing
  for (pkg in packages) {
    if (!suppressPackageStartupMessages(require(pkg, character.only = TRUE))) {
      cli::cli_alert_info("Installing {.var {pkg}}")
      install.packages(pkg)
    } else {
      cli::cli_alert_success("{.var {pkg}} is already installed")
    }
  }

  install.packages(
    "rsthemes",
    repos = c(
      gadenbuie = 'https://gadenbuie.r-universe.dev',
      getOption("repos"))
  )

  install.packages(
    "dawaR",
    repos = c(
      "https://aleksanderbl29.r-universe.dev",
      "https://cloud.r-project.org"
    )
  )

}
