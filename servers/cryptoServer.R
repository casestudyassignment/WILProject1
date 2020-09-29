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
library(caret)

source('servers/util.R')

getDisplayCryptoData <- function(input, output){
  data <- read_csv(paste0("data/", input, "_low.csv"))

  return(data)
}

#getDisplayCryptoCM <- function(input, output){
#  data <- readLines(paste0("data/", input, "_low.txt"))
#  splitText <- stringi::stri_split(str = data, regex = '\n')
#  replacedText <- lapply(splitText, p)
#
#  return(replacedText)
#}

getCryptoPlotPrediction <- function(input, output) {
  # Get data
  cryptoData <- getDisplayCryptoData(input)
  cryptoData <- cryptoData %>% filter(date >= "2020-01-01")
  cryptoData <- cryptoData %>% filter(date <= "2020-09-01")

  # cryptoplot
  min_value <- round(min(cryptoData$low))
  max_value <- round(max(cryptoData$low))
  
  cryptoPlot <- cryptoData %>%
    ggplot(aes(x = date, y = low)) +
    labs(x = "Date 2020", y = "Lowest price (AUD)") +
    geom_point(data = cryptoData[cryptoData$test != 'training',], aes(colour = pred)) +
    geom_line() +
    coord_x_date(xlim = c("2020-01-01", "2020-09-01"), ylim = c(min_value,max_value))

  return(cryptoPlot)
}

getCryptoConfusionMatrix <- function(input, output){
  # Get data
  cryptoData <- getDisplayCryptoData(input)
  confMatrix <- confusionMatrix(factor(cryptoData[cryptoData$test == 'test',]$pred), factor(cryptoData[cryptoData$test == 'test',]$true))

  return(confMatrix)
}

