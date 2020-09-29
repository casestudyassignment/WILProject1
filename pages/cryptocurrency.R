# CRYPTOCURRENCY UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_crypto_visualisation <- tabItem(tabName = "dataVisCrypto",
                                    tabsetPanel(
                                      tabPanel("Data Viewer",
                                               class = "data_viewer",
                                               inputPanel(selectInput("SelectedCryptoTable",
                                                                      label="Select one",
                                                                      choices=c("BCH-AUD", "BNB-AUD", "BTC-AUD", "EOS-AUD", "ETH-AUD", 
                                                                                  "LINK-AUD", "LTC-AUD", "TRX-AUD", "USDT-AUD", "XRP-AUD"))),
                                               fluidPage(conditionalPanel(
                                                 condition = "input.SelectedCryptoTable != ''",
                                                 fluidRow(uiOutput("cryptoPlotTable")
                                               ))
                                      )
                                    ),
                                    tabPanel("Data Visualisation",
                                             h2("Data Visualisation for Covid Crypto Currency")
                                             )
                                    )
                                    )

tab_crypto_modelling <- tabItem(tabName = "dataModelCrypto",
                                h2("Data Modelling for Covid Government Crypto Currency"),
                                fluidPage(
                                  selectInput("SelectedCryptoCM",label = "Select one:",
                                              c("BCH-AUD", "BNB-AUD", "BTC-AUD", "EOS-AUD", "ETH-AUD", 
                                              "LINK-AUD", "LTC-AUD", "TRX-AUD", "USDT-AUD", "XRP-AUD")),
                                  conditionalPanel(
                                    condition = "input.SelectedCryptoCM != ''",
                                    fluidPage(
                                      fluidRow(uiOutput("cryptoPlotPredictionBox"))
                                    )
                                )
                                
                            )
                        )
