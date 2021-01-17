#load required packages
library(shiny)
library(dplyr)
suppressPackageStartupMessages(library(googleVis))


#build dataframe for creating plot
states <- data.frame(state.name, state.area, state.region,
                     hover=paste0(state.name, ": ", 
                                  state.area, " square miles"))
states$hover <- as.character(states$hover)

#Define server logic required to draw the plot
shinyServer(function(input, output) {
  
  output$plot1 <- renderGvis({
    
    #Rename slider values
    minarea <- input$area[1]
    maxarea <- input$area[2]
    
    #create vector containing values from checkboxes
    regions <- vector(length=4)
    regions[1] <- ifelse(input$NE, "Northeast", "")
    regions[2] <- ifelse(input$NC, "North Central", "")
    regions[3] <- ifelse(input$S, "South", "")
    regions[4] <- ifelse(input$W, "West", "")
    
    #filter data using slider and checkbox input
    plotdata <- states %>% 
      filter(state.area>minarea, state.area<maxarea) %>%
      filter(state.region %in% regions)
    
    #plot map
    gvisGeoChart(plotdata, 
                 locationvar="state.name", hovervar="hover",
                 options=list(region="US", displayMode="regions", 
                              resolution="provinces",
                              width=800, height=600))
    
  })
  
})