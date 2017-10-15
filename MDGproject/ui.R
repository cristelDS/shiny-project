#author: Cristel Santos
#date: 14 Oct 2017

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(title = h3("Millennium Development Goals Indicators", align = "left")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(position = "right",
    sidebarPanel(h4("How have MDG Indicators evolved throughout the years?"), 
                 br(),
                 sliderInput("slideyear", "Select the year", min = 1997, max = 2007, value = 1997, sep = "", step = 1 , animate = T),
                 br(),
                 selectInput("selectindic", "Select the Indicator", choices = indic, selected = indic[1], multiple = T)),
    
    mainPanel(h4("Visual of progress of the different MDG indicators"), 
              textOutput("selecyear"),
              plotOutput("myplot"),
              br(),
              br(),
              h6("Source of data:", a("The official United Nations website for the MDG indicators", href="https://mdgs.un.org/unsd/mdg/Host.aspx?Content=Indicators/About.htm")),
              h6(textOutput("now")))
    )
  
  )
)


