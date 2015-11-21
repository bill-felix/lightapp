#lightapp ui


library(shiny)
shinyUI(fluidPage(verticalLayout(
            titlePanel("lightapp"),
            mainPanel(h3("We have preloaded Michelson's Speed of Light data and you can explore his experiments by advancing the slider below:")),
            mainPanel(h4("Notice how the Linear Model is adjusted as the experiment moves forward.")),
            plotOutput("lightPlot"),
            wellPanel(sliderInput("run", 
                                  "Consectutive Runs", 
                                  min = 2, 
                                  max = 20, 
                                  value = 2)),
            mainPanel(h4("Take a look at the changing boxplots while seeing the experiment's true Max, 75th Quantile, Mean, 25th Quantile, & Min.")),
            plotOutput("aboutPlot")
            
        )
))
