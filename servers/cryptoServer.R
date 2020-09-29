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
setwd("C:/GitHub/WILProject1")

getDisplayCryptoData <- function(input, output){
  data <- read_csv(paste0("data/", input, "_low.csv"))

  return(data)
}

getDisplayCryptoCM <- function(input, output){
  data <- readLines(paste0("data/", input, "_low.txt"))
  splitText <- stringi::stri_split(str = data, regex = '\n')
  replacedText <- lapply(splitText, p)

  return(replacedText)
}

getCryptoPlot <- function(input, output) {
  # Get data
  cryptoData <- getDisplayCryptoData(input)

  # cryptoplot
  cryptoPlot <- cryptoData %>%
    ggplot(aes(x = date, y = open)) +
    labs(x = "Date 2020", y = "close price (AUD)") +
    geom_point(data = cryptoData[cryptoData$test != 'training',], aes(colour = pred)) +
    geom_line() +
    coord_x_date(xlim = c("2020-01-20", "2020-02-30"), ylim = c(0, 1000))

  return(cryptoPlot)
}
