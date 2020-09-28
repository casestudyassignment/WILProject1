# STOCKS UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_stocks_visualisation <- tabItem(tabName = "dataVisStocks",
                                    tabsetPanel(
                                      tabPanel("Data Viewer",
                                               class = "data_viewer",
                                               inputPanel(selectInput("SelectedStockTable",
                                                                      label="Select one",
                                                                      choices=c("Overall Stocks", 
                                                                                "BTC Stock",
                                                                                "SYD Stock",
                                                                                "CWN Stock",
                                                                                "ASX Stock",
                                                                                "UBER Stock",
                                                                                "CSL Stock"))),
                                               fluidPage(
                                                 conditionalPanel(
                                                   condition = "input.SelectedStockTable == 'Overall Stocks'",
                                                   fluidRow(box(title = "Overall Stocks",
                                                                width = 12,
                                                                status = "primary", 
                                                                solidHeader = TRUE,
                                                                collapsible = TRUE,
                                                                dataTableOutput('tableStockOverall'))
                                                            )
                                                   ),
                                                 conditionalPanel(
                                                   condition = "input.SelectedStockTable == 'BTC Stock'",
                                                   fluidRow(box(title = "BTC Company Stock",
                                                                width = 12,
                                                                status = "primary", 
                                                                solidHeader = TRUE,
                                                                collapsible = TRUE,
                                                                dataTableOutput('tableStockBTC'))
                                                            )
                                                   ),
                                                 conditionalPanel(
                                                   condition = "input.SelectedStockPlot == 'SYD Stock' ||
                                                                input.SelectedStockPlot == 'CWN Stock' ||
                                                                input.SelectedStockPlot == 'ASX Stock' ||
                                                                input.SelectedStockPlot == 'UBER Stock'||
                                                                input.SelectedStockPlot == 'CSL Stock'",
                                                   fluidRow(uiOutput("otherStockTableBox"))
                                                   )
                                                 )
                                               ),
                                      tabPanel("Data Visualisation",
                                               inputPanel(selectInput("SelectedStockPlot",
                                                                      label="Select one",
                                                                      choices=c("BTC Stock",
                                                                                "SYD Stock",
                                                                                "CWN Stock",
                                                                                "ASX Stock",
                                                                                "UBER Stock",
                                                                                "CSL Stock"))),
                                               fluidPage(
                                                 conditionalPanel(
                                                   condition = "input.SelectedStockPlot == 'BTC Stock'",
                                                   fluidRow(box(title = "BTC Stocks Plot",
                                                                width = 12,
                                                                status = "primary", 
                                                                solidHeader = TRUE,
                                                                collapsible = TRUE,
                                                                plotOutput('plotStockBTC'))
                                                            )
                                                   ),
                                                 conditionalPanel(
                                                   condition = "input.SelectedStockPlot == 'SYD Stock' ||
                                                                input.SelectedStockPlot == 'CWN Stock' ||
                                                                input.SelectedStockPlot == 'ASX Stock' ||
                                                                input.SelectedStockPlot == 'UBER Stock'||
                                                                input.SelectedStockPlot == 'CSL Stock'",
                                                   fluidRow(uiOutput("otherStockPlotBox1")),
                                                   #fluidRow(uiOutput("otherStockPlotBox2")),
                                                   fluidRow(uiOutput("otherStockPlotBox3"))
                                                   )
                                                 )
                                               )
                                      )
                                    )


tab_stocks_modelling <- tabItem(tabName = "dataModelStocks",
                                inputPanel(selectInput("SelectedStockPrediction",
                                                       label="Select one",
                                                       choices=c("SYD Stocks", 
                                                                 "CWN Stock",
                                                                 "ASX Stock",
                                                                 "UBER Stock",
                                                                 "CSL Stock"))),
                                fluidPage(
                                  conditionalPanel(
                                    condition = "input.SelectedStockPrediction != ''",
                                    fluidRow(uiOutput("predictionStockPlotBox"))
                                    )
                                  )
                                )