# Making an Interactive Web Application with R and Shiny

## Overview
This project is an interactive Shiny app that visualizes historical newspaper data from Britain and Ireland on a dynamic map. Users can filter by publication years and countries, providing a useful interface for exploring newspaper titles across time and region.

The application is built using **R**, **Leaflet**, and **Shiny**.

## Key Features
- **Dynamic Map**: Visualize newspaper data using Leaflet maps.
- **Filter Options**: Users can filter newspaper publications by years and specific countries.
- **Data Source**: Historical newspaper titles from Britain and Ireland.
- **Interactive User Interface**: Built using Shiny for a seamless web application experience.

## Application Structure
- **UI**: The user interface allows for selection of years and regions, and dynamically updates the map based on the inputs.
- **Server**: Processes the selected filters and updates the Leaflet map accordingly.
- **Map**: Uses Leaflet to display the filtered data interactively.

## Getting Started

### Prerequisites
You will need the following R packages to run the application:
- `shiny`
- `leaflet`
- `dplyr`

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Mwauramos/Making-an-Interactive-Web-Application-with-R-and-Shiny.git
   cd Making-an-Interactive-Web-Application-with-R-and-Shiny
