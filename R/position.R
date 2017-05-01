#' @export
position_list <- function(oanda, instrument=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/positions", account_id_inner(oanda, account_id))
  if(!is.null(instrument)){
    endpoint <- paste0(endpoint, "/", instrument)
  }
  request(oanda, endpoint, method=GET)
}

#' @export
close_position <- function(oanda, instrument, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/positions/%s", account_id_inner(oanda, account_id), instrument)
  request(oanda, endpoint, method=DELETE)
}
