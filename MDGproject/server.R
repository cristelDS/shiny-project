#author: Cristel Santos
#date created: 14 Oct 2017

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #display date of last update 
  modified_date <- max(file.info(dir())[4][,1])
  output$now <- renderText(paste("This page was last updated on ", modified_date))
  
  #import data 
  dat <- read_csv("dataMdg.csv")
  
  #plot data 
  output$myplot <- renderPlot({
    coln <- input$slideyear
    dat %>% 
      filter(dat$serieName %in% input$selectindic, dat$year == coln) %>% 
      ggplot(aes(serieCode,indicator, fill = serieName)) +
          geom_boxplot(outlier.colour = "seagreen", outlier.size = 1) +
          geom_jitter(size = 1) +
          ggtitle(coln) + 
          stat_summary(geom = "crossbar", width=1.50, 
                       fatten=0, color="white", 
                       fun.data = function(x){ return(c(y=median(x)
                                                        , ymin=median(x)
                                                        , ymax=median(x))) }) +

          theme_set(theme_minimal()) +    
          theme(axis.title.y = element_blank()) +
          scale_y_continuous(breaks=seq(0, 1, 0.1)) +
          xlab("Indicators")
  })
  })

