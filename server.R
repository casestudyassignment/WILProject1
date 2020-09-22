#SERVER SIDE

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
source('servers/governmentServer.R')
source('servers/stockServer.R')
source('servers/cryptoServer.R')


server <- function(input, output) {
  # GOVERNMENT PAGE SERVER
  # Data tables
  output$tableGovUnemp <- renderDataTable(getDisplayGovUnemploymentData(), 
                                          options = list(pageLength = 5, 
                                                         scrollX = TRUE)
                                          )
  
  output$tableGovCovid <- renderDataTable(getDisplayGovCovidData(), 
                                          options = list(pageLength = 5, 
                                                         scrollX = TRUE)
                                          )
  
  # Data Plots
  output$govPlot1 <-renderPlot({getGovPlot1()})
  output$govPlot2 <-renderPlot({getGovPlot2()})
  
  
  
  # STOCKS PAGE SERVER
  # Data tables
  # Overall Tables
  
  # BTC Stock Tables
  output$tableStockBTC <- renderDataTable(getCSV("BTC-AUD.csv"), 
                                          options = list(pageLength = 15, 
                                                         scrollX = TRUE)
  )
  
  # Data Plots
  # Overall Plots
  
  # BTC Plots
  output$plotStockBTC <-renderPlot({getStockBTCPlot()})
  
  #Crypto DataTable 
  output$cryptoData <- renderDataTable(getDisplayCryptoData(),options = list(pageLength = 5,scrollX = TRUE))
  #Crypto Plot
  output$cryptoPlot <- renderPlot({getCryptoPlot()})
  
  #output$table.output <- renderTable({
  #  mydata()
  #})
  
  #output$plot1 <- renderPlot({
  #  x <- tbl()[,1]
  #  plot(x)
  #})
  
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}