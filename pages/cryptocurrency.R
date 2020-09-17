# CRYPTOCURRENCY UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_crypto_visualisation <- tabItem(tabName = "dataVisCrypto",
                                    h2("Data Visualisation for Covid Crypto Currency")
)


tab_crypto_modelling <- tabItem(tabName = "dataModelCrypto",
                                h2("Data Modelling for Covid Government Crypto Currency")
)