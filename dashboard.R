install.packages("shinydashboard", dependencies = TRUE)
install.packages("shiny", dependencies = TRUE)

library(shinydashboard)
library(shiny)
library(readr)

#UI

#splitting parts easier readability
header <- dashboardHeader(title = "COVID-19 Finance Dashboard")

sidebar <- dashboardSidebar(sidebarMenu(
  sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                    label = "Search..."),
  menuItem("Data Visualisation", tabName = "Data_Visualisation", icon = icon("chart-bar", lib = "font-awesome"),
           startExpanded = TRUE,
           menuSubItem("Unemployment Rate", tabName = "Unemployment_Rate")),
  menuItem("COVID Stocks", tabName = "COVID_Stocks", icon = icon("chart-bar", lib = "font-awesome")),
  menuItem("COVID Government", tabName = "COVID_Government", icon = icon("book")),
  menuItem("COVID Cryptocurrency", tabName = "COVID_Cryptocurrency", icon = icon("money")),
  menuItem("COVID Ecommerce", tabName = "COVID_Ecommerce", icon = icon("shopping-cart", lib = "font-awesome")),
  menuItem("COVID Banking", tabName = "COVID_Banking", icon = icon("piggy-bank", lib = "font-awesome"))
))

body <- dashboardBody(
  tabItems(
    tabItem("Unemployment_Rate", 
            fluidPage(
              fluidRow("Charts"),
              fluidRow("Description")
            )),
    tabItem(tabName = "COVID_Stocks",
            fluidRow(
              box(
                title = "Histogram", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("plot1", height = 250)
              ),
              box(
                title = "Parameter Settings", status = "warning",solidHeader = TRUE,
                "Box content here", br(), "More box content",
                sliderInput("slider", "Slider input:", 1, 100, 50),
                textInput("text", "Text input:")
              ),
              box(
                title = "Table", status = "warning",solidHeader = TRUE,
                collapsible = TRUE,
                dataTableOutput('table')
              )
            )
    ),
    
    tabItem(tabName = "COVID_Government",
            h2("COVID Government tab content")
    ),
    
    tabItem(tabName = "COVID_Cryptocurrency",
            h2("COVID Cryptocurrency tab content")
    ),
    
    tabItem(tabName = "COVID_Ecommerce",
            h2("COVID Ecommerce tab content")
    ),
    
    tabItem(tabName = "COVID_Banking",
            h2("COVID Banking tab content")
    )
  )
)

interface <- dashboardPage(header, sidebar, body)

#SERVER SIDE 

site <- function(input, output) { 
  #import dataset
  tbl <- read_csv("small_covid_data.csv")
  
  output$table <- renderDataTable(tbl)
  
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

shinyApp(interface, site)
