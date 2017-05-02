#' oandar
#'
#' Wrapper of OANDA API
#'
#' @name oandar
#' @docType package
#' @import httr jsonlite stringr lubridate

#' @export
oanda_token <- function(token, account_type)
{
  result <- list(token=token, account_type=account_type, domain=domain(account_type))
  class(result) <- "oandar_token"
  #Initialize account_id with the first entry in the accounts
  result$account_id <- accounts(result)$account_id[1]
  result
}
