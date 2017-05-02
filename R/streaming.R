#' Rates Streaming
#'
#' Open a streaming connection to receive real time market prices for specified instruments.
#' See the following link for further information:
#' \url{http://developer.oanda.com/rest-live/streaming/#ratesStreaming}
#'
#' @param instruments: Required An URL encoded comma (%2C) separated list of instruments to fetch prices for.
#' @param call_back call back function which have a one argument (data.frame).
#' @param ignore_heartbeat boolean. whether ignore heart beat signal from OANDA Streaming API.
#' @param session_id: A unique session id used to identify the rate stream connection. The value specified must be between 1 to 12 alphanumeric characters. If a request is made with a session id that matches the session id of an existing connection, the older connection will be disconnected. Please see the best practices section for usage examples.
#' @param account_id: The account that prices are applicable for.
#'
#' @export
streaming_price <- function(oanda, instruments, call_back, ignore_heartbeat=TRUE, session_id=NULL, account_id=NULL)
{
  endpoint <- "/v1/prices"
  query <- Filter(Negate(is_empty), list(
    accountId=account_id_inner(oanda, account_id),
    instruments=paste(instruments, collapse=","),
    sessionId=session_id
  ))

  url <- paste0("https://", oanda$domain$streaming, endpoint)
  httr::GET(url, header(oanda$token), query=query, write_stream(function(x) {
    jsons <- strsplit(rawToChar(x), '(\r\n|\n)')[[1]]
    df <- na.omit(dplyr::bind_rows(lapply(jsons, function(json){
      if(!ignore_heartbeat || !str_detect(json, "heartbeat")){
        json_to_df(json)
      }
    })))
    if(nrow(df) >= 1){
      call_back(tidy_df(df))
    }
  }))
}

#' Events Streaming
#'
#' Open a streaming connection to receive real time authorized accounts' events.
#'
#' @export
streaming_event <- function(oanda, instruments, session_id=NULL, account_ids=NULL)
{
  endpoint <- "/v1/events"
  query <- Filter(Negate(is_empty), list(accountIds=account_id_inner(oanda, account_ids)))

  url <- paste0("https://", oanda$domain$streaming, endpoint)
  httr::GET(url, header(oanda$token), query=query, write_stream(function(x) {
    print((rawToChar(x)))
  }))
}

streaming_common <- function(oanda, endpoint, query, f)
{
  url <- paste0("https://", oanda$domain$streaming, endpoint)
  httr::GET(url, header(oanda$token), query=query, write_stream(function(x) {
    f(x)
  }))
}
