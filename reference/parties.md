# List of parties up for election

List of parties up for election

## Usage

``` r
parties
```

## Format

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with 12
rows and 4 columns.

## Source

https://www.valg.im.dk/partier-og-kandidater/opstillingsberettigede-partiers-adresser-mv

## Value

Returns a tibble with information on the major parties up for election

## Examples

``` r
head(parties)
#> # A tibble: 6 × 4
#>   party_code party_name                  party_name_short            party_color
#>   <chr>      <chr>                       <chr>                       <chr>      
#> 1 A          Socialdemokratiet           Socialdemokratiet           #f04d46    
#> 2 B          Radikale Venstre            Radikale Venstre            #EC008C    
#> 3 C          Det Konservative Folkeparti Det Konservative Folkeparti #00583C    
#> 4 F          Socialistisk Folkeparti     Socialistisk Folkeparti     #C4151C    
#> 5 I          Liberal Alliance            Liberal Alliance            #F0B440    
#> 6 M          Moderaterne                 Moderaterne                 #5B0864    
```
