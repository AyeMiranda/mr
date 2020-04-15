#' Binance API to get most recent USD price of BTC
#' @export
#' @param retried the number of retries previously done
#' @importFrom binancer binance_coins_prices
get_bitcoin_price <- function(retried = 0) {
  tryCatch(binance_coins_prices()[symbol == 'BTC', usd],
           error = function(e) {
             # exponential backoff retries
             Sys.sleep(1)
             get_bitcoin_price(retried = retried + 1)})
}

#' Formatter function for HUF
#' @param x number
#' @export
#' @importFrom scales dollar
forint <- function(x) {
  dollar(x, prefix = '', suffix = 'Ft')
}
