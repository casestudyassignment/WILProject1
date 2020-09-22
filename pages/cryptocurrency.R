# CRYPTOCURRENCY UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_crypto_visualisation <- tabItem(tabName = "dataVisCrypto",
                                    h2("Data Visualisation for Covid Crypto Currency"),
                                    tabsetPanel(
                                      tabPanel("Data Viewer",
                                               class = "data_viewer",
                                               inputPanel(selectInput("SelectedCryptoTable",
                                                                      label="Select one",
                                                                      choices=c("BCH-AUD", "BNB-AUD", "BTC-AUD", "EOS-AUD", "ETH-AUD", 
                                                                                  "LINK-AUD", "LTC-AUD", "TRX-AUD", "USDT-AUD", "XRP-AUD"))),
                                               fluidRow(conditionalPanel(
                                                 condition = "input.SelectedCryptoTable != ''",
                                                 fluidRow(uiOutput("cryptoPlotTable")
                                               ))
                                      )
                                    ),
                                    tabPanel("Data Visualisation",
                                             inputPanel(selectInput("SelectedCryptoPlot",
                                                                    label="Select one",
                                                                    choices=c("BCH-AUD", "BNB-AUD", "BTC-AUD", "EOS-AUD", "ETH-AUD", 
                                                                              "LINK-AUD", "LTC-AUD", "TRX-AUD", "USDT-AUD", "XRP-AUD"))),
                                             fluidRow(conditionalPanel(
                                               condition = "input.SelectedCryptoPlot != ''",
                                               fluidRow(uiOutput("cryptoPlot")
                                               ))
                                    )
    )
  )
)

tab_crypto_modelling <- tabItem(tabName = "dataModelCrypto",
                                h2("Data Modelling for Covid Government Crypto Currency")
)