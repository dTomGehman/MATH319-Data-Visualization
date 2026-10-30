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
library(extrafont)
loadfonts(device = "win")

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("eBird Leaderboard Data, Cumberland County, 2016-2025", windowTitle = "eBird Leaderboard"),

    navset_card_underline(
      nav_panel("Number of Species and Checklists", 
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
                         plotOutput("test", height=600, width=1000)
                      )
                )
      ),
      nav_panel("Genera and Species", 
                splitLayout(cellWidths = c("40%", "60%"), 
                            plotOutput("genusplot",   height = 800, width=600), 
                            plotOutput("speciesplot", height = 800, width=1000)
                            )
      ),
      nav_panel("Timeline", 
                splitLayout(cellWidths = c("50%", "50%"), 
                            plotOutput("daysplot",   height = 800, width=800), 
                            plotOutput("dayshist", height = 800, width=800)
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
      geom_point() +
      xlim(0,700) + ylim(0,250) +
      xlab("Number of Checklists") + ylab("Number of Species") + 
      theme(text=element_text(size=20))+
      ggtitle("Checklists and Species", subtitle="Each birder's number of checklists and species in a year")
  })
  
  output$genusplot = renderPlot({
    count(data,genus) %>% filter(n>7) %>%
      ggplot(aes(y = fct_reorder(genus, n), x = n)) +
      geom_col(width=0.9, position="dodge") +
      labs(x = "Count", y="Genus", 
           title="Quantities of each Genus",
           caption="The genus of the last species each\n birder added to his/her year list") + 
      theme(text=element_text(size = 20, family="Consolas"))
  })
  
  output$speciesplot = renderPlot({
    count(data,species,commonName) %>% filter(n>7) %>%
      ggplot(aes(
        y = fct_reorder(
          paste(species, 
                #paste(replicate(nchar(species), "-"),collapse=""), 
                commonName, 
                sep=": "), n), 
        x = n)) +
      geom_col(width=0.9, position="dodge") +
      labs(x = "Count", y="Species", 
           title="Quantities of each Species", 
           caption="The last species birders added to their year lists") + 
      theme(text=element_text(size = 20, family="Consolas"))
  })
  
  output$daysplot = renderPlot({
    ggplot(data, aes(x=dayCt, y=percentTotal)) + geom_point() +
      theme(text=element_text(size = 30)) + 
      labs(x="Day of the year (starting at Jan 1 = 1)", 
           y="Percent of Total Species Observed",
           title="Date and Percent of Total Observed",
           caption="Last new observation date")
  })
  
  output$dayshist = renderPlot({
    ggplot(data, aes(x=dayCt)) + geom_histogram() +
      theme(text=element_text(size = 30)) +
      labs(x="Day of the year (starting at Jan 1 = 1)", y="Count", 
           title="Last New Species Observed Date")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

  