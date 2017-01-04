#' Get an instrument list
#'
#' Get a list of tradeable instruments (currency pairs, CFDs, and commodities)
#'that are available for trading with the account specified.
#'
#' @export
instrument_list <- function(account_id, instruments, token, domain="api-fxpractice.oanda.com")
{
  query <- list(accountId = account_id, instruments=paste(instruments, collapse=","))
  url <- paste0("https://", domain, "/v1/instruments")
  response <- httr::GET(url, header(token), query=query)
  status <- http_status(response)
  fromJSON(httr::content(response, "text"))[[1]]
}

#' @export
current_price <- function(instruments, token, domain="api-fxpractice.oanda.com")
{
  query <- list(instruments=paste(instruments, collapse=","))
  url <- paste0("https://", domain, "/v1/prices")
  response <- httr::GET(url, header(token), query=query)
  status <- http_status(response)
  fromJSON(httr::content(response, "text"))[[1]]
}

#' @export
instrument_history <- function(instruments, count, start, end, candleFormat, token, domain){
}
