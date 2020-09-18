# SERVER SIDE FOR STOCK PAGE

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

source('servers/util.R')


getStockBTCPlot <- function(input, output){
  covidData <- getCSV("au_covid.csv")
  stockData <- getCSV("BTC-AUD.csv")
  
  covidData[is.na(covidData)] = 0
  
  # Join Dataset
  df <- covidData %>% left_join(stockData,by = "date")
  df <- separate(df, "date", c("Year", "Month", "Day"), sep = "-")
  
  df <- df %>%
    group_by(Month) %>%
    summarise_at(vars(countryCode), funs(mean(High),mean(Low),sum(cases)))
  
  # Remove the first 9 rows
  df <- df[-c(9),] 
  
  # Rename categories
  df$Month[df$Month  == '01']  <-  'January'
  df$Month[df$Month  == '02']  <-  'Febrauary'
  df$Month[df$Month  == '03']  <-  'March'
  df$Month[df$Month  == '04']  <-  'April'
  df$Month[df$Month  == '05']  <-  'May'
  df$Month[df$Month  == '06']  <-  'June'
  df$Month[df$Month  == '07']  <-  'July'
  df$Month[df$Month  == '08']  <-  'August'
  
  # Rename Columns
  names(df)[names(df) == "mean..1"] <- "mean_high_maximum_price_during_the_day"
  names(df)[names(df) == "mean..2"] <- "mean_low_minimum_price_during_the_day"
  names(df)[names(df) == "sum"] <- "sum_cases"
  
  cols <- c('red','blue','green');
  par(lwd=6);
  plot <- barplot(
    t(df[c('mean_high_maximum_price_during_the_day','mean_low_minimum_price_during_the_day','sum_cases')]),
    beside=T,
    ylim=c(0,25000),
    border=cols,
    col='white',
    names.arg=df$Month,
    xlab='Month 2020',
    ylab='Frequency',
    legend.text=c('Maximum price','Minimun Price','Cases of Covid'),
    args.legend=list(text.col=cols,col=cols,border=cols,bty='n')
  );
  
  return(plot)
}