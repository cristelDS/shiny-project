#author: Cristel Santos
#date created: 14 Oct 2017

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #display date of last update 
  modified_date <- max(file.info(dir())[4][,1])
  output$now <- renderText(paste("This page was last updated on ", modified_date))
  
  #plot data 
  output$myplot <- renderPlot({
    coln <- input$slideyear
    dat1 %>% 
      filter(dat1$serieName %in% input$selectindic, dat1$year == coln) %>% 
      ggplot(aes(serieCode,indicator, fill = serieName)) +
          geom_boxplot(outlier.colour = "seagreen", outlier.size = 1) +
          geom_jitter(size = 1) +
          ggtitle(coln) + 
          stat_summary(geom = "crossbar", width=0.65, 
                       fatten=0, color="white", 
                       fun.data = function(x){ return(c(y=median(x)
                                                        , ymin=median(x)
                                                        , ymax=median(x))) }) +
          #legend.title=element_blank() + 
          #panel.grid.major.x=element_blank() +
          theme_set(theme_minimal()) +    
          theme(axis.title.y = element_blank()) +
          scale_y_continuous(breaks=seq(0, 1, 0.1)) +
          xlab("Indicators")
  })
  })

