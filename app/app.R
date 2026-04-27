library(shiny)
library(leaflet)
library(sf)
library(terra)

# Generate dummy spatial data for testing
nc <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)

ui <- fluidPage(
  titlePanel("Antigravity GIS Wasm Deploy"),
  sidebarLayout(
    sidebarPanel(
      helpText("Shiny app running in WebAssembly with sf, terra, and leaflet.")
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet(nc) %>%
      addTiles() %>%
      addPolygons(fillColor = "royalblue", weight = 2, opacity = 1, color = "white", dashArray = "3", fillOpacity = 0.7)
  })
}

shinyApp(ui = ui, server = server)
