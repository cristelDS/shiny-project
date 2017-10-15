#author: Cristel Santos
#date created: 14 Oct 2017

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  modified_date <- max(file.info(dir())[4][,1])
  output$now <- renderText(paste("This page was last updated on ", modified_date))
  
  output$myplot <- renderPlot({
    coln <- input$slideyear
    dat1 %>% 
      filter(dat1$serieName %in% input$selectindic, dat1$year == coln) %>% 
      ggplot(aes(serieCode,indicator, fill = serieName)) +
          geom_boxplot(outlier.colour = "seagreen", outlier.size = 1) +
          geom_jitter(size = 1) +
          ggtitle(coln)
  })
  })

