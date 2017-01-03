# oandar
R wrapper for the [OANDA REST API](http://developer.oanda.com/rest-live/introduction/).

## Example
```
OANDA_TOKEN <- "your token here"
OANDA_DOMAIN <- "api-fxpractice.oanda.com"
account <- accounts(OANDA_TOKEN, OANDA_DOMAIN)
account_id <- account$accountId
account_information(account_id, OANDA_TOKEN, OANDA_DOMAIN)

instruments <- c("USD_JPY", "EUR_JPY")
instrument_list(account_id, instruments, OANDA_TOKEN, OANDA_DOMAIN)
current_price(instruments, OANDA_TOKEN, OANDA_DOMAIN)

```
