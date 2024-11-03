#' Create bibliography of `{renv}`-installed packages
#' @description This was inspired by https://github.com/rstudio/renv/issues/340
#' @export
pkg_bib <- function(dependencies = FALSE, filename = "renv_packages.bib") {
  if (dependencies == FALSE) {
    pkgs <- simple_bib()
  } else if (dependencies == TRUE) {
    pkgs <- dependency_bib()
  }
  cli::cli_alert("Creating file pkg_references.bib")
  print_bib(pkgs = pkgs, filename = filename)
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

print_bib <- function(pkgs, filename = "renv_packages.bib") {
  bibtex::write.bib(entry = pkgs, file = "renv_packages.bib", append = FALSE)
}
