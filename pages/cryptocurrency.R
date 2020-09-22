# CRYPTOCURRENCY UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_crypto_visualisation <- tabItem(tabName = "dataVisCrypto",
                                    h2("Data Visualisation for Covid Crypto Currency"),
                                    tabsetPanel(
                                      tabPanel("Data Viewer",
                                               class = "data_viewer",
                                               fluidRow(box(title = "Cryptocurrency Rate (2019)",
                                                            width = 12,
                                                            status = "primary", 
                                                            solidHeader = TRUE,
                                                            collapsible = TRUE,
                                                            dataTableOutput('cryptoData'))
                                               )
                                      ),
                                      tabPanel("Data Visualisation",
                                               fluidRow(box(title = "Cryptocurrency Predictions (2020)",
                                                            width =12,
                                                            status = "primary", 
                                                            solidHeader = TRUE,
                                                            collapsible = TRUE,
                                                            plotOutput("cryptoPlot"))
                                               )
                                      )
                                    )
)


tab_crypto_modelling <- tabItem(tabName = "dataModelCrypto",
                                h2("Data Modelling for Covid Government Crypto Currency")
)