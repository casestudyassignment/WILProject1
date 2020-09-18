# SERVER SIDE FOR GOVERNMENT PAGE

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

getDisplayGovUnemploymentData <- function(input, output){
  data <- getCSV("unemployment_rate_updated.csv")
  names(data)[names(data) == "release_date"] <- "date"

  return(data)
}

getDisplayGovCovidData <- function(input, output) {
  data <- getCSV("covid_clean.csv")
  
  # Filtering out data from the clean dataset for only Australia 
  covid_subset <- data[,c(1,7,11)]
  covidAU_subset <- covid_subset  %>% filter(countries == "Australia")
  names(covidAU_subset)[names(covidAU_subset) == "dateRep"] <- "date"
  
  return(covidAU_subset)
}
  
getGovPlot1 <- function(input, output) {
  # Get data
  covidAU_subset <- getDisplayGovCovidData()
  unemploymentData <- getDisplayGovUnemploymentData()
  
  # Joining covid dataset with unemployment
  covid_unemp <- covidAU_subset %>% left_join(unemploymentData, by = "date")
  
  # Subsetting due to missing the first 20 rows 
  covid_unemp_new <- covid_unemp[-c(1:20),]
  
  # creating new column for data
  covid_unemp_my <- covid_unemp_new %>% mutate(date=dmy(date), 
                                               Month_yr = format_ISO8601(date, precision='ym'))
  names(covid_unemp_my)[names(covid_unemp_my) == "Cumulative_number_for_14_days_of_COVID-19_cases_per_100000"] <- "Cumulative_number"
  
  # New dataframe for time series data
  covid_unemp <- covid_unemp_my %>% select(Month_yr, Unemployment_rate, Cumulative_number) %>%
    gather(key = "variable", value = "value", -Month_yr)
  
  # ggplot 1
  plot <- ggplot(covid_unemp, aes(x=Month_yr, y = value)) + geom_line(aes(color = variable), size = 1) + scale_color_manual(values = c("#00AFBB", "#E7B800")) + theme_minimal()
  
  return(plot)
}

getGovPlot2 <- function(input, output) {
  covidData <- getCSV("au_covid.csv")
  unemploymentData <- getDisplayGovUnemploymentData()
  
  covidData[is.na(covidData)] = 0
  names(covidData)[names(covidData) == "Cumulative_number_for_14_days_of_COVID-19_cases_per_100000"] <- "Cumulative_number"
  unemploymentData <- unemploymentData[, c(1,2)]
  #df_unemployment=rename(df_unemployment, date = release_date)
  unemploymentData
  unemploymentData$date <- as.Date(paste(unemploymentData$date,"-01",sep=""))
  

  df <- covidData %>% left_join(unemploymentData,by = "date")
  df <- df[-c(1:20),]
  
  df<-separate(df, "date", c("Year", "Month", "Day"), sep = "-")
  
  df <- df %>%
    group_by(Month) %>%
    summarise_at(vars(countryCode), funs(mean(Unemployment_rate),mean(Cumulative_number)))
  
  df <- df[-c(9),] 
  
  df$Month[df$Month  == '01']  <-  'January'
  df$Month[df$Month  == '02']  <-  'Febrauary'
  df$Month[df$Month  == '03']  <-  'March'
  df$Month[df$Month  == '04']  <-  'April'
  df$Month[df$Month  == '05']  <-  'May'
  df$Month[df$Month  == '06']  <-  'June'
  df$Month[df$Month  == '07']  <-  'July'
  df$Month[df$Month  == '08']  <-  'August'
  
  
  # Rename Columns
  names(df)[names(df) == "mean..1"] <- "mean_unemployment_rate"
  names(df)[names(df) == "mean..2"] <- "mean_cumulative_number"
  
  barplot(df$mean_unemployment_rate, names.arg=df$Month, ylim=c(0,10), ylab="Unemployment Rates", xlab="Months")
  
  cols <- c('red','blue')
  par(lwd=6)
  barplot(
    t(df[c('mean_unemployment_rate','mean_cumulative_number')]),
    beside=T,
    ylim=c(0,30),
    border=cols,
    col='white',
    names.arg=df$Month,
    xlab='Month 2020',
    ylab='Frequency',
    legend.text=c('Unemployment rate','Cumulative_number_for_14_days_of_COVID-19_cases_per_100000'),
    args.legend=list(text.col=cols,col=cols,border=cols,bty='n')
  )
  plot <- box();
  
  return(plot)
}
