#' Format a number for presentation
#'
#' @param x An integer/double value
#' @param big.mark The character that divides numbers in thousands
#' @param decimal.mark The decimal separator
#'
#' @return A number formatted correctly with two (default) decimals, a comma as the decimal separator and a period as the thousand-separator.
#' @export
#'
#' @examples
#' x <- pi
#' nm_fm(x)
#'
nm_fm <- function(x, big.mark = ".", decimal.mark = ",") {
  format(round(x, 2), big.mark = big.mark, decimal.mark = decimal.mark, scientific = FALSE)
}
