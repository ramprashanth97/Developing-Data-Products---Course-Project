#load shiny
library(shiny)

#Define UI for application 
shinyUI(fluidPage(
  titlePanel("Areas of US states"),
  sidebarLayout(
    sidebarPanel(
      h3("Pick an area range"),
      sliderInput("area",
                  "Square miles",
                  min = 1200,
                  max = 600000,
                  value = c(10000, 40000)),
      h3("Regions"),
      checkboxInput("NE", "Northeast", value=TRUE),
      checkboxInput("NC", "North Central", value=TRUE),
      checkboxInput("S", "South", value=TRUE),
      checkboxInput("W", "West", value=TRUE)
    ),
    
    
    mainPanel(
      htmlOutput("plot1")
    )
  )
))