#SERVER SIDE CRYPTO SIDE

library(readr)
library(dplyr)
library(magrittr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(data.table)
library(xts)
library(plyr)
library(DT)
library(tidyquant)

source('servers/util.R')

getDisplayCryptoData <- function(input, output){
  currency_list = c("BCH-AUD", "BNB-AUD", "BTC-AUD", "EOS-AUD", "ETH-AUD", 
                    "LINK-AUD", "LTC-AUD", "TRX-AUD", "USDT-AUD", "XRP-AUD")
  
  #cur = currency_list[1]
  
  # data <- read_csv(paste0("data/", cur, "_low.csv"))
  data <- read_csv("data/BCH-AUD_low.csv")
  
  return(data)
}


getCryptoPlot <- function(input, output) {
  # Get data
  cryptoData <- getDisplayCryptoData()
  
  # cryptoplot
  cryptoPlot <- cryptoData %>%
    ggplot(aes(x = date, y = close)) +
    labs(title="cryptoData", x = "Date 2020", y = "close price (AUD)") +
    geom_point(data = cryptoData[cryptoData$test != 'training',], aes(colour = test)) +
    geom_line() +
    coord_x_date(xlim = c("2020-01-01", "2020-09-01"))
  
  return(cryptoPlot)
}