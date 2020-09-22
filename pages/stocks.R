# STOCKS UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_stocks_visualisation <- tabItem(tabName = "dataVisStocks",
                                    tabsetPanel(
                                      tabPanel("Data Viewer",
                                               class = "data_viewer",
                                               inputPanel(selectInput("SelectedStockTable",
                                                                      label="Select one",
                                                                      choices=c("Overall Stocks", "BTC Stock"))),
                                               fluidPage(
                                                 conditionalPanel(
                                                   condition = "input.SelectedStockTable == 'Overall Stocks'",
                                                   h2("Overall Stocks Tables is selected")
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
                                                   )
                                                 )
                                               ),
                                      tabPanel("Data Visualisation",
                                               inputPanel(selectInput("SelectedStockPlot",
                                                                      label="Select one",
                                                                      choices=c("Overall Stocks", 
                                                                                "BTC Stock",
                                                                                "CBA Stock",
                                                                                "DOW Stock",
                                                                                "DRE Stock",
                                                                                "DRO Stock"))),
                                               fluidPage(
                                                 conditionalPanel(
                                                   condition = "input.SelectedStockPlot == 'Overall Stocks'",
                                                   h2("Overall Stocks Plots is selected")
                                                   ),
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
                                                   condition = "input.SelectedStockPlot == 'CBA Stock'||
                                                                input.SelectedStockPlot == 'DOW Stock'||
                                                                input.SelectedStockPlot == 'DRE Stock'",
                                                   fluidRow(box(title = "CBA Stocks Plot",
                                                                width = 12,
                                                                status = "primary", 
                                                                solidHeader = TRUE,
                                                                collapsible = TRUE,
                                                                plotOutput('plotOtherStocks'))
                                                            )
                                                   )
                                                 )
                                               )
                                      )
                                    )


tab_stocks_modelling <- tabItem(tabName = "dataModelStocks",
                                h2("Data Modelling for Covid Government (Banking)")
                                )