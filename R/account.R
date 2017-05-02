#' Get accounts for a user
#'
#' Get a list of accounts owned by the user
#'
#' @export
accounts <- function(oanda){
  endpoint <- "/v1/accounts"
  request(oanda, endpoint)
}

#' Get account information
#'
#' @export
account_information <- function(oanda, account_id=NULL)
{
  endpoint <- paste0("/v1/accounts/", account_id_inner(oanda, account_id))
  request(oanda, endpoint)
}
