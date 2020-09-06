install.packages("shinydashboard", dependencies = TRUE)
install.packages("shiny", dependencies = TRUE)

library(shinydashboard)
library(shiny)

#making a simple UI
dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)
