#' Create bibliography of `{renv}`-installed packages
#'
#' @param dependencies Boolean to define how many packages are cited.
#' @param filename Specify a filename/path for the `.bib`.
#'
#' @description This was inspired by https://github.com/rstudio/renv/issues/340
#'
#' @returns Usually called for its side effect of a `.bib` written to the
#'   provided paths. Also outputs the package names in the console.
#'
#' @export
pkg_bib <- function(dependencies = FALSE, filename = "packages.bib") {
  if (dependencies == FALSE) {
    pkgs <- simple_bib()
  } else if (dependencies == TRUE) {
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
