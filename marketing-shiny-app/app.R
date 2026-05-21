library(shiny)
library(plotly)

marketing_data <- data.frame(
  Channel = c("Email", "Facebook", "Google", "Instagram", "YouTube"),
  Revenue = c(28000, 45000, 61000, 52000, 47000),
  Spend = c(9000, 15000, 22000, 18000, 14000),
  Conversions = c(700, 1200, 1800, 1400, 850)
)

ui <- fluidPage(
  
  titlePanel("Marketing Campaign Shiny Dashboard"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(
        "metric",
        "Choose Metric:",
        choices = c("Revenue", "Spend", "Conversions")
      )
      
    ),
    
    mainPanel(
      
      plotlyOutput("barplot"),
      
      br(),
      
      tableOutput("summary_table")
      
    )
    
  )
  
)

server <- function(input, output) {
  
  output$barplot <- renderPlotly({
    
    plot_ly(
      marketing_data,
      x = ~Channel,
      y = marketing_data[[input$metric]],
      type = "bar"
    ) %>%
      layout(
        title = paste(input$metric, "by Marketing Channel"),
        xaxis = list(title = "Channel"),
        yaxis = list(title = input$metric)
      )
    
  })
  
  output$summary_table <- renderTable({
    
    marketing_data
    
  })
  
}

shinyApp(ui = ui, server = server)