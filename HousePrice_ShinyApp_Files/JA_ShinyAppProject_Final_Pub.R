#################################################################################################
# WELCOME TO THE SHINY APP, DEVELOPED BY JIBRIL ANIFOWOSHE. Please give proper credit if used. ##
# University of Missouri-St. Louis                                                             ##
# Course: INFSYS 6830, Tutored by Dr. Vivek K. Singh                                           ##
# Date: April 8th 2024                                                                         ##
# Note: This app was developed leveraging dataset from kaggle,                                 ##
# House prices dataset (train.csv file):                                                       ##
# ##https: //www .kaggle. com/competitions/house-prices-advanced-regression-techniques/data    ##
#################################################################################################

# Load required packages (assuming they are already installed)
library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(shinythemes)
library(GGally)
library(forcats)
library(reshape2)

# Server logic
server <- function(input, output, session) {
  # Load data reactively
  house_prices <- reactive({
    tryCatch({
      read.csv("data/train.csv")
    }, error = function(e) {
      showNotification("Error reading the CSV file. Please check the file path or file structure.", type = "error")
      return(NULL)
    })
  })
  
  # Display greeting message
  output$greeting <- renderText({
    paste("Hello", input$name, "- Welcome to the House Prices Analysis App! by Jibril Anifowoshe")
  })
  
  # Update input choices based on data
  observe({
    data <- house_prices()
    updateSelectInput(session, "xVariable", choices = names(data))
    updateSelectInput(session, "yVariable", choices = names(data))
  })
  
  # Render plots dynamically based on user input
  output$plotOutput <- renderPlotly({
    req(input$plotType, house_prices())
    data <- house_prices()
    
    plot <- switch(input$plotType,
                   "Histogram" = {
                     req(input$xVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]])) +
                       geom_histogram(bins = input$bins, fill = 'blue', color = 'black') +
                       labs(x = input$xVariable, title = paste("Histogram of", input$xVariable))
                   },
                   "Density Plot" = {
                     req(input$xVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]])) +
                       geom_density(fill = 'blue', alpha = 0.7) +
                       labs(x = input$xVariable, title = paste("Density Plot of", input$xVariable))
                   },
                   "Bar Plot" = {
                     req(input$xVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]], fill = .data[[input$xVariable]])) +
                       geom_bar() +
                       labs(x = input$xVariable, title = paste("Bar Plot of", input$xVariable))
                   },
                   "Scatter Plot" = {
                     req(input$xVariable, input$yVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]], y = .data[[input$yVariable]])) +
                       geom_point() +
                       labs(x = input$xVariable, y = input$yVariable, title = paste("Scatter Plot of", input$xVariable, "vs.", input$yVariable))
                   },
                   "Box Plot" = {
                     req(input$xVariable, input$yVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]], y = .data[[input$yVariable]])) +
                       geom_boxplot() +
                       labs(x = input$xVariable, y = input$yVariable, title = paste("Box Plot of", input$yVariable, "by", input$xVariable))
                   },
                   "Line Chart" = {
                     req(input$xVariable, input$yVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]], y = .data[[input$yVariable]], group = 1)) +
                       geom_line() +
                       labs(x = input$xVariable, y = input$yVariable, title = paste("Line Chart of", input$yVariable, "over", input$xVariable))
                   },
                   "Area Chart" = {
                     req(input$xVariable, input$yVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]], y = .data[[input$yVariable]], group = 1)) +
                       geom_area(fill = "lightblue", alpha = 0.5) +
                       geom_line(color = "blue") +
                       labs(x = input$xVariable, y = input$yVariable, title = paste("Area Chart of", input$yVariable, "over", input$xVariable))
                   },
                   "Heatmap" = {
                     numericalVars <- sapply(data, is.numeric)
                     numData <- data[, numericalVars, drop = FALSE]
                     corrMatrix <- cor(numData, use = "complete.obs")
                     melted_corr <- reshape2::melt(corrMatrix)
                     ggplot(melted_corr, aes(Var1, Var2, fill = value)) +
                       geom_tile() +
                       scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
                       theme_minimal() +
                       theme(axis.text.x = element_text(angle = 45, hjust = 1))
                   },
                   "Frequency Polygon" = {
                     req(input$xVariable)
                     ggplot(data, aes(x = .data[[input$xVariable]], color = .data[[input$xVariable]])) +
                       geom_freqpoly(binwidth = 1) +
                       labs(x = input$xVariable, title = paste("Frequency Polygon of", input$xVariable))
                   },
                   {
                     ggplot() +
                       geom_blank() +
                       ggtitle("Plot type not supported")
                   }
    )
    ggplotly(plot)
  })
  
  # Render data summary
  output$dataSummary <- renderPrint({
    req(house_prices())
    summary(house_prices())
  })
}

# Customized UI layout
ui <- fluidPage(
  shinythemes::themeSelector(),  # Adding a theme selector for all shinythemes
  titlePanel("SHINY APP - House Prices Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      textInput("name", "Enter your name:"),
      actionButton("greet", "Submit"),
      textOutput("greeting"),
      hr(),
      selectInput("plotType", "Choose a plot type:",
                  choices = c("Histogram", "Density Plot", "Bar Plot", "Scatter Plot", "Box Plot",
                              "Line Chart", "Area Chart", "Heatmap", "Frequency Polygon")),
      selectInput("xVariable", "X Variable:", choices = NULL),
      selectInput("yVariable", "Y Variable (for applicable plots):", choices = NULL),
      numericInput("bins", "Number of bins (for Histogram):", value = 30, min = 1),
      actionButton("generate", "Generate Plot")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotlyOutput("plotOutput")),
        tabPanel("Data Summary", verbatimTextOutput("dataSummary"))
      )
    )
  )
)

# Run the app
shinyApp(ui = ui, server = server)
