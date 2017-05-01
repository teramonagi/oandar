#' Get transaction history
#'
#' @param max_id Optional The first transaction to get. The server will return transactions with id less than or equal to this, in descending order.
#' @param min_id Optional The last transaction to get. The server will return transactions with id greater or equal to this, in descending order.
#' @param count Optional The maximum number of transactions to return. The maximum value that can be specified is 500. By default, if count is not specified, a maximum of 50 transactions will be fetched. Note: Transactions requests with the count parameter specified is rate limited to 1 per every 60 seconds.
#' @param instrument Optional Retrieve transactions for a specific instrument only. Default: all.
#' @param ids Optional An URL encoded comma (%2C) separated list of transaction ids to retrieve. Maximum number of ids: 50. No other parameter may be specified with the ids parameter.
#' @export
transaction_history <- function(oanda, max_id=NULL, min_id=NULL, count=NULL, instrument=NULL, ids=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/transactions", account_id_inner(oanda, account_id))
  query <- list(maxId=max_id, minId=min_id, count=count, instrument=instrument, ids=ids)
  request(oanda, endpoint, method=GET, params=list(query=query))

}
#' @export
transaction_information <- function(oanda, transaction_id, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/transactions/%s", account_id_inner(oanda, account_id), transaction_id)
  request(oanda, endpoint)
}
