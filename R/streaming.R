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
