#author: Cristel Santos
#date created: 14 Oct 2017

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(title = h3("Millennium Development Goals (MDGs) Indicators", align = "left")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(position = "right",
    sidebarPanel(h4("How have MDGs Indicators evolved throughout the years?"), 
                 br(),
                 sliderInput("slideyear", "Select the year", min = 1997, max = 2007, value = 1997, sep = "", step = 1, animate = T),
                 br(),
                 selectInput("selectindic", "Select the Indicator", choices = unique(as.character(dat$serieName)), multiple = T)),
    
    mainPanel(
        tabsetPanel(
          
          tabPanel("Progress of MDGs indicators", 
              br(),
              h5("The visual representation below depicts how the indicators have changed over time, from 1997 to 2007 in all countries over the world."),
              textOutput("selecyear"),
              plotOutput("myplot"),
              br(),
              br(),
              h6("Source of data:", a("The official United Nations website for the MDGs indicators", href="https://mdgs.un.org/unsd/mdg/Host.aspx?Content=Indicators/About.htm")),
              h6(textOutput("now"))),
          
          tabPanel("About the MDGs Indicators", 
                  br(), 
                  h5("The Millennium Development Goals (MDGs) are international goals 
                  established following the Millennium Summit of the United Nations held in 2000. The framework of 
                  the MDG is made of 8 goals and 18 targets with complementary 48 technical indicators, used to 
                  monitor and measure progress towards the Millennium Goals. These were found adequate to describe 
                  the progress of global development."), br(), 
                  tags$p(h5("The eight goals are listed below:")),
                  tags$ol(
                      tags$li("To eradicate extreme poverty and hunger"),
                      tags$li("To achieve universal primary education"),
                      tags$li("To promote gender equality and empower women"),
                      tags$li("To reduce child mortality"),
                      tags$li("To improve maternal health"),
                      tags$li("To combat HIV/AIDS, malaria, and other diseases"),
                      tags$li("To ensure environmental sustainability"),
                      tags$li("To develop a global partnership for development")
                      )
                  ),

          tabPanel("App improvements?", 
                   br(),
                   h5("These are some considerations had while developping this app in where to take this next."),
                   tags$p(h5("_______________________________________________")),
                   tags$ol(
                     tags$li("Add option to upload or read from external source"),
                     tags$li("Some countries have no information on their indicators for some years where 
                             the data is scarse. Missing data needs to be considered and highling this."),
                     tags$li("Hover over data points to show which country and indicator"),
                     tags$li("...."),
                     tags$li("...."),
                     tags$li("...."),
                     tags$li("...."),
                     tags$li("....")
                   )
                   )))
    )
  
  )
)


mainPanel(
  tabsetPanel(
    tabPanel("Plot", plotOutput("plot")),
    tabPanel("Summary", verbatimTextOutput("summary")),
    tabPanel("Table", tableOutput("table"))
  )
)

