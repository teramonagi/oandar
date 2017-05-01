

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

is_empty <- function(x){x == "" || is.null(x)}

POST <- function(oanda, endpoint, params)
{
  url <- paste0("https://", oanda$domain, endpoint)
  body <- Filter(Negate(is_empty), params$body)
  httr::POST(url, config=header(oanda$token, params$headers), body=body, encode="form")
}

PATCH <- function(oanda, endpoint, params)
{
  url <- paste0("https://", oanda$domain, endpoint)
  body <- Filter(Negate(is_empty), params$body)
  httr::PATCH(url, config=header(oanda$token, params$headers), body=body, encode="form")
}

DELETE <- function(oanda, endpoint, params)
{
  url <- paste0("https://", oanda$domain, endpoint)
  httr::DELETE(url, config=header(oanda$token, params$headers), encode="form")
}

GET <- function(oanda, endpoint, params)
{
  url <- paste0("https://", oanda$domain, endpoint)
  query <- Filter(Negate(is_empty), params$query)
  httr::GET(url, header(oanda$token), query=query)
}

request <- function(oanda, endpoint, method=GET, params=list(body=NULL, query=NULL))
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
    if(length(x[-indexes]) == 0){
      tmp
    } else{
      cbind(tmp, dplyr::bind_cols(x[-indexes]))
    }
  } else{
    as.data.frame(t(unlist(x)))
  }
  #Change column names
  colnames(df) <- tidy_string(colnames(df))
  #Convert time
  if("time" %in% colnames(df)){
    df$time <- lubridate::ymd_hms(df$time)
  }
  df
}

account_id_inner <- function(oanda, account_id)
{
  if(is.null(account_id)){oanda$account_id}else{account_id}
}

to_cs_string <- function(x){paste(x, collapse=",")}
