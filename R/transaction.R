#' Get transaction history
#'
#' Get transaction history
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/transaction-history/#getTransactionHistory}
#'
#' @param max_id The first transaction to get. The server will return transactions with id less than or equal to this, in descending order.
#' @param min_id The last transaction to get. The server will return transactions with id greater or equal to this, in descending order.
#' @param count The maximum number of transactions to return. The maximum value that can be specified is 500.
#'   By default, if count is not specified, a maximum of 50 transactions will be fetched. Note: Transactions requests with the count parameter specified is rate limited to 1 per every 60 seconds.
#' @param instrument Retrieve transactions for a specific instrument only. Default: all.
#' @param ids An URL encoded comma (%2C) separated list of transaction ids to retrieve. Maximum number of ids: 50. No other parameter may be specified with the ids parameter.
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default.
#'
#' @export
transaction_history <- function(oanda, max_id=NULL, min_id=NULL, count=NULL, instrument=NULL, ids=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/transactions", account_id_inner(oanda, account_id))
  query <- list(maxId=max_id, minId=min_id, count=count, instrument=instrument, ids=ids)
  request(oanda, endpoint, method=GET, params=list(query=query))

}

#' Get information for a transaction
#'
#' Get information for a transaction
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/transaction-history/#getInformationForTransaction}
#'
#' @param string. transaction ID
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default.
#'
#' @export
transaction_information <- function(oanda, transaction_id, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/transactions/%s", account_id_inner(oanda, account_id), transaction_id)
  request(oanda, endpoint)
}

#' Get full account history
#'
#' Get full account history
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/transaction-history/#getFullAccountHistory}
#'
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default.
#'
#' @export
transaction_history_all <- function(oanda, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/alltransactions", account_id_inner(oanda, account_id))
  response <- GET(oanda, endpoint, list(body=NULL, query=NULL))
  httr::headers(response)$location
}
