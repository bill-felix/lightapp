# lightapp computations

library(shiny)
library(datasets)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
   
  output$lightPlot <- renderPlot({
    # create an empty list
    dat <- list()
    
    # use the slider input to determine how much data should be plotted
    run_number <- input$run
    selected_runs <- 2:run_number
    
    # build the necessary dataframe and populate the empty list
    for (n in selected_runs) {dat[[n-1]] = data.frame(morley) %>% filter(Run <= n) %>%
        group_by(Expt) %>% 
        summarize(Run = max(Run)
                  , Speed = last(Speed))}
    
    # stack the dataframes in the list
    library(data.table)
    tabl <- rbindlist(dat)
    
    
    library(RColorBrewer)
    # draw a plot showing changes occurring throughout consectutive runs per experiment
    g <- ggplot(tabl, aes(x = Run, y = Speed)) + geom_point(shape = 1) + geom_smooth(method=lm) +
        xlim(c(1,max(morley$Run))) + facet_grid(. ~ Expt) + 
        xlab("Runs in each Block") + ylab("Speed of Light km/s (minus 299,000)")
    g
  })
    output$aboutPlot <- renderPlot({
        dat <- list()
        
        # use the slider input to determine how much data should be plotted
        run_number <- input$run
        selected_runs <- 2:run_number
        
        # build the necessary dataframe and populate the empty list
        for (n in selected_runs) {dat[[n-1]] = data.frame(morley) %>% filter(Run <= n) %>%
            group_by(Expt) %>% 
            summarize(Run = max(Run)
                      , Speed = last(Speed)
                      , sd = sd(Speed)
                      , mean = mean(Speed))}
        
        # stack the dataframes in the list
        library(data.table)
        tabl <- rbindlist(dat)
        
        library(RColorBrewer)
        dd <- tabl %>% group_by(Expt) %>% ggplot() + 
            geom_boxplot(outlier.size = 4, aes(Run,Speed, fill = factor(Expt))) + 
            facet_grid(. ~ Expt) + scale_fill_brewer(palette="Set2") +
            xlim(c(1,max(morley$Run))) + xlab("Runs in each Block") + ylab("Speed of Light km/s (minus 299,000)") +
            guides(fill=F)
        dd
        # build a comparison table
        comp <- morley %>% group_by(Expt) %>% 
            summarize(max = max(Speed)
                      , min = min(Speed)
                      , mean = mean(Speed)
                      , sd = sd(Speed))
#         
#         # draw a plot showing changes occurring throughout consectutive runs per experiment
#         g <- ggplot(tabl, aes(x = Run, y = mean)) + geom_line()
#         gg <- g + xlim(c(1,20)) + facet_grid(. ~ Expt)
#         # gg <- g + geom_line(aes(color = factor(Expt))) + xlim(c(1,20)) + facet_grid(. ~ Expt)
        hh <- dd + geom_hline(aes(yintercept = max), data = comp, color = "red", linetype = "longdash") + 
            geom_hline(aes(yintercept = min), data = comp, color = "blue", linetype = "longdash") +
            geom_hline(aes(yintercept = mean), data = comp, linetype = "dashed")
        hh
        hh
#         jj <- hh + xlab("Run") +
#             ylab("Speed of Light (km/s minus 299,000)") +
#             scale_colour_discrete(guide = F)
#         jj
  })

})
