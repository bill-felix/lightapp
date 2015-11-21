
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
shinyUI(fluidPage(verticalLayout(
            titlePanel("Michelson Speed of Light Data"),
            plotOutput("lightPlot"),
            wellPanel(sliderInput("run", 
                                  "Consectutive Runs", 
                                  min = 2, 
                                  max = 20, 
                                  value = 2)),
            plotOutput("aboutPlot")
            
        )
))
# shinyUI(pageWithSidebar(
#   
#   # Application title
#   headerPanel("Michelson Speed of Light Data"),
#   
#   # Sidebar with 
#   sidebarPanel(
#       selectInput("measure",
#                   "Choose a Measure:",
#                   choices = c("mean","sd","max","min","median")),
#       sliderInput("run",
#                   "Consectutive Runs",
#                   min = 2,
#                   max = 20,
#                   value = 3)
#   ),
#   # Show a plot
#   mainPanel(
#     plotOutput("lightPlot")
#   )
# ))
