#' Get orders for an account
#'
#' This function will return all pending orders for an account.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/orders/#getOrdersForAnAccount}
#'
#' @param max_id The server will return orders with id less than or equal to this, in descending order (for pagination).
#' @param count Maximum number of open orders to return. Default: 50. Max value: 500.
#' @param instrument Retrieve open orders for a specific instrument only. Default: all.
#' @param ids An URL encoded comma (%2C) separated list of orders to retrieve. Maximum number of ids: 50.
#'   No other parameter may be specified with the ids parameter.
#'
#' @export
orders <- function(oanda, max_id=NULL, count=NULL, instrument=NULL, ids=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders", account_id_inner(oanda, account_id))
  query <- list(maxId=max_id, count=count, instrument=instrument, ids=ids)
  request(oanda, endpoint, method=GET, params=list(query=query))
}

#' Create a new order
#'
#' Create a new order
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/orders/#createNewOrder}
#'
#' @param instrument Instrument to open the order on.
#' @param units The number of units to open order for.
#' @param side Direction of the order, either 'buy' or 'sell'.
#' @param type The type of the order 'limit', 'stop', 'marketIfTouched' or 'market'.
#' @param expiry If order type is 'limit', 'stop', or 'marketIfTouched'. The order expiration time in UTC. The value specified must be in a valid datetime format.
#' @param price If order type is 'limit', 'stop', or 'marketIfTouched'. The price where the order is set to trigger at.
#' @param lower_bound The minimum execution price.
#' @param upper_bound The maximum execution price.
#' @param stop_loss The stop loss price.
#' @param take_profit The take profit price.
#' @param trailing_stop The trailing stop distance in pips, up to one decimal place.
#'
#' @export
create_order <- function(oanda, instrument, units, side, type, expiry=NULL, price=NULL, lower_bound=NULL, upper_bound=NULL, stop_loss=NULL, take_profit=NULL, trailing_stop=NULL, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders", account_id_inner(oanda, account_id))
  body <- list(instrument=instrument,
               units=units,
               side=side,
               type=type,
               expiry=expiry, price=price)
  request(oanda, endpoint, method=POST, params=list(body=body))
}

#' Get information for an order
#'
#' Get information for an order.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/orders/#getInformationForAnOrder}
#'
#' @param order_id string. order ID.
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default (default value is \code{NULL}).
#'
#' @export
order_information <- function(oanda, order_id, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders/%s", account_id_inner(oanda, account_id), order_id)
  request(oanda, endpoint)
}

#' Modify an existing order
#'
#' Modify an existing order
#' Only the specified parameters will be modified.
#' All other parameters will remain unchanged.
#' To remove an optional parameter, set its value to 0.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/orders/#modifyExistingOrder}
#' @param units The number of units to open order for.
#' @param price The price at which the order is set to trigger at.
#' @param expiry The order expiration time in UTC. The value specified must be in a valid datetime format.
#' @param lower_bound The minimum execution price.
#' @param upper_bound The maximum execution price.
#' @param stop_loss The stop loss price.
#' @param take_profit The take profit price.
#' @param trailing_stop The trailing stop distance in pips, up to one decimal place.
#'
#' @export
modify_order <- function(oanda, order_id, units = NULL, expiry=NULL, price=NULL, lower_bound=NULL, upper_bound=NULL, stop_loss=NULL, take_profit=NULL, trailing_stop=NULL, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders/%s", account_id_inner(oanda, account_id), order_id)
  body <- list(units=units,
               expiry=expiry,
               price=price,
               lowerBound=lower_bound,
               upperBound=upper_bound,
               stopLoss=stop_loss,
               takeProfit=take_profit,
               trailingStop=trailing_stop)
  request(oanda, endpoint, method=PATCH, params=list(body=body))
}

#' Close an order
#'
#' Close an order.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/orders/#closeOrder}
#'
#' @param order_id string. order ID.
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default (default value is \code{NULL}).
#'
#' @export
close_order <- function(oanda, order_id, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders/%s", account_id_inner(oanda, account_id), order_id)
  request(oanda, endpoint, method=DELETE)
}
