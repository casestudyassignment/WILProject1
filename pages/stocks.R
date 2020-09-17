# STOCKS UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_stocks_visualisation <- tabItem(tabName = "dataVisStocks",
                                    h2("Data Visualisation for Covid Stocks (Banking)")
                                    )


tab_stocks_modelling <- tabItem(tabName = "dataModelStocks",
                                h2("Data Modelling for Covid Government (Banking)")
                                )