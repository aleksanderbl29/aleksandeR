#' @export
prepare_classes <- function(classes) {
  if (!exists("classes")) {
    cli::cli_abort("Please provide classes")
  }
  classes <- paste(seq_along(classes), "-", classes)

  classes <- stringr::str_replace_all(classes, ": ", " - ")
  classes <- stringr::str_replace_all(classes, ":", "-")
  classes <- stringr::str_replace_all(classes, " :", " -")

  for (i in seq_along(classes)) {
    dir.create(paste0("../", classes[i]))
  }
}

use_r_w_course <- function(shortname = "pwd") {
  if (shortname == "pwd") {
    name <- paste("R -", basename(getwd()))
  } else {
    name <- shortname
  }

  list.files()
  usethis::create_project(name)

  return(name)
}
