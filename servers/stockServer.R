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

getOtherCompanyStockPlot <- function(input, output){
  # Get data
  covidData <- getCSV("au_covid.csv")
  stockData <- getCSV("Stocks.csv")
  
  # table(stockData$Ticker)
  
  # Fill missing value and rename columns
  covidData[is.na(covidData)] = 0
  names(covidData)[names(covidData) == "Cumulative_number_for_14_days_of_COVID-19_cases_per_100000"] <- "cumulative_number"
  names(stockData)[names(stockData) == "Date"] <- "date"
  
  # Join Tables and omit missing values
  df <- covidData %>% left_join(stockData,by = "date")
  df<-separate(df, "date", c("Year", "Month", "Day"), sep = "-")
  df<-na.omit(df)
  
  
  df <- df %>%
    group_by(Month,Ticker) %>%
    summarise_at(vars(countryCode), funs(mean(High),mean(Low),mean(cumulative_number)))
  df <- df[-c(14548:15921),] 
  
  # Rename Rows
  df$Month[df$Month  == '01']  <-  'January'
  df$Month[df$Month  == '02']  <-  'Febrauary'
  df$Month[df$Month  == '03']  <-  'March'
  df$Month[df$Month  == '04']  <-  'April'
  df$Month[df$Month  == '05']  <-  'May'
  df$Month[df$Month  == '06']  <-  'June'
  df$Month[df$Month  == '07']  <-  'July'
  df$Month[df$Month  == '08']  <-  'August'
  
  # Rename columns
  names(df)[names(df) == "mean..1"] <- "mean_high_maximum_price_during_the_day"
  names(df)[names(df) == "mean..2"] <- "mean_low_minimum_price_during_the_day"
  names(df)[names(df) == "mean..3"] <- "sum_cases"
  
  # Filter the company's name
  df <- filter(df, Ticker == input) #filter for each company
  df
  
  # Generate plot
  cols <- c('red','blue');
  par(lwd=6);
  plot <- barplot(
    t(df[c('mean_high_maximum_price_during_the_day','mean_low_minimum_price_during_the_day')]),
    beside=T,
    ylim=c(0,100),#change this based on the company
    border=cols,
    col='white',
    names.arg=df$Month,
    xlab='Months 2020',
    ylab='Frequency',
    legend.text=c('Maximum price','Minimun Price'),
    args.legend=list(text.col=cols,col=cols,border=cols,bty='n')
  );
  
  return(plot);
}
