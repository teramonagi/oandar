#' Get accounts for a user
#'
#' Get a list of accounts owned by the user
#'
#' @export
accounts <- function(token, domain="api-fxpractice.oanda.com"){
  url <- paste0("https://", domain, "/v1/accounts")
  response <- httr::GET(url, header(token))
  status <- http_status(response)
  fromJSON(httr::content(response, "text"))[[1]]
}

#' Get account information
#'
#' @export
account_information <- function(account_id, token, domain="api-fxpractice.oanda.com")
{
  url <- paste0("https://", domain, "/v1/accounts/", account_id)
  response <- httr::GET(url, header(token))
  status <- http_status(response)
  as.data.frame(httr::content(response))
}
