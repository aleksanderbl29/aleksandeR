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
