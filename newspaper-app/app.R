library(tidyverse)
library(shiny)
library(sf)
library(leaflet)

# Load the datasets
title_list <- read_csv('BritishAndIrishNewspapersTitleList_20191118.csv')
coordinates_list <- read_csv('newspaper_coordinates.csv')

# Extract unique countries for the selectInput
country_choices <- c("All", unique(title_list$country_of_publication))

# Get the minimum and maximum years from the dataset
min_year <- min(title_list$first_date_held, na.rm = TRUE)
max_year <- max(title_list$first_date_held, na.rm = TRUE)

# Define UI
ui <- fluidPage(
  titlePanel("Newspaper Map"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput('years', 'Years', min = min_year, max = max_year, value = c(min_year, max_year)),
      selectInput('country', 'Country', choices = country_choices, selected = "All")
    ),
    
    mainPanel(
      leafletOutput(outputId = 'map')
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  map_df <- reactive({
    # Filter based on years
    filtered_data <- title_list %>%
      filter(first_date_held > input$years[1] & first_date_held < input$years[2])
    
    # Apply country filter if a specific country is selected
    if (input$country != "All") {
      filtered_data <- filtered_data %>%
        filter(country_of_publication == input$country)
    }
    
    # Count titles per city
    city_counts <- filtered_data %>%
      count(coverage_city, name = 'titles')
    
    # Join with coordinates and create sf object
    city_counts %>%
      left_join(coordinates_list, by = 'coverage_city') %>%
      filter(!is.na(lng) & !is.na(lat)) %>%
      st_as_sf(coords = c('lng', 'lat')) %>%
      st_set_crs(4326)
  })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -5, lat = 54, zoom = 5)
  })
  
  observe({
    data <- map_df()
    
    # Check if the filtered data is not empty
    if (nrow(data) > 0) {
      leafletProxy("map", data = data) %>%
        clearMarkers() %>%
        addCircleMarkers(radius = ~sqrt(titles), label = ~coverage_city)
    } else {
      # If no data, just clear the markers and keep the map
      leafletProxy("map") %>%
        clearMarkers()
    }
  })
}

# Run the Shiny app
shinyApp(ui, server)
