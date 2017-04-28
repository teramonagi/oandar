

header <- function(token, headers=NULL)
{
  headers <- c(headers, "Authorization"=paste0("Bearer ", token))
  add_headers(.headers = headers)
}

domain <- function(account_type)
{
  if(account_type == "trade"){
    "api-fxpractice.oanda.com"
  } else {
    "api-fxpractice.oanda.com"
  }
}

#' @export
oanda_token <- function(token, account_type)
{
  result <- list(token=token, account_type=account_type, domain=domain(account_type))
  class(result) <- "oandar_token"
  result$account_id <- accounts(result)$account_id[1]
  result
}

POST <- function(oanda, endpoint, params)
{
  url <- paste0("https://", oanda$domain, endpoint)
  httr::POST(url, config=header(oanda$token, params$headers), body=params$body, encode="form")
}

GET <- function(oanda, endpoint, params)
{
  url <- paste0("https://", oanda$domain, endpoint)
  httr::GET(url, header(oanda$token), query=params$query)
}

request <- function(oanda, endpoint, method=GET, params=NULL)
{
  response <- method(oanda, endpoint, params)

  status <- http_status(response)

  to_df(response)
}


tidy_string <- function(x)
{
  x <- str_replace_all(x, "[:upper:]", '_\\0')
  x <- str_replace_all(x, ".+\\.", "")
  tolower(x)
}

to_df <- function(response)
{
  x <- fromJSON(httr::content(response, "text", encoding="utf-8"))
  if(is.null(unlist(x))){return(NULL)}

  is_dfs <- sapply(x, is.data.frame)
  df <- if(any(is_dfs)){
    indexes <- which(is_dfs)
    tmp <- dplyr::bind_rows(x[indexes])
    cbind(tmp, dplyr::bind_cols(x[-indexes]))
  } else{
    as.data.frame(t(unlist(x)))
  }
  colnames(df) <- tidy_string(colnames(df))
  df
}

account_id_inner <- function(oanda, account_id)
{
  if(is.null(account_id)){oanda$account_id}else{account_id}
}
