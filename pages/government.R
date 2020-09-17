# GOVERNMENT UI PAGE (VISUALISATION & MODELLING)

library(shinydashboard)
library(shiny)

tab_government_visualisation <- tabItem(tabName = "dataVisGov",
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
                                        )

tab_government_modelling <- tabItem(tabName = "dataModelGov",
                                    h2("Data Modelling for Covid Government (unemployment rate)")
                                    )