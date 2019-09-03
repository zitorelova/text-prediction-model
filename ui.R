library(shiny)
library(shinyWidgets)

shinyUI(fluidPage(
  
  # Define the text input UI
  setBackgroundColor("#c2d4b4"), 
  h1("Text Prediction Model"),
  h4("Written by: Zito Relova"),
  br(),
  sidebarLayout(
    sidebarPanel(
      textInput("textIn", "Input your text here and the model will predict the next word"),
      br()
    ),
    mainPanel("Predicted Word",
      verbatimTextOutput("pred")
    )
  )
))


