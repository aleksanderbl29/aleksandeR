#' List of parties up for election
#'
#' @returns Returns a tibble with information on the major parties up for election
#' @export
#'
#' @source https://www.valg.im.dk/partier-og-kandidater/opstillingsberettigede-partiers-adresser-mv
#'
#' @examples
#' head(parties)
parties <- tibble::tibble(
  party_code = c("A", "B", "C", "F", "I", "M", "O", "V", "Æ", "Ø", "Å", "H"),
  party_name = c("Socialdemokratiet", "Radikale Venstre", "Det Konservative Folkeparti", "Socialistisk Folkeparti", "Liberal Alliance", "Moderaterne", "Dansk Folkeparti", "Venstre, Danmarks Liberale Parti", "Danmarksdemokraterne - Inger Støjberg", "Enhedslisten - De Rød-Grønne", "Alternativet", "Borgernes Parti - Lars Boje Mathiesen"),
  party_name_short = c("Socialdemokratiet", "Radikale Venstre", "Det Konservative Folkeparti", "Socialistisk Folkeparti", "Liberal Alliance", "Moderaterne", "Dansk Folkeparti", "Venstre", "Danmarksdemokraterne", "Enhedslisten", "Alternativet", "Borgernes Parti"),
  party_color = c("#f04d46", "#EC008C", "#00583C", "#C4151C", "#F0B440", "#5B0864", "#10355A", "#00639E", "#184079", "#D0014E", "#00FF00", "#2C71FE")
)
