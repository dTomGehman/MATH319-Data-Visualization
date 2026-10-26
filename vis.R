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

    # Sidebar with a slider input for number of bins 
    # sidebarLayout(
    #     sidebarPanel(
    #         sliderInput("bins",
    #                     "Number of bins:",
    #                     min = 1,
    #                     max = 100,
    #                     value = 5)
    #     ),
    #     # Show a plot of the generated distribution
    #     mainPanel(
    #        plotOutput("test")
    #     )
    # )
    navset_card_underline(
      nav_panel("Plot", 
                sidebarLayout(
                      sidebarPanel(
                          sliderInput("bins",
                                      "Number of bins:",
                                      min = 1,
                                      max = 100,
                                      value = 5)
                      ),
                      # Show a plot of the generated distribution
                      mainPanel(
                         plotOutput("test")
                      )
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
        #dataf=filter(data, rank<=as.integer(input$bins))
        ggplot(data, aes(x=as.integer(Nchecklists), y=as.integer(Nspecies))) +
          geom_point(aes(colour=dayCt))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
