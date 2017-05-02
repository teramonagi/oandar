#' Get a list of open trades
#'
#' @param max_id Optional The server will return trades with id less than or equal to this, in descending order (for pagination).
#' @param count Optional Maximum number of open trades to return. Default: 50 Max value: 500
#' @param instrument Optional Retrieve open trades for a specific instrument only Default: all
#' @param ids Optional A (URL encoded) comma separated list of trades to retrieve. Maximum number of ids: 50. No other parameter may be specified with the ids parameter.
#' @export
trade_list <- function(oanda, max_id=NULL, count=NULL, instrument=NULL, ids=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/trades", account_id_inner(oanda, account_id))
  query <- list(
    maxId=max_id,
    count=count,
    instrument=instrument,
    ids=ids
  )
  request(oanda, endpoint, method=GET, params=list(query=query))
}

#' @export
trade_information <- function(oanda, trade_id, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/trades/%s", account_id_inner(oanda, account_id), trade_id)
  request(oanda, endpoint)
}

#' @export
modify_trade <- function(oanda, trade_id, stop_loss=NULL, take_profit=NULL, trailing_stop=NULL, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/trades/%s", account_id_inner(oanda, account_id), trade_id)
  body <- list(stopLoss=stop_loss, takeProfit=take_profit, trailingStop=trailing_stop)
  request(oanda, endpoint, method=PATCH, params=list(body=body))
}

#' @export
close_trade <- function(oanda, trade_id, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/trades/%s", account_id_inner(oanda, account_id), trade_id)
  request(oanda, endpoint, method=DELETE, params=list(body=NULL))
}
