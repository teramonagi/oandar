#' @export
orders <- function(oanda, max_id=NULL, count=NULL, instrument=NULL, ids=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders", account_id_inner(oanda, account_id))
  query <- list(maxId=max_id, count=count, instrument=instrument, ids=ids)
  request(oanda, endpoint, method=GET, params=list(query=query))
}

#' @export
create_order <- function(oanda, instrument, units, side, type, expiry=NULL, price=NULL, lower_bound=NULL, upper_bound=NULL, stop_loss=NULL, take_profit=NULL, trailing_stop=NULL)
{
  endpoint <- "/v1/accounts"

  body <- list(instrument=instrument, units=units, side=side, type=type, expiry=expiry, price=price)

  request(oanda, endpoint, method=POST, params=list(body=body))
}

#' @export
order_information <- function(oanda, order_id, accound_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/orders/%s", account_id, order_id)
  request(oanda, endpoint)
}

modify_order <- function()
{

}

close_order <- function(token)
{

}
