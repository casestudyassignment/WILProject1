library(shinydashboard)
library(shiny)

source('pages/stocks.R')
source('pages/government.R')
source('pages/cryptocurrency.R')
source('pages/ecommerce.R')

# splitting parts easier readability
header <- dashboardHeader(title = "COVID-19 Finance Dashboard")

sidebar <- dashboardSidebar(sidebarMenu(
  sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                    label = "Search..."),
  
  menuItem("COVID Stocks", 
           tabName = "covidStocks", 
           icon = icon("chart-bar", lib = "font-awesome"),
           startExpanded=TRUE,
           menuSubItem("Data Visualisation", tabName = "dataVisStocks"),
           menuSubItem("Data Modelling", tabName = "dataModelStocks")),
  
  menuItem("COVID Government", 
           tabName = "covidGov", 
           icon = icon("book"),
           menuSubItem("Data Visualisation", tabName = "dataVisGov"),
           menuSubItem("Data Modelling", tabName = "dataModelGov")),
  
  menuItem("COVID Cryptocurrency", 
           tabName = "covidCryptocurrency", 
           icon = icon("money"),
           menuSubItem("Data Visualisation", tabName = "dataVisCrypto"),
           menuSubItem("Data Modelling", tabName = "dataModelCrypto")),
  
  menuItem("COVID Ecommerce", 
           tabName = "covidEcommerce", 
           icon = icon("shopping-cart", lib = "font-awesome"),
           menuSubItem("Data Visualisation", tabName = "dataVisEcomm"),
           menuSubItem("Data Modelling", tabName = "dataModelEcomm"))
))

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  tabItems(
    tab_stocks_visualisation,
    tab_stocks_modelling,
    tab_government_visualisation,
    tab_government_modelling,
    tab_crypto_visualisation,
    tab_crypto_modelling,
    tab_ecomm_visualisation,
    tab_ecomm_modelling
  )
)

ui <- dashboardPage(header, sidebar, body)