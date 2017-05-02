#' Get a list of open trades
#'
#' Get a list of open trades.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/trades/#getListOpenTrades}
#'
#' @param max_id The server will return trades with id less than or equal to this, in descending order (for pagination).
#' @param count Maximum number of open trades to return. Default: 50 Max value: 500
#' @param instrument Retrieve open trades for a specific instrument only Default: all
#' @param ids A (URL encoded) comma separated list of trades to retrieve. Maximum number of ids: 50. No other parameter may be specified with the ids parameter.
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

#' Get information on a specific trade
#'
#' Get information on a specific trade.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/trades/#getInformationSpecificTrade}
#' @param trade_id string. trade ID.
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default.
#'
#' @export
trade_information <- function(oanda, trade_id, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/trades/%s", account_id_inner(oanda, account_id), trade_id)
  request(oanda, endpoint)
}

#' Modify an existing trade
#'
#' Modify an existing trade.
#' Only the specified parameters will be modified.
#' All other parameters will remain unchanged.
#' To remove an optional parameter, set its value to 0.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/trades/#modifyExistingTrade}
#'
#' @param stopLoss Stop Loss value
#' @param takeProfit Take Profit value
#' @param trailing_stop Trailing Stop distance in pips, up to one decimal place
#'
#' @export
modify_trade <- function(oanda, trade_id, stop_loss=NULL, take_profit=NULL, trailing_stop=NULL, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/trades/%s", account_id_inner(oanda, account_id), trade_id)
  body <- list(stopLoss=stop_loss, takeProfit=take_profit, trailingStop=trailing_stop)
  request(oanda, endpoint, method=PATCH, params=list(body=body))
}

#' Close an open trade
#'
#' Close an open trade
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/trades/#closeOpenTrade}
#'
#' @param trade_id string. trade ID.
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default.
#'
#' @export
close_trade <- function(oanda, trade_id, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/trades/%s", account_id_inner(oanda, account_id), trade_id)
  request(oanda, endpoint, method=DELETE, params=list(body=NULL))
}
