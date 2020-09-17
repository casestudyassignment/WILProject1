library(shinydashboard)
library(shiny)
library(readr)
library(dplyr)
library(magrittr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(data.table)
library(xts)
library(plyr)
library(DT)


#splitting parts easier readability
header <- dashboardHeader(title = "COVID-19 Finance Dashboard")

sidebar <- dashboardSidebar(sidebarMenu(
  sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                    label = "Search..."),
  
  menuItem("COVID Stocks", 
           tabName = "covidStocks", 
           icon = icon("chart-bar", lib = "font-awesome")),
  
  menuItem("COVID Government", 
           tabName = "covidGov", 
           icon = icon("book"),
           menuSubItem("Data Visualisation", tabName = "dataVisGov"),
           menuSubItem("Data Modelling", tabName = "dataModelGov")),
  
  menuItem("COVID Cryptocurrency", 
           tabName = "covidCryptocurrency", 
           icon = icon("money")),
  
  menuItem("COVID Ecommerce", 
           tabName = "covidEcommerce", 
           icon = icon("shopping-cart", lib = "font-awesome"))
))

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  tabItems(
    tabItem(tabName = "covidStocks",
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

    tabItem(tabName = "dataVisGov",
            tabsetPanel(
              tabPanel("Data Viewer",
                       class = "data_viewer",
                       fluidRow(box(title = "Unemployment Rate (2019)",
                                    width = 12,
                                    status = "primary", 
                                    solidHeader = TRUE,
                                    collapsible = TRUE,
                                    dataTableOutput('tableGovUnemp'))
                                ),
                       fluidRow(box(title = "Unemployment Rate (COVID 2020)",
                                    width = 12,
                                    status = "primary", 
                                    solidHeader = TRUE,
                                    collapsible = TRUE,
                                    dataTableOutput('tableGovCovid'))
                                )
              ),
              tabPanel("Data Visualisation",
                       fluidPage(box(title = "Unemployment Rate Comparison Plot",
                                     width =12,
                                     status = "primary", 
                                     solidHeader = TRUE,
                                     collapsible = TRUE,
                                     plotOutput("plotCovidUnemp"))
                                 )
              )
            )
    ),
    
    tabItem(tabName = "dataModelGov",
            h2("Data Modelling for Covid Government (unemployment rate)")
    ),

    tabItem(tabName = "covidCryptocurrency",
            h2("COVID Cryptocurrency tab content")
    ),

    tabItem(tabName = "covidEcommerce",
            h2("COVID Ecommerce tab content")
    )
  )
)

  interface <- dashboardPage(header, sidebar, body)

#SERVER SIDE

site <- function(input, output) {
  #import datasets
  unemployment <- read_csv("data/unemployment_rate_updated.csv")
  covid <- read_csv("data/covid_clean.csv")
  
  ######################## GOVERNMENT - Unemployment Rate ##########################
  
  # filtering out data from the clean dataset for only australia 
  covid_subset <- covid[,c(1,7,11)]
  covidAU_subset <- covid_subset  %>% filter(countries == "Australia")
  names(covidAU_subset)[names(covidAU_subset) == "dateRep"] <- "release_date"
  
  #joining covid dataset with unemployment
  covid_unemp <- covidAU_subset %>% left_join(unemployment, by = "release_date")

  #subsetting due to missing the first 20 rows 
  covid_unemp_new <- covid_unemp[-c(1:20),]
 
  #creating new column for data
  covid_unemp_my <- covid_unemp_new %>% mutate(release_date=dmy(release_date), Month_yr = format_ISO8601(release_date, precision='ym'))
  names(covid_unemp_my)[names(covid_unemp_my) == "Cumulative_number_for_14_days_of_COVID-19_cases_per_100000"] <- "Cumulative_number"
  
  #new dataframe for time series data
  covid_unemp <- covid_unemp_my %>% select(Month_yr, Unemployment_rate, Cumulative_number) %>%
    gather(key = "variable", value = "value", -Month_yr)
  
  #ggplot 1
  covid_unemp_plot1 <- ggplot(covid_unemp, aes(x=Month_yr, y = value)) + geom_line(aes(color = variable), size = 1) + scale_color_manual(values = c("#00AFBB", "#E7B800")) + theme_minimal()
  
  #plot 2
    
    
  #outputting data tables
  output$tableGovUnemp <- renderDataTable(unemployment, options = list(pageLength = 5, 
                                                                       scrollX = TRUE))
  output$tableGovCovid <- renderDataTable(covidAU_subset, options = list(pageLength = 5))
  
  #outputting data PLOTS
  output$plotCovidUnemp <-renderPlot({covid_unemp_plot1})
  #output$covid_unemp_plot2 <-renderPlot({covid_unemp_plot2})
  
  ########################## ########################## ##########################
  

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

