# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

library(rvest)
library(httr)
library("jsonlite")
function(domain="api-fxpractice.oanda.com")
{
  url <- paste0("https://", domain, "/v1/accounts")
  httr::GET(url)


}
header <- function(token)
{
  add_headers("Authorization"=paste0("Bearer ", token))
}

account <- function(token, domain="api-fxpractice.oanda.com"){
  url <- paste0("https://", domain, "/v1/accounts")
  response <- httr::GET(url, header(token))
  status <- http_status(response)
  fromJSON(httr::content(response, "text"))[[1]]
}

account_information <- function(account_id, token, domain="api-fxpractice.oanda.com")
{
  url <- paste0("https://", domain, "/v1/accounts/", accound_id)
  response <- httr::GET(url, header(token))
  status <- http_status(response)
  as.data.frame(httr::content(response))
}
