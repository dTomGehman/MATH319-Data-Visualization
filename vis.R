#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("eBird Leaderboard Data"),

    navset_card_underline(
      nav_panel("Plot", 
                sidebarLayout(
                      sidebarPanel(
                          sliderInput("yrs",
                                      "Select Year (2026=All Years)",
                                      min = 2016,
                                      max = 2026,
                                      value = 2026)
                      ),
                      # Show a plot of the generated distribution
                      mainPanel(
                         plotOutput("test")
                      )
                )
      ),
      nav_panel("Plot2", 
                splitLayout(cellWidths = c("50%", "50%"), 
                            plotOutput("genusplot",   height = 1000, width=800), 
                            plotOutput("speciesplot", height = 1000, width=800)
                            )
      )
                
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  data = tibble(read.csv("birders.csv"))
  output$test <- renderPlot({
    # generate bins based on input$bins from ui.R
        
    #input$bins
    if (input$yrs == 2026) {
      dataf = data
    } else {
      dataf=filter(data, year==as.integer(input$yrs))
    }
    ggplot(dataf, aes(x=as.integer(Nchecklists), y=as.integer(Nspecies))) +
      geom_point(aes(colour=dayCt)) +
      xlim(0,600) + ylim(0,250) +
      xlab("Number of Checklists") + ylab("Number of Species")
  })
  
  output$genusplot = renderPlot({
    count(data,genus) %>% filter(n>7) %>%
      ggplot(aes(y = fct_reorder(genus, n), x = n)) +
      geom_col(width=0.9, position="dodge") +
      labs(x = "group") + 
      theme(text=element_text(size = 30))
  })
  
  output$speciesplot = renderPlot({
    count(data,species) %>% filter(n>7) %>%
      ggplot(aes(y = fct_reorder(species, n), x = n)) +
      geom_col(width=0.9, position="dodge") +
      labs(x = "group") + 
      theme(text=element_text(size = 30))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

  