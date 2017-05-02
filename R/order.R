#' @export
orders <- function(oanda, max_id=NULL, count=NULL, instrument=NULL, ids=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders", account_id_inner(oanda, account_id))
  query <- list(maxId=max_id, count=count, instrument=instrument, ids=ids)
  request(oanda, endpoint, method=GET, params=list(query=query))
}

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

#' @export
order_information <- function(oanda, order_id, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders/%s", account_id_inner(oanda, account_id), order_id)
  request(oanda, endpoint)
}

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

#' @export
close_order <- function(oanda, order_id, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders/%s", account_id_inner(oanda, account_id), order_id)
  request(oanda, endpoint, method=DELETE)
}
