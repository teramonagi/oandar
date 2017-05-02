#' oandar
#'
#' R wrapper for the OANDA REST API
#'
#' @name oandar
#' @docType package
#' @import httr jsonlite stringr lubridate
NULL

#' Generate OANDA class object for a connection to OANDA
#'
#' Generate OANDA class object for a connection to OANDA
#'
#' @param token A personal access token given by OANDA. See http://developer.oanda.com/rest-live/authentication/
#' @param account_type "practice" or "trade". Specify the subdomain for the request (fxTrade Practice(api-fxpractice.oanda.com) or fxTrade(api-fxtrade.oanda.com))
#' @export
generate_oanda <- function(token, account_type)
{
  result <- list(token=token, account_type=account_type, domain=domain(account_type))
  class(result) <- "OANDA"
  #Initialize account_id with the first entry in the accounts
  result$account_id <- accounts(result)$account_id[1]
  result
}
