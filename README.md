# oandar
oandar is a R wrapper for the [OANDA REST API](http://developer.oanda.com/rest-live/introduction/).

# Installation

You can install oandar package from CRAN.
```
install.packages("githubinstall")
```
You can also install the package from GitHub.

```
install.packages("devtools") # if you have not installed "devtools" package
devtools::install_github("teramonagi/oandar")
```
The source code for githubinstall package is available on GitHub at

- https://github.com/teramonagi/oandar.

## Example
```
OANDA_TOKEN <- "your token here"
OANDA_ACCOUNT_TYPE <- "practice" #(or "trade")
token <- oandar_token(OANDA_TOKEN, OANDA_ACCOUNT_TYPE)
account <- accounts(token)
account_id <- account$accountId
account_information(token, account_id)

instruments <- c("USD_JPY", "EUR_JPY")
instrument_list(token, account_id, instruments)
current_price(token, instruments)


instrument <- "EUR_USD"
unit <- 2
side <- "sell"
type <- "market"
order <- create_order(token, instrument, unit, side, type)
```
