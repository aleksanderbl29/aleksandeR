#' Format a number for presentation
#'
#' @param x An integer/double value.
#' @param decimals The amount of decimals the input x should be rounded to.
#' @param rounding Whether or not the input x should be rounded. Excludes the use of the decimals argument.
#' @param big_mark The thousand separator.
#' @param decimal_mark The decimal separator.
#'
#' @return A number formatted correctly with two (default) decimals, a comma as the decimal separator and a period as the thousand-separator. The type is *characther*.
#' @export
#'
#' @examples
#' x <- pi
#' format_num(x)
#'
#' format_num(x, 1)
#'
#' format_num(x, rounding = FALSE)
#'
format_num <- function(x, decimals = 2, rounding = TRUE, big_mark = ".", decimal_mark = ",") {

  if (is.numeric(x)) {
    # No error
  } else if (is.character(x)) {
    stop("Input x is of type character")
  } else if (is.data.frame(x)) {
    stop("Input x is a data.frame")
  }

  if (decimals != 2 & rounding == FALSE) {
    stop("Cannot round to given amount of decimals when rounding is off. The options are mutually exclusive.")
  }

  if (rounding == TRUE) {
    x <- round(x, decimals)
  } else if (rounding == FALSE) {
    x <- x
  }

  x <- format(x, big.mark = big_mark, decimal.mark = decimal_mark, scientific = FALSE)

  return(x)
}


old_fm_nm <- function(x, decimals = 2, big.mark = ".", decimal.mark = ",") {
  format(round(x, decimals), big.mark = big.mark, decimal.mark = decimal.mark, scientific = FALSE)
}
