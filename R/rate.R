#' Get an instrument list
#'
#' Get a list of tradeable instruments (currency pairs, CFDs, and commodities)
#'that are available for trading with the account specified.
#'
#' @export
instrument_list <- function(oanda, instruments=NULL, account_id=NULL)
{
  endpoint <- "/v1/instruments"
  query <- list(accountId = account_id_inner(oanda, account_id), instruments=paste(instruments, collapse=","))
  request(oanda, endpoint, method=GET, params=list(query=query))
}


#' @export
current_price <- function(oanda, instruments)
{
  endpoint <- "/v1/prices"
  query <- list(instruments=paste(instruments, collapse=","))
  request(oanda, endpoint, method=GET, params=list(query=query))
}

#' @export
instrument_history <- function(oand, instrument, granularity=NULL, count=NULL, start=NULL, end=NULL, candle_format=NULL, include_first=NULL, daily_alignment=NULL, alignment_timezone=NULL, weekly_alignment=NULL)
{
  endpoint <- "/v1/candles"
  query <- list(instrument=instrument, granularity=granularity, count=count, start=start, end=end, candle_format=NULL, includeFirst=include_first, dailyAlignment=daily_alignment, alignmentTimezone=alignment_timezone, weeklyAlignment=weekly_alignment)
  request(oanda, endpoint, method=GET, params=list(query=query))
}


