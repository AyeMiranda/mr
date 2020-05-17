#' Queries historical exchange rates for any currency (so configurable symbol and base currency) for the past number of days
#' @export
#' @param curr_from string
#' @param curr_to string
#' @param days number
#' @importFrom httr GET
#' @import  data.table
convert_currency <- function(curr_from, curr_to, days) {
  curr_df <- GET(
    'https://api.exchangeratesapi.io/history?',
    query = list(
      start_at = Sys.Date() - days,
      end_at = Sys.Date(),
      base = curr_from,
      symbols = curr_to
    )
  )
  curr_df <- content(curr_df)$rates
  curr_df <- data.table(date = as.Date(names(curr_df)),
                   rate = unlist(curr_df))
  setorder(curr_df, date)

  date_df <- as.data.table(seq(Sys.Date()-days +1, Sys.Date(), "days"))[, .(date = V1)]
  setkey(date_df, "date")
  setkey(curr_df, "date")
  days_rates <- date_df[curr_df, roll = TRUE]
  print(days_rates)
}
