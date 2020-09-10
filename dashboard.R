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
  menuItem("COVID Stocks", tabName = "COVID Stocks", icon = icon("chart-bar", lib = "font-awesome")),
  menuItem("COVID Government", tabName = "COVID Government", icon = icon("book")),
  menuItem("COVID Cryptocurrency", tabName = "COVID Cryptocurrency", icon = icon("money")),
  menuItem("COVID Ecommerce", tabName = "COVID Ecommerce", icon = icon("shopping-cart", lib = "font-awesome")),
  menuItem("COVID Banking", tabName = "COVID Banking", icon = icon("piggy-bank", lib = "font-awesome"))
))

body <- dashboardBody(
  fluidRow(
    
    box(
      title = "Histogram", status = "primary", solidHeader = TRUE,
      collapsible = TRUE,
      plotOutput("plot1", height = 250)),
    
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
)

interface <- dashboardPage(header, sidebar, body)

#SERVER SIDE 

site <- function(input, output) { 
  #import dataset
  tbl <- read_csv("population.csv")
  
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
