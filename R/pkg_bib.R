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
pkg_bib <- function(
    dependencies = FALSE,
    filename = "packages.bib",
    targets = FALSE
    ) {
  if (targets) {
    targets_bib()
  }

  if (!dependencies) {
    pkgs <- simple_bib()
  } else if (dependencies) {
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

  # Find library calls using regex
  # Matches patterns like: library(package) or library("package")
  library_pattern <- "^\\s*library\\(([\"\']?)([[:alnum:].]+)\\1\\)"
  pkg_matches <- regexec(library_pattern, pkg_file)

  # Extract package names from matches
  pkgs <- character(0)
  for (i in seq_along(pkg_matches)) {
    match <- pkg_matches[[i]]
    if (match[1] != -1) {
      # Group 2 contains the package name
      pkg_name <- substr(pkg_file[i],
                         match[3],
                         match[3] + attr(match, "match.length")[3] - 1)
      pkgs <- c(pkgs, pkg_name)
    }
  }
  return(pkgs)
}
