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
library(plotly)
library(quantmod)

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

getOtherCompanyStockTable <- function(input, output){
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
  
  return(df)
}

getOtherCompanyStockPlot3 <- function(input, output){
  df <- getOtherCompanyStockTable(input)
  
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

getOverallTable <- function(input, output){
  # Get data
  stockData <- getXLSX("Stocks.xlsx")
  covidData <- getCSV("covid_clean.csv")
  
  stockData$Date <-as.Date(as.character(stockData$Date),"%Y%m%d")
  stockData$Date <-as.Date(stockData$Date,"%d-%m%-Y")
  names(stockData)[names(stockData) == "Date"] <- "date"
  
  covidData <- covidData[,c(1,7,11)]
  covidData <- covidData %>% filter(countries == "Australia")
  names(covidData)[names(covidData) == "dateRep"] <- "date"
  covidData$date <-as.Date(covidData$date,"%d-%m-%Y")
  
  # Merge data
  df <- covidData %>%left_join(stockData,by="date")
  df <- na.omit(df)
  
  return(df)
}

getFilterOverallTable <- function(input, output){
  df <- getOverallTable()
  
  #filter out ticker
  df <- filter(df, Ticker == input) 
  return(df)
}

getOtherCompanyStockPlot2 <- function(input, output){
  df <- getFilterOverallTable(input)
  
  plot <- plot_ly(df, x = ~date, type="candlestick",
                  open = ~Open, close = ~Close,
                  high = ~High, low = ~Low) 
  
  #plot <- df %>% plot_ly(x = ~date, type="candlestick",
  #                      open = ~Open, close = ~Close,
  #                      high = ~High, low = ~Low) 
  #plot <- plot %>% layout(title = "Basic Candlestick Chart",
  #                      xaxis = list(rangeslider = list(visible = F)))
  
  return(plot)
}

getOtherCompanyStockPlot1 <- function(input, output){
  df <- getFilterOverallTable("CBA")
  
  plot <- ggplot(df, aes(x = date))+
    ggtitle("XNT Stock against Covid-19") +
    geom_line(aes(y = df$Open, color = "Open")) +
    geom_line(aes(y = df$Close, color = "Close")) +
    xlab("Date") + ylab("Stock Price") +
    theme(plot.title = element_text(hjust = 0.5), panel.border = element_blank()) +
    scale_x_date(breaks = "1 day",) +
    theme(axis.text.x=element_text(angle=45,hjust=1)) +
    scale_colour_manual("Series", values=c("Open"="gray40", "Close"="firebrick4"))
  
  return(plot)
}

# Get stock prediction plot
getPredictionStockPlot <- function(input, output){
  stock <- getCSV("predicted_stocks.csv")
  cases <- getCSV("covid_cases.csv")
  names(cases)[names(cases) == "Date_reported"] <- "Date"
  
  df <- stock %>% left_join(cases,by = "Date")

  title <- paste(input, "Stock Price Prediction")
  
  filtered_df <- select(df,contains(input))
  line1 <- round(as.double(unlist(filtered_df[,1])), 2)
  line2 <- round(as.double(unlist(filtered_df[,2])), 2)
  
  mean_value <- mean(line2)
  
  lockdown_stage <- data.frame(
    date = as.Date(c("2020-01-25", "2020-03-23", "2020-03-25", "2020-07-07", "2020-08-03")),
    stage = c("First Covid Case", "Stage 1", "Stage 2", "Stage 3", "Stage 4"),
    y = c(mean_value, mean_value, mean_value+1, mean_value, mean_value)
  )
  
  cases_max <- max(df$New_cases, na.rm = TRUE)
  line2_max <- max(line2, na.rm = TRUE)
  ratio_val <- cases_max/line2_max

  plot <- ggplot(df, aes(x = Date))+
    ggtitle(title) +
    geom_line(aes(y = line1, color = "Actual")) +
    geom_line(aes(y = line2, color = "Predicted")) +
    xlab("Date") + 
    geom_line(aes(y = New_cases/ratio_val, color = "New Cases")) +
    scale_y_continuous(name="Stock Price", sec.axis = sec_axis(~.*ratio_val, name="New Cases")) + 
    geom_vline(data = lockdown_stage, mapping=aes(xintercept=date), color="grey") +
    geom_text(data=lockdown_stage, mapping=aes(x=date, y=y, label=stage), size=3, angle=90, vjust=-0.4, hjust=0)
  plot
  return(plot)
}
