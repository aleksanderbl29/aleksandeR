#' Create bibliography of `{renv}`-installed packages
#'
#' @param dependencies Boolean to define how many packages are cited.
#' @param filename Specify a filename/path for the `.bib`.
#' @param targets Boolean to define if the bibliography should be created based
#'   on the packages defined in a targets pipeline and saved to
#'   `_targets_packages.R` by the function `targets::tar_renv()`
#'
#' @description This was inspired by https://github.com/rstudio/renv/issues/340
#'
#' @returns Usually called for its side effect of a `.bib` written to the
#'   provided paths. Also outputs the package names in the console.
#'
#' @export
pkg_bib <- function(
    dependencies = FALSE,
    filename = "packages.bib",
    targets = FALSE
    ) {

  pkgs <- NULL

  if (targets) {
    pkgs <- targets_bib()
  }

  if (!dependencies && is.null(pkgs)) {
    pkgs <- simple_bib()
  } else if (dependencies && is.null(pkgs)) {
    pkgs <- dependency_bib()
  }
  print_bib(pkgs = pkgs, filename = filename)
  cli::cli_alert("Creating file {.file {filename}}")
  cli::cli_alert_info("It includes: ")
  return(pkgs)
}

simple_bib <- function() {
  deps <- renv::dependencies()
  pkgs <- setdiff(unique(deps$Package), "R")
  return(pkgs)
}

dependency_bib <- function() {
  renvLock <- jsonlite::read_json("renv.lock")
  pkgs <- names(renvLock$Packages)
  return(pkgs)
}

print_bib <- function(pkgs, filename = "packages.bib") {
  bibtex::write.bib(entry = pkgs, file = filename, append = FALSE)
}

targets_bib <- function() {
  # Check if targets packages file exists
  if (!file.exists("_targets_packages.R")) {
    cli::cli_alert_warning("File {.file _targets_packages.R} not found")
    return(character(0))
  }

  # Read the file content
  pkg_file <- readLines("_targets_packages.R")

  # Find lines that start with library
  library_lines <- grep("^library\\(", pkg_file, value = TRUE)

  # Extract package names from library calls
  # Remove "library(" and ")" from each line
  pkgs <- gsub("^library\\(|\\)$", "", library_lines)

  out <- c("targets", "tarchetypes", pkgs)

  return(out)
}
