#' Get a list of open positions
#'
#' Get a list of open positions
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/positions/#getListAllOpenPositions}
#' \url{http://developer.oanda.com/rest-live/positions/#getPositionForInstrument}
#'
#' @param instrument Retrieve open positions for a specific instrument only. Default is all( \code{NULL}).
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default.
#'
#' @export
position_list <- function(oanda, instrument=NULL, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/positions", account_id_inner(oanda, account_id))
  if(!is.null(instrument)){
    endpoint <- paste0(endpoint, "/", instrument)
  }
  request(oanda, endpoint, method=GET)
}

#' Close an existing position
#'
#' Close an existing position
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/positions/#cloneExistingPosition}
#'
#' @param instrument Close an open position for a specific instrument only.
#' @param account_id string. The account id to fetch the list of tradeable instruments for. This value will be used if it is specified.
#'   If not specified, the value which OANDA object has inside is used as a default.
#'
#' @export
close_position <- function(oanda, instrument, account_id=NULL)
{
  endpoint <- sprintf("/v1/accounts/%s/positions/%s", account_id_inner(oanda, account_id), instrument)
  request(oanda, endpoint, method=DELETE)
}
