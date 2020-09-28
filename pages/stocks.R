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
                                                                                "CBA Stock",
                                                                                "DOW Stock",
                                                                                "DRE Stock",
                                                                                "DRO Stock"))),
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
                                                   condition = "input.SelectedStockTable == 'CBA Stock' ||
                                                                input.SelectedStockTable == 'DOW Stock' ||
                                                                input.SelectedStockTable == 'DRE Stock' ||
                                                                input.SelectedStockTable == 'DRO Stock'",
                                                   fluidRow(uiOutput("otherStockTableBox"))
                                                   )
                                                 )
                                               ),
                                      tabPanel("Data Visualisation",
                                               inputPanel(selectInput("SelectedStockPlot",
                                                                      label="Select one",
                                                                      choices=c("BTC Stock",
                                                                                "CBA Stock",
                                                                                "DOW Stock",
                                                                                "DRE Stock",
                                                                                "DRO Stock"))),
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
                                                   condition = "input.SelectedStockPlot == 'CBA Stock' ||
                                                                input.SelectedStockPlot == 'DOW Stock' ||
                                                                input.SelectedStockPlot == 'DRE Stock' ||
                                                                input.SelectedStockPlot == 'DRO Stock'",
                                                   fluidRow(uiOutput("otherStockPlotBox1")),
                                                   #fluidRow(uiOutput("otherStockPlotBox2")),
                                                   fluidRow(uiOutput("otherStockPlotBox3"))
                                                   )
                                                 )
                                               )
                                      )
                                    )


tab_stocks_modelling <- tabItem(tabName = "dataModelStocks",
                                h2("Data Modelling for Covid Government (Banking)")
                                )