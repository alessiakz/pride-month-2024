here::i_am("Code/app.R")

#libraries
library(tidyverse)
library(ggrepel) #makes it easy to auto position labels
library(ggtext) #add annotations that mix normal text with italic and bold text
library(shiny)
library(countrycode)

library(showtext)
font_add_google("Lato")
showtext_auto()

# data import
data <- read.csv(here::here("Data/lgbt-rights-index.csv"))

#filtering dataset to just countries
data_countries <- data %>% 
  filter(Code != "") %>% 
  rename(PolicyIndex = LGBT..Policy.Index) #renaming policy index column

#pulling continent info using countrycode package
data_countries$Continent <- countrycode(sourcevar = data_countries$Entity, origin = "country.name", destination = "continent")

# Define UI
ui <- fluidPage(
  titlePanel("Country Data by Continent"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Continent", "Select Continent:", choices = unique(data_countries$Continent))
    ),
    mainPanel(
      plotOutput("linePlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Filter data based on selected continent
  selected_continent_data <- reactive({
    filter(data_countries, Continent == input$Continent)
  })
  
  # Render line plot
  output$linePlot <- renderPlot({
    ggplot(selected_continent_data(), aes(x = Year, y = PolicyIndex, group=Entity, color=Entity)) +
      geom_line() +
      labs(title = paste("Countries in", input$Continent),
           x = "Year", y = "Policy Index")
  })
}
# Run the application
shinyApp(ui = ui, server = server)
