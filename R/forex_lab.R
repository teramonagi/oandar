#' @export
calendar <- function(oanda, period)
{
  endpoint <- "/labs/v1/calendar"
  query <- list(period=period)
  request(oanda, endpoint, params=list(query=query))
}

#' @param instrument Name of the instrument to retrieve historical position ratios for. Supported instruments: AUD_JPY, AUD_USD, EUR_AUD, EUR_CHF, EUR_GBP, EUR_JPY, EUR_USD, GBP_CHF, GBP_JPY, GBP_USD, NZD_USD, USD_CAD, USD_CHF, USD_JPY, XAU_USD, XAG_USD.
#' @param period  Period of time in seconds to retrieve historical position ratios data for. Values not in the following list will be automatically adjusted to the nearest valid value.
#' @export
position_ratio <- function(oanda, instrument, period)
{
  endpoint <- "/labs/v1/historical_position_ratios"
  query <- list(instrument=instrument, period=period)
  request(oanda, endpoint, params=list(query=query))
}


#' @param instrument Name of the instrument to retrieve spread data for. All tradable instruments are supported.
#' @param period Period of time in seconds to retrieve spread data for. Values not in the following list will be automatically adjusted to the nearest valid value.
#' @export
spread <- function(oanda, instrument, period)
{
  endpoint <- "/labs/v1/spreads"
  query <- list(instrument=instrument, period=period)
  request(oanda, endpoint, params=list(query=query))
}


#' @param instrument Name of the instrument to retrieve Commitments of Traders data for. Supported instruments: AUD_USD, GBP_USD, USD_CAD, EUR_USD, USD_JPY, USD_MXN, NZD_USD, USD_CHF, XAU_USD, XAG_USD.
#' @export
commitment <- function(oanda, instrument)
{
  endpoint <- "/labs/v1/commitments_of_traders"
  query <- list(instrument=instrument)
  request(oanda, endpoint, params=list(query=query))
}

#' @param instrument Name of the instrument to retrieve orderbook data for. Supported instruments: AUD_JPY, AUD_USD, EUR_AUD, EUR_CHF, EUR_GBP, EUR_JPY, EUR_USD, GBP_CHF, GBP_JPY, GBP_USD, NZD_USD, USD_CAD, USD_CHF, USD_JPY, XAU_USD, XAG_USD.
#' @param period Period of time in seconds to retrieve orderbook data for. Values not in the following list will be automatically adjusted to the nearest valid value.
#' @export
orderbook <- function(oanda, instrument, period)
{
  endpoint <- "/labs/v1/orderbook_data"
  query <- list(instrument=instrument, period=period)
  request(oanda, endpoint, params=list(query=query))
}
