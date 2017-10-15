#author: Cristel Santos
#date created: 14 Oct 2017

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  #output$selecyear <- renderText(paste("you selected the value", input$slideyear))
  modified_date <- max(file.info(dir())[4][,1])
  output$now <- renderText(paste("This page was last updated on ", modified_date))
  
  output$myplot <- renderPlot({
    coln <- input$slideyear
    dat1 %>% 
      filter(dat1$serieName %in% input$selectindic, dat1$year == coln) %>% 
      ggplot(aes(serieCode,indicator, fill = serieName)) +
          geom_boxplot(outlier.colour = "seagreen", outlier.size = 1) +
          geom_jitter(size = 1) +
      # outlier.colour = "#1F3552", outlier.shape = 20
          # ylab(title(name = "Indicators") +
          # scale_x_discrete(NULL) +
          ggtitle(coln)
          #fill=serieCode, 
          # main=coln,
          # xlab="MDGs", 
          # ylab="indicators",
          # colour=serieCode)
  })
  })

