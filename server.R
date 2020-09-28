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
library(tidyquant)

source('servers/util.R')
source('servers/governmentServer.R')
source('servers/stockServer.R')
source('servers/cryptoServer.R')


server <- function(input, output) {
  # GOVERNMENT PAGE SERVER ####################################################
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



  # STOCKS PAGE SERVER #######################################################
  # Data tables
  output$tableStockOverall <- renderDataTable(getOverallTable(), 
                                          options = list(pageLength = 15,
                                                         scrollX = TRUE) #Overall
  )
  
  output$tableStockBTC <- renderDataTable(getCSV("BTC-AUD.csv"), 
                                          options = list(pageLength = 15,
                                                         scrollX = TRUE) #BTC
  )
  
  # Other than BTC Stock - Tables
  SelectedStockTable <- reactive({
    strsplit(input$SelectedStockTable, " ")[[1]][1]
  })
  output$otherStocksTable <-renderDataTable(getOtherCompanyStockTable(SelectedStockTable()),
                                                                      options = list(pageLenth = 15,
                                                                                     scrollX = TRUE))
  
  output$otherStockTableBox <- renderUI({
    validate(
      need(SelectedStockTable(), "Please enter a valid title!")
    )
    box(title = paste(SelectedStockTable(), "Stock Table"),
        width = 12,
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        dataTableOutput('otherStocksTable'))
  })
  

  # Data plots
  output$plotStockBTC <-renderPlot({getStockBTCPlot()}) #BTC

  # Other than BTC Stock - Charts
  SelectedStockPlot <- reactive({
    strsplit(input$SelectedStockPlot, " ")[[1]][1]
  })
  
  output$otherStocksPlot1 <-renderPlot({getOtherCompanyStockPlot1(SelectedStockPlot())})
  output$otherStockPlotBox1 <- renderUI({
    validate(
      need(SelectedStockPlot(), "Please enter a valid title!")
    )
    box(title = paste(SelectedStockPlot(), "Stock Plot 1"),
        width = 12,
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("otherStocksPlot1"))
  })
  
  output$otherStocksPlot2 <-renderPlot({getOtherCompanyStockPlot2(SelectedStockPlot())})
  output$otherStockPlotBox2 <- renderUI({
    validate(
      need(SelectedStockPlot(), "Please enter a valid title!")
    )
    box(title = paste(SelectedStockPlot(), "Stock Plot 2"),
        width = 12,
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("otherStocksPlot2"))
  })
  
  output$otherStocksPlot3 <-renderPlot({getOtherCompanyStockPlot3(SelectedStockPlot())})
  output$otherStockPlotBox3 <- renderUI({
    validate(
      need(SelectedStockPlot(), "Please enter a valid title!")
    )
    box(title = paste(SelectedStockPlot(), "Stock Plot 3"),
        width = 12,
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("otherStocksPlot3"))
  })
  
  # Stock Prediction
  SelectedStockPrediction <- reactive({
    strsplit(input$SelectedStockPrediction, " ")[[1]][1]
  })
  
  output$predictionStockPlot <- renderPlot({getPredictionStockPlot(SelectedStockPrediction())})
  output$predictionStockPlotBox <- renderUI({
    validate(
      need(SelectedStockPrediction(), "Pleas select one stock")
    )
    box(title = paste(SelectedStockPrediction(), "Stock Prediction"),
        width = 12,
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("predictionStockPlot"))
  })
  
  # CRYPTOCURRENCY PAGE SERVER #######################################################
  # Data Tables
  SelectedCryptoTable <- reactive({input$SelectedCryptoTable})
  output$cryptoData <- renderDataTable(getDisplayCryptoData(SelectedCryptoTable()),options = list(pageLength = 5,scrollX = TRUE))
  
  output$cryptoPlotTable <- renderUI({
    validate(
      need(SelectedCryptoTable(), "Please enter a valid title!")
    )
    box(title = SelectedCryptoTable(),
        width = 12,
        status = "primary", 
        solidHeader = TRUE,
        collapsible = TRUE,
        dataTableOutput('cryptoData'))
  })
  
  #Data Plot
  SelectedCryptoPlot <-reactive({input$SelectedCryptoPlot})
  output$cryptoDataPlot <- renderPlot({getCryptoPlot(SelectedCryptoPlot())})
  
  output$cryptoPlot <- renderUI({
    validate(
      need(SelectedCryptoPlot(), "Please enter a valid title!")
    )
    box(title = paste(SelectedCryptoPlot(), "Cryptocurrency visualisations (2020)"),
        width =12,
        status = "primary", 
        solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("cryptoDataPlot"))
  })


  ############################################################################

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
