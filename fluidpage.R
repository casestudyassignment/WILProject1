install.packages("shiny", dependencies = TRUE)

library(shiny)

#making a simple UI
ui <- fluidPage(
  theme = "bootstrap.css",
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
    tags$style(HTML("
    @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
    h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
    }
    
    :root {
      --main-border: 1px solid #1f2f4d; 
    }
    
    html, body{
      display: flex;
      flex:1;
      height: 100%;
      color: #484848;
    }
    
    .container-fluid{
      display: flex;
      flex: 1;
      flex-direction: column;
    }
    
    .flex{
      display: flex;
    }
    
    .flex-row{
      flex-direction: row;
    }
    
    .flex-col{
      flex-direction: column;
    }
    
    #title-row{
        height: 56px;
        border-bottom: var(--main-border);
    }
      
    #dashboard-title{
      font-size: 20px;
      font-weight: 600;
      margin: auto 0;
      color: #2155b8;
    }
    
    #back-div{
      justify-content: flex-end;
    }
    
    #back-button{
      margin: auto 0 auto;
      text-decoration: none;
    }
    
    #content, #parameters-div{
      flex: 1;
    }
    
    #side-bar{
      padding: 20px 15px;
      border-right: var(--main-border); 
    }
    
    .title-label{
      font-size: 16px;
      color: #2155b8;
    }
    
    #parameters-div{
    
    }
    
    #run-button{
      width: 100%;
    }
    
    #main-dashboard{
    
    }
    
    "))
  ),
  
  fluidRow(
    id = "title-row",
    class = "flex", 
    column(class = "flex",
           4, 
           tags$div(
           class = "flex",
           tags$label(id = "dashboard-title", "Dashboard 1")
    )),
    column(id = "back-div",
           class="flex",
           2, offset = 6,
           actionLink("back-button", "Back"))
  ),
  fluidRow(
    id = "content",
    class = "flex",
    column(3, 
           id = "side-bar",
           class = "flex flex-col",
           tags$label(id = "title-label", "Parameter Settings"),
           tags$div(
             id = "parameters-div",
             class = "flex flex-col",
             h1("This will be the parameter settings!")
           ),
           fluidRow(
               column(12, 
                      actionButton("run-button", "Run"))
             )
           
    ),
    column(9, 
           id = "main-dashboard",
             "MAIN DASHBOARD")
  )
)

server <- function(input, output) { 
}

shinyApp(ui, server)

